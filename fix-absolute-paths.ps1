# Script para corregir rutas absolutas restantes en HTML
$htmlFiles = Get-ChildItem -Recurse -Path "micrositio" -Filter "*.html"

Write-Host "Corrigiendo rutas absolutas restantes..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Corregir rutas absolutas que empiecen con /
    # Excepto enlaces externos y dns-prefetch
    $content = $content -replace 'href="/(?!.*://)([^"]*)"', 'href="./$1"'
    $content = $content -replace 'src="/(?!.*://)([^"]*)"', 'src="./$1"'
    
    # Correcciones específicas para subdirectorios
    if ($file.FullName -match "lab\\") {
        # Para archivos en lab/, cambiar ./ por ../
        $content = $content -replace 'href="\./(?!lab)', 'href="../'
        $content = $content -replace 'src="\./(?!lab)', 'src="../'
        # Mantener rutas lab internas como ./
        $content = $content -replace 'href="../lab/', 'href="./lab/'
        $content = $content -replace 'src="../lab/', 'src="./lab/'
    }
    
    if ($file.FullName -match "casos\\") {
        # Para archivos en casos/, cambiar ./ por ../
        $content = $content -replace 'href="\./(?!casos)', 'href="../'
        $content = $content -replace 'src="\./(?!casos)', 'src="../'
        # Mantener rutas casos internas como ./
        $content = $content -replace 'href="../casos/', 'href="./casos/'
        $content = $content -replace 'src="../casos/', 'src="./casos/'
    }
    
    if ($content -ne $originalContent) {
        $content | Out-File -FilePath $file.FullName -Encoding UTF8 -NoNewline
        Write-Host "Corregido: $($file.Name)"
    }
}

Write-Host "¡Corrección de rutas absolutas completada!"