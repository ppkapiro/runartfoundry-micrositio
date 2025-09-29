# Script para corregir rutas en archivos HTML
# PowerShell script to fix paths in HTML files

$micrositioPath = "C:\Users\pepec\Projects\RunArtFoundry\micrositio"
$htmlFiles = Get-ChildItem -Path $micrositioPath -Recurse -Filter "*.html"

Write-Host "Corrigiendo rutas en archivos HTML..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Corregir rutas CSS y JS
    $content = $content -replace 'href="/assets/', 'href="assets/'
    $content = $content -replace 'src="/assets/', 'src="assets/'
    
    # Corregir enlaces internos
    $content = $content -replace 'href="/"', 'href="index.html"'
    $content = $content -replace 'href="/index.html"', 'href="index.html"'
    $content = $content -replace 'href="/uldis.html"', 'href="uldis.html"'
    $content = $content -replace 'href="/run.html"', 'href="run.html"'
    $content = $content -replace 'href="/cronologia.html"', 'href="cronologia.html"'
    $content = $content -replace 'href="/evidencias.html"', 'href="evidencias.html"'
    $content = $content -replace 'href="/acciones.html"', 'href="acciones.html"'
    $content = $content -replace 'href="/contacto.html"', 'href="contacto.html"'
    $content = $content -replace 'href="/casos/"', 'href="casos/index.html"'
    $content = $content -replace 'href="/lab/"', 'href="lab/index.html"'
    
    # Corregir rutas relativas para subdirectorios
    if ($file.DirectoryName -like "*casos*") {
        $content = $content -replace 'href="assets/', 'href="../assets/'
        $content = $content -replace 'src="assets/', 'src="../assets/'
        $content = $content -replace 'href="index.html"', 'href="../index.html"'
        $content = $content -replace 'href="uldis.html"', 'href="../uldis.html"'
        $content = $content -replace 'href="run.html"', 'href="../run.html"'
        $content = $content -replace 'href="cronologia.html"', 'href="../cronologia.html"'
        $content = $content -replace 'href="evidencias.html"', 'href="../evidencias.html"'
        $content = $content -replace 'href="acciones.html"', 'href="../acciones.html"'
        $content = $content -replace 'href="contacto.html"', 'href="../contacto.html"'
        $content = $content -replace 'href="casos/index.html"', 'href="index.html"'
        $content = $content -replace 'href="lab/index.html"', 'href="../lab/index.html"'
    }
    
    if ($file.DirectoryName -like "*lab*") {
        $content = $content -replace 'href="assets/', 'href="../assets/'
        $content = $content -replace 'src="assets/', 'src="../assets/'
        $content = $content -replace 'href="index.html"', 'href="../index.html"'
        $content = $content -replace 'href="uldis.html"', 'href="../uldis.html"'
        $content = $content -replace 'href="run.html"', 'href="../run.html"'
        $content = $content -replace 'href="cronologia.html"', 'href="../cronologia.html"'
        $content = $content -replace 'href="evidencias.html"', 'href="../evidencias.html"'
        $content = $content -replace 'href="acciones.html"', 'href="../acciones.html"'
        $content = $content -replace 'href="contacto.html"', 'href="../contacto.html"'
        $content = $content -replace 'href="casos/index.html"', 'href="../casos/index.html"'
        $content = $content -replace 'href="lab/index.html"', 'href="index.html"'
    }
    
    # Guardar archivo
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Corregido: $($file.Name)"
}

Write-Host "¡Corrección de rutas completada!"