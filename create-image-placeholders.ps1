# Script para crear imágenes placeholder faltantes
$images = @(
    "williams-carmona.jpg",
    "maria-gonzalez.jpg", 
    "carlos-rivera.jpg",
    "lab/contraccion-metal.jpg",
    "lab/patina-quimica-natural.jpg",
    "lab/instalacion-estructural.jpg",
    "lab/moldeo-formas-complejas.jpg",
    "lab/mantenimiento-exterior.jpg",
    "lab/historia-fundicion-cuba.jpg",
    "authors/uldis-lopez.jpg",
    "authors/carlos-mendoza.jpg",
    "authors/maria-rodriguez.jpg",
    "casos/roman-hero.jpg"
)

$basePlaceholder = @"
<svg width="400" height="300" viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">
  <rect width="400" height="300" fill="#f0f0f0" stroke="#d0d0d0" stroke-width="2"/>
  <text x="200" y="140" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" fill="#888">
    RUN Art Foundry
  </text>
  <text x="200" y="160" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" fill="#aaa">
    FILENAME_PLACEHOLDER
  </text>
</svg>
"@

foreach ($imagePath in $images) {
    $fullPath = "micrositio\assets\images\$imagePath"
    $fileName = Split-Path $imagePath -Leaf
    $content = $basePlaceholder.Replace("FILENAME_PLACEHOLDER", $fileName)
    
    # Crear directorio si no existe
    $directory = Split-Path $fullPath -Parent
    if (!(Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force
    }
    
    # Crear archivo SVG
    $svgPath = $fullPath -replace '\.(jpg|jpeg|png)$', '.svg'
    $content | Out-File -FilePath $svgPath -Encoding UTF8
    
    Write-Host "Creado: $svgPath"
}

Write-Host "¡Placeholders de imágenes creados!"