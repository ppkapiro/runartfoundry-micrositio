# SCRIPT DE DEPLOY AUTOMÁTICO CON VALIDACIÓN TIPOGRÁFICA
# Este script debe ejecutarse SIEMPRE antes de deployar para garantizar calidad

Write-Host ""
Write-Host "🚀 INICIANDO PROCESO DE DEPLOY AUTOMATIZADO" -ForegroundColor Magenta
Write-Host "==========================================" -ForegroundColor Magenta
Write-Host ""

# PASO 1: Validación tipográfica automática
Write-Host "📝 PASO 1: Ejecutando validación tipográfica..." -ForegroundColor Cyan
.\validate-typography.ps1

Write-Host ""
Write-Host "⏳ Esperando 3 segundos antes del deploy..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# PASO 2: Deploy a Surge.sh
Write-Host ""
Write-Host "🌐 PASO 2: Desplegando a Surge.sh..." -ForegroundColor Cyan
npx surge . runartfoundry-micrositio.surge.sh

# PASO 3: Git commit y push
Write-Host ""
Write-Host "📦 PASO 3: Guardando cambios en Git..." -ForegroundColor Cyan
git add .

$commitMessage = "Auto-deploy: Validación tipográfica + deploy $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $commitMessage

Write-Host "📤 Subiendo cambios a GitHub..." -ForegroundColor Cyan
git push

# PASO 4: Resumen final
Write-Host ""
Write-Host "✅ ¡DEPLOY COMPLETADO EXITOSAMENTE!" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host "🌐 Sitio: https://runartfoundry-micrositio.surge.sh" -ForegroundColor White
Write-Host "📚 Repo: https://github.com/ppkapiro/runartfoundry-micrositio" -ForegroundColor White
Write-Host ""
Write-Host "🔍 PRÓXIMA VEZ: Ejecuta .\auto-deploy.ps1 para deploy completo" -ForegroundColor Yellow
Write-Host ""