#!/bin/bash
if [ -z ${ROKU_DEV_TARGET} ]; then
  echo "ERROR: ROKU_DEV_TARGET is not set.";
  exit 1;
fi

APP_ZIP_FILE=output.zip
DEV_SERVER_TMP_FILE=/tmp/dev_server_out

delete_temp_file() {
  rm -f ${DEV_SERVER_TMP_FILE}
}

display_padded_message() {
  echo ""
  echo $1
  echo ""
}

create_zip() {
  echo ""
  echo -n "Creating zip file..."

  rm ${APP_ZIP_FILE}
  zip -q ${APP_ZIP_FILE} manifest -r components images source

  echo "Done!"
}

HOST_OS=linux
QUICK_PING_ARGS='-c 1 -w 1'

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  HOST_OS=cygwin
  QUICK_PING_ARGS='-n 1 -w 1000'
fi

echo "Checking dev server at ${ROKU_DEV_TARGET}..."

# Ping device
ping ${QUICK_PING_ARGS} ${ROKU_DEV_TARGET} &> ${DEV_SERVER_TMP_FILE} ||
  (
    echo "ERROR: Device is not responding to ping.";
    exit 1
  )

delete_temp_file

# Check for ECP
curl --connect-timeout 2 --silent --output ${DEV_SERVER_TMP_FILE} \
		http://${ROKU_DEV_TARGET}:8060 ||
		(
			echo "ERROR: Device is not responding to ECP...is it a Roku?";
			exit 1
		)

ROKU_DEV_NAME=`cat ${DEV_SERVER_TMP_FILE} | \
		grep -o "<friendlyName>.*</friendlyName>" | \
		sed "s|<friendlyName>||" | \
		sed "s|</friendlyName>||"`

echo "Device reports name as \"${ROKU_DEV_NAME}\""

delete_temp_file

HTTP_STATUS=`curl --connect-timeout 2 --silent --output ${DEV_SERVER_TMP_FILE} \
  http://${ROKU_DEV_TARGET}` ||
  (
    echo "ERROR: Device server is not responding...is the developer installer enabled?";
    exit 1
  )

echo "Device is ready to go!"

create_zip

# Get developer account password
echo ""
echo -n "Developer account password: "
read -s USERPASS

display_padded_message "Uploading zip file to device..."

HTTP_STATUS=`curl --user "rokudev:${USERPASS}" --digest --silent --show-error \
		-F "mysubmit=Install" -F "archive=@${APP_ZIP_FILE}" \
		--output ${DEV_SERVER_TMP_FILE} \
		--write-out "%{http_code}" \
		http://${ROKU_DEV_TARGET}/plugin_install`

if [[ "$HTTP_STATUS" == 200 ]]; then
  echo "File uploaded successfully!"
elif [[ "$HTTP_STATUS" == 401 ]]; then
  echo "Oops! Looks like that was the wrong password perhaps?"
else
  echo "Error: Device returned HTTP ${HTTP_STATUS}"
fi
