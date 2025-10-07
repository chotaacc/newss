Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -ExecutionPolicy Bypass -File ""%userprofile%\NewProfile\NNv.ps1""", 0, True
