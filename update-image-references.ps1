# Script para actualizar referencias de imágenes a SVG
$htmlFiles = Get-ChildItem -Recurse -Path "micrositio" -Filter "*.html"

$imageUpdates = @{
    "williams-carmona.jpg" = "williams-carmona.svg"
    "maria-gonzalez.jpg" = "maria-gonzalez.svg"
    "carlos-rivera.jpg" = "carlos-rivera.svg"
    "contraccion-metal.jpg" = "contraccion-metal.svg"
    "patina-quimica-natural.jpg" = "patina-quimica-natural.svg"
    "instalacion-estructural.jpg" = "instalacion-estructural.svg"
    "moldeo-formas-complejas.jpg" = "moldeo-formas-complejas.svg"
    "mantenimiento-exterior.jpg" = "mantenimiento-exterior.svg"
    "historia-fundicion-cuba.jpg" = "historia-fundicion-cuba.svg"
    "uldis-lopez.jpg" = "uldis-lopez.svg"
    "carlos-mendoza.jpg" = "carlos-mendoza.svg"
    "maria-rodriguez.jpg" = "maria-rodriguez.svg"
    "roman-hero.jpg" = "roman-hero.svg"
}

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    $updated = $false
    
    foreach ($jpgFile in $imageUpdates.Keys) {
        $svgFile = $imageUpdates[$jpgFile]
        if ($content -match [regex]::Escape($jpgFile)) {
            $content = $content -replace [regex]::Escape($jpgFile), $svgFile
            $updated = $true
            Write-Host "Actualizado $jpgFile -> $svgFile en $($file.Name)"
        }
    }
    
    if ($updated) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
    }
}

Write-Host "¡Referencias de imágenes actualizadas!"