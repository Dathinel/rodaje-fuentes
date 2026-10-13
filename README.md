<p align="center">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://raw.githubusercontent.com/Dathinel/rodaje/main/assets/marca/rodaje.svg" alt="Logotipo de Rodaje" width="104"></a>
</p>

<h1 align="center">rodaje-fuentes</h1>

<p align="center">
  Complemento opcional para <a href="https://github.com/Dathinel/rodaje">Rodaje</a>: 10 familias tipográficas libres para títulos y subtítulos, sin modificar y con su licencia.
</p>

<p align="center">
  <a href="#licencia"><img src="https://img.shields.io/badge/fuentes-OFL_1.1-E8833A?style=flat-square&labelColor=1D1D1D" alt="Fuentes OFL 1.1"></a>
  <a href="https://github.com/Dathinel/rodaje-fuentes/releases/latest"><img src="https://img.shields.io/github/v/release/Dathinel/rodaje-fuentes?style=flat-square&labelColor=1D1D1D&color=E8833A&label=versi%C3%B3n" alt="Última versión"></a>
  <img src="https://img.shields.io/badge/contenido-10_familias-E8833A?style=flat-square&labelColor=1D1D1D" alt="Contenido: 10 familias">
  <img src="https://img.shields.io/badge/formato-.paquete-E8833A?style=flat-square&labelColor=1D1D1D" alt="Formato .paquete">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://img.shields.io/badge/para-Rodaje-E8833A?style=flat-square&labelColor=1D1D1D" alt="Para Rodaje"></a>
</p>

| Id | Familia | Para qué |
|---|---|---|
| `inter` | Inter | Sans neutra, de fina a negra |
| `montserrat` | Montserrat | Sans geométrica y ancha |
| `oswald` | Oswald | Condensada para titulares |
| `lora` | Lora | Serif para citas |
| `anton` | Anton | Display gruesa, impacto |
| `caveat` | Caveat | Manuscrita |
| `jetbrains-mono` | JetBrains Mono | Monoespaciada, máquina de escribir |
| `nunito` | Nunito | Redondeada y amable |
| `atkinson-hyperlegible-next` | Atkinson Hyperlegible Next | Subtítulos muy legibles |
| `noto-sans` | Noto Sans | Subtítulos en cualquier idioma europeo (latino extendido, griego, cirílico) |

Todas son variables (un archivo con todos los pesos, y otro con la cursiva) salvo Anton, que tiene un solo peso. Las usan los estilos de [rodaje-titulos](https://github.com/Dathinel/rodaje-titulos). Rodaje las registra solo para sí mismo, no en Windows.

## Instalar en Rodaje

En Rodaje, Complementos → Instalar lo baja, comprueba su firma y lo instala. A mano: descarga `rodaje-fuentes-<versión>.paquete` de las [releases](https://github.com/Dathinel/rodaje-fuentes/releases) y, en Rodaje, usa «Instalar desde archivo…» en Complementos o suéltalo sobre la biblioteca. Ocupa unos 5 MB. Más detalles en la [guía de complementos](https://github.com/Dathinel/rodaje/blob/main/docs/guia/complementos.md).

## Construir el paquete

```
powershell -NoProfile -ExecutionPolicy Bypass -File empaquetar.ps1
```

Solo hace falta Windows PowerShell 5.1 y conexión la primera vez. `bajar-fuentes.ps1` baja cada archivo de [google/fonts](https://github.com/google/fonts) fijado por commit y comprueba su SHA-256; luego `empaquetar.ps1` deja `dist\rodaje-fuentes-<versión>.paquete` con orden y fecha fijos: las mismas fuentes dan el mismo archivo byte a byte (SHA-256 de la 1.0.0: `5d01aeba…a8d1`).

| Archivo | Qué es |
|---|---|
| `paquete.json` | Manifiesto: 10 `font` con su `license` y sus archivos |
| `bajar-fuentes.ps1` | Commit de origen, nombres y SHA-256 de cada archivo; los deja en `fuentes/<id>/` |
| `generar.ps1` | Lo llama `empaquetar.ps1`: vuelve a comprobar las fuentes antes de armar el paquete |
| `empaquetar.ps1` | Arma el `.paquete` |

Los archivos no se tocan; solo los variables cambian de nombre al de la descarga de Google Fonts (`Inter[opsz,wght].ttf` → `Inter-VariableFont_opsz,wght.ttf`).

## Licencia

Las fuentes son de sus autores y van bajo la SIL Open Font License 1.1: la licencia literal de cada familia está en `fuentes/<id>/OFL.txt` dentro del paquete. Sus nombres reservados se respetan porque no se modifican. Los scripts y el manifiesto son CC0 1.0 (dominio público), ver `LICENSE`. El logotipo de Rodaje es marca de su autor y no forma parte de este contenido ([TRADEMARK.md](https://github.com/Dathinel/rodaje/blob/main/TRADEMARK.md)).
