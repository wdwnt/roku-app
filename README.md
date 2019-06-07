# WDWNT: The Roku App

### Quick start

Using your Roku remote, enter the following button sequence:

> :house: :house: :house: + :arrow_up_small: :arrow_up_small: + :arrow_forward: :arrow_backward: + :arrow_forward:  :arrow_backward: + :arrow_forward:

Follow the steps to activate developer mode on your Roku device. Save the IP address at the end of the process (_example: `http://192.168.1.195`_)

Enter the following IP address in a web browser, log-in with username `rokudev` and the password you set during the developer mode process.

Take any of the .zip files and upload/install to the developer application installer. Your Roku device will load the sample channel instantly.


### Development Environment

This is set up for VS Code. There is an incredibly helpful extension [here](https://marketplace.visualstudio.com/items?itemName=celsoaf.brightscript).

### Linux Development
 
Set your envionment variables
> export ROKU_DEV_TARGET=your ip from above

> export DEVPASSWORD=rokudev password

Make
> make install
