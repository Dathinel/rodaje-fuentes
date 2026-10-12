# Deja las fuentes de rodaje-fuentes en <Destino>\fuentes\, bajadas y comprobadas por bajar-fuentes.ps1.
# Lo llama empaquetar.ps1: así el paquete nunca lleva un archivo que no coincida con su SHA-256.
param([Parameter(Mandatory = $true)][string]$Destino)

$ErrorActionPreference = 'Stop'
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'bajar-fuentes.ps1') -Destino $Destino
exit $LASTEXITCODE
