sub init()
  m.top.functionName = "executeTask"
end sub

function executeTask() as void
  ? "Please implement function executeTask()"
end function

function createUrlTransfer(url)
  urlTransfer = CreateObject("roUrlTransfer")
  urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  urlTransfer.InitClientCertificates()
  urlTransfer.setUrl(url)
  return urlTransfer
end function

function getJson(urlTransfer)
  return ParseJson(urlTransfer.GetToString())
end function
