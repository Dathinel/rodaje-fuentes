# Baja las familias de rodaje-fuentes de github.com/google/fonts, fijadas por commit, y comprueba su SHA-256.
# Uso:
#   powershell -NoProfile -ExecutionPolicy Bypass -File bajar-fuentes.ps1 [-Destino <carpeta>]
# Deja cada familia en <Destino>\fuentes\<id>\ (por defecto, la carpeta del script) con su licencia literal (OFL.txt).
# Los archivos no se modifican: solo cambia el nombre de los variables, de Familia[ejes].ttf al de la descarga de
# Google Fonts (Familia-VariableFont_ejes.ttf), porque los corchetes son comodines en PowerShell.
# Lo que ya está y coincide con su SHA-256 no se vuelve a bajar. Sale con 0 si todo coincide.
param([string]$Destino = '')

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$Commit = 'bd8f81ddb5c74d5c8897b36ad88b440266245103'

# id, ruta en google/fonts, nombre local, SHA-256
$Archivos = @(
    @('inter', 'ofl/inter/Inter[opsz,wght].ttf', 'Inter-VariableFont_opsz,wght.ttf', '29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031'),
    @('inter', 'ofl/inter/Inter-Italic[opsz,wght].ttf', 'Inter-Italic-VariableFont_opsz,wght.ttf', 'acd98e64795781b2058f07b18475e0ecee2a0fe2b42a49e2f9e37d0d6bf66ce6'),
    @('inter', 'ofl/inter/OFL.txt', 'OFL.txt', '5b9321a4298cfeb6b34354164a1c3afc3db114569984c502b9b35d988fd58c57'),
    @('montserrat', 'ofl/montserrat/Montserrat[wght].ttf', 'Montserrat-VariableFont_wght.ttf', '0f7b311b2f3279e4eef9b2f968bcdbab6e28f4daeb1f049f4f278a902bcd82f7'),
    @('montserrat', 'ofl/montserrat/Montserrat-Italic[wght].ttf', 'Montserrat-Italic-VariableFont_wght.ttf', '51607f316bc020e59f03cbf51543eecffbea501c0b31d73e5b82927c5cca442c'),
    @('montserrat', 'ofl/montserrat/OFL.txt', 'OFL.txt', '8b7141c03fa4f8d44e6345d5d4931709290f0f67875e452e95ac1fd3a027802e'),
    @('oswald', 'ofl/oswald/Oswald[wght].ttf', 'Oswald-VariableFont_wght.ttf', '5b38c246e255a12f5712d640d56bcced0472466fc68983d2d0410ec0457c2817'),
    @('oswald', 'ofl/oswald/OFL.txt', 'OFL.txt', '0fd731a904b729a4e02eaf5e8ebd06783edd9abe400e8882760160230675b652'),
    @('lora', 'ofl/lora/Lora[wght].ttf', 'Lora-VariableFont_wght.ttf', '822a6621ccbe8d97d20ac88c1c41f5615c9c2c202eaa75f272cd452aac6475a7'),
    @('lora', 'ofl/lora/Lora-Italic[wght].ttf', 'Lora-Italic-VariableFont_wght.ttf', '22d8d8854b53807aa664ca34f2031a9ed57a1d0dea296b8b96cdd3aad937a2b3'),
    @('lora', 'ofl/lora/OFL.txt', 'OFL.txt', '1d9a970809ac804b582a6ce7f0ebc4e7fefcbfd7ff6299cad35ee656a21be716'),
    @('anton', 'ofl/anton/Anton-Regular.ttf', 'Anton-Regular.ttf', 'a4ba3a92350ebb031da0cb47630ac49eb265082ca1bc0450442f4a83ab947cab'),
    @('anton', 'ofl/anton/OFL.txt', 'OFL.txt', 'ee67e6ee22790b7929f1a3769ca2801d565c64b5a9096942c1adf5596de9c9e4'),
    @('caveat', 'ofl/caveat/Caveat[wght].ttf', 'Caveat-VariableFont_wght.ttf', '0bdb6b660482d31531b3945849fba5916b3ef8695da7024a9e6b9ee3c4157988'),
    @('caveat', 'ofl/caveat/OFL.txt', 'OFL.txt', '1f9d81d094273d82f3898a1ee8b598a717d050ecbf5ff7bede105b704880157b'),
    @('jetbrains-mono', 'ofl/jetbrainsmono/JetBrainsMono[wght].ttf', 'JetBrainsMono-VariableFont_wght.ttf', '48715a42ec242c21e9f02692891e147d022299a52e48d5e413e1a942193ffeda'),
    @('jetbrains-mono', 'ofl/jetbrainsmono/JetBrainsMono-Italic[wght].ttf', 'JetBrainsMono-Italic-VariableFont_wght.ttf', '85ae2a5cd3f56baf1ce1c21a851322c58e3d8fbe8e8ad4a4d090a820dd7fe558'),
    @('jetbrains-mono', 'ofl/jetbrainsmono/OFL.txt', 'OFL.txt', 'b2fe5e8987594e9ffd1d2ca52a2f5d73eb8335243893c5d6254b5ad69269591d'),
    @('nunito', 'ofl/nunito/Nunito[wght].ttf', 'Nunito-VariableFont_wght.ttf', 'bb55a5ca5c2042335b3991af27c4d0705d0ef41cac6164ac737fd8f2a1e85207'),
    @('nunito', 'ofl/nunito/Nunito-Italic[wght].ttf', 'Nunito-Italic-VariableFont_wght.ttf', 'b520cc871868b0acfca1beda875df7f4a44ebce914f8a89f83977fc9c09529c8'),
    @('nunito', 'ofl/nunito/OFL.txt', 'OFL.txt', '580df76c95a1ec5ab878ceb25bb3d85c6a076804e9c970c8c6972aea775fdf65'),
    @('atkinson-hyperlegible-next', 'ofl/atkinsonhyperlegiblenext/AtkinsonHyperlegibleNext[wght].ttf', 'AtkinsonHyperlegibleNext-VariableFont_wght.ttf', '5a455d1cfa099b601ab70751bb9673e8fe1854dc4500c80e1a220d0d75e31745'),
    @('atkinson-hyperlegible-next', 'ofl/atkinsonhyperlegiblenext/AtkinsonHyperlegibleNext-Italic[wght].ttf', 'AtkinsonHyperlegibleNext-Italic-VariableFont_wght.ttf', 'ce9cffed32742ad2d9238c561a93220385e5934cdc02b8eb4097a50efa957dc6'),
    @('atkinson-hyperlegible-next', 'ofl/atkinsonhyperlegiblenext/OFL.txt', 'OFL.txt', 'aca6a428580965d2297d1b718042dd427c2a9443ece3b0d02d758e161e0c4030'),
    @('noto-sans', 'ofl/notosans/NotoSans[wdth,wght].ttf', 'NotoSans-VariableFont_wdth,wght.ttf', 'bfb7bb691513f12e734dc346c03a03f784912432d7e3fa8e56efcf906fe86b3d'),
    @('noto-sans', 'ofl/notosans/NotoSans-Italic[wdth,wght].ttf', 'NotoSans-Italic-VariableFont_wdth,wght.ttf', '58e6e0ebd1931b29a365aa2d3e2ee9a9e831a3af7cf3ad1462d4e72154f0b291'),
    @('noto-sans', 'ofl/notosans/OFL.txt', 'OFL.txt', 'cee9892f9f0cc8fe882c9e9537ee6a89621d86ee7ceaf70b02e2b2b1c25c061a')
)

function Get-Sha256([string]$Ruta) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $flujo = [System.IO.File]::OpenRead($Ruta)
    try { return (-join ($sha.ComputeHash($flujo) | ForEach-Object { $_.ToString('x2') })) } finally { $flujo.Dispose(); $sha.Dispose() }
}

if (-not $Destino) { $Destino = $PSScriptRoot }
$Destino = [System.IO.Path]::GetFullPath($Destino)
$cliente = New-Object System.Net.WebClient
$bajados = 0
try {
    foreach ($a in $Archivos) {
        $carpeta = [System.IO.Path]::Combine($Destino, 'fuentes', $a[0])
        $ruta = [System.IO.Path]::Combine($carpeta, $a[2])
        if ([System.IO.File]::Exists($ruta) -and (Get-Sha256 $ruta) -eq $a[3]) { continue }
        [System.IO.Directory]::CreateDirectory($carpeta) | Out-Null
        $url = "https://raw.githubusercontent.com/google/fonts/$Commit/" + $a[1].Replace('[', '%5B').Replace(']', '%5D')
        $temporal = $ruta + '.bajando'
        $cliente.DownloadFile($url, $temporal)
        $hash = Get-Sha256 $temporal
        if ($hash -ne $a[3]) {
            [System.IO.File]::Delete($temporal)
            throw "$($a[1]): el SHA-256 es $hash y se esperaba $($a[3])."
        }
        if ([System.IO.File]::Exists($ruta)) { [System.IO.File]::Delete($ruta) }
        [System.IO.File]::Move($temporal, $ruta)
        $bajados++
    }
    Write-Host ("  {0} archivos de fuentes comprobados ({1} bajados) en {2}" -f $Archivos.Count, $bajados, (Join-Path $Destino 'fuentes')) -ForegroundColor Green
    exit 0
} catch {
    Write-Host "  No se pudieron bajar las fuentes: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
} finally {
    $cliente.Dispose()
}
