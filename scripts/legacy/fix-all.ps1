# Corrección masiva de caracteres especiales
 = @('cronologia.html', 'run.html', 'evidencias.html', 'contacto.html', 'acciones.html')

 = @{
    'NavegaciÃ³n' = 'Navegación'
    'menÃº' = 'menú'
    'CronologÃ­a' = 'Cronología'
    'Uldis LÃ³pez' = 'Uldis López'
    'FundiciÃ³n' = 'Fundición'
    'TÃ©cnicas' = 'Técnicas'
    'ExposiciÃ³n' = 'Exposición'
    'BiografÃ­a' = 'Biografía'
    'MigraciÃ³n' = 'Migración'
    'Establecimiento' = 'Establecimiento'
    'InvestigaciÃ³n' = 'Investigación'
    'estratÃ©gica' = 'estratégica'
    'artÃ­stica' = 'artística'
    'pÃ¡tinas' = 'pátinas'
    'â˜°' = '☰'
}

foreach ( in ) {
    if (Test-Path ) {
         = Get-Content  -Raw -Encoding UTF8
        foreach ( in .Keys) {
             =  -replace [regex]::Escape(), []
        }
        Set-Content  -Value  -Encoding UTF8
        Write-Host "Corregido: "
    }
}
