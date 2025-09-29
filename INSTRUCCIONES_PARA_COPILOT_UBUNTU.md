# INSTRUCCIONES COMPLETAS PARA GITHUB COPILOT - MIGRACIÓN A UBUNTU

## CONTEXTO CRÍTICO - LEE COMPLETAMENTE ANTES DE ACTUAR

### SITUACIÓN ACTUAL
Has sido llamado para continuar el trabajo en el **micrositio RUN Art Foundry** que previamente se desarrollaba en Windows PowerShell pero que **DEBE continuar EXCLUSIVAMENTE en Ubuntu WSL**.

### ESTADO DEL PROYECTO
- **Micrositio completo**: Funcional y desplegado en https://runartfoundry-micrositio.surge.sh
- **GitHub Repository**: https://github.com/ppkapiro/runartfoundry-micrositio
- **Archivos migrados**: Todos los archivos están copiados en `\\wsl.localhost\Ubuntu\home\pepe\work\micrositio`

### PROBLEMAS IDENTIFICADOS QUE DEBES RESOLVER
1. **Problemas tipográficos críticos**: Caracteres mal codificados como:
   - `Ã³` → `ó`
   - `âœ"` → `✓`
   - `ðŸ"‚` → `📂`
   - `ðŸŒ` → `🌍`
   - Y muchos otros caracteres Unicode/emoji

2. **Limitaciones de PowerShell**: Los scripts PowerShell fallan con caracteres Unicode
3. **Necesidad de herramientas Ubuntu**: Para mejor manejo de encoding UTF-8

## CONFIGURACIÓN DEL ENTORNO - OBLIGATORIO

### 1. VERIFICACIÓN DEL WORKSPACE
**CRÍTICO**: Debes trabajar desde el workspace Ubuntu: `\\wsl.localhost\Ubuntu\home\pepe\work\micrositio`

Verifica que estás en el lugar correcto:
```bash
pwd
# Debe mostrar: /home/pepe/work/micrositio
```

### 2. ESTRUCTURA DE ARCHIVOS ESPERADA
```
/home/pepe/work/micrositio/
├── index.html
├── acciones.html
├── contacto.html
├── cronologia.html
├── evidencias.html
├── run.html
├── uldis.html
├── casos/
│   ├── index.html
│   ├── raider.html
│   └── roman.html
├── lab/
│   └── index.html
├── assets/
│   ├── css/main.css
│   ├── js/main.js
│   ├── images/
│   └── data/
├── README.md
└── sw.js
```

### 3. HERRAMIENTAS DISPONIBLES
- **Git**: Disponible (`/usr/bin/git`)
- **Node.js**: NO instalado (sudo deshabilitado)
- **Bash**: Nativo de Ubuntu
- **Herramientas Unix**: sed, grep, awk, etc.

## TAREAS PENDIENTES PRIORITARIAS

### TODO LIST ACTUAL:
1. ✅ **Cambiar workspace VS Code a Ubuntu** - COMPLETADO
2. 🔄 **Configurar terminal Ubuntu por defecto** - EN PROGRESO
3. ⏳ **Verificar entorno Ubuntu completo**
4. ⏳ **Crear scripts bash nativos**
5. ⏳ **Corregir problemas tipográficos**

### TAREA INMEDIATA: VERIFICAR ENTORNO UBUNTU COMPLETO
1. ✅ Terminal debe abrir en Ubuntu (prompt: `pepe@ppcapiro:~/work/micrositio$`)
2. ✅ Verificar conexión Git remota funcional
3. ✅ Confirmar todos los archivos presentes y accesibles
4. ✅ Verificar que comandos bash funcionan correctamente

**COMANDO DE VERIFICACIÓN COMPLETA:**
```bash
# Verificación integral del entorno
echo "🔍 VERIFICACIÓN COMPLETA DEL ENTORNO UBUNTU"
echo "=============================================="
echo "📍 Ubicación actual: $(pwd)"
echo "📁 Archivos HTML: $(ls *.html 2>/dev/null | wc -l)"
echo "🗂️  Directorios críticos: $(find . -maxdepth 1 -type d -name "assets" -o -name "casos" -o -name "lab" | wc -l)"
echo "🔧 Git configurado: $(git remote get-url origin 2>/dev/null || echo 'ERROR: Sin remoto')"
echo "🌐 Conectividad GitHub: $(git ls-remote origin HEAD 2>/dev/null && echo 'OK' || echo 'ERROR')"
echo "⚠️  Errores tipográficos: $(grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html 2>/dev/null | wc -l)"
echo "=============================================="
```

### TAREA CRÍTICA: CREAR SCRIPTS BASH NATIVOS
Debes crear un script `validate-typography.sh` que:

```bash
#!/bin/bash
# Script de validación con correcciones Unicode

echo "🔍 Iniciando validación tipográfica..."

# Definir correcciones
declare -A corrections=(
    # Acentos
    ['Ã¡']='á' ['Ã©']='é' ['Ã­']='í' ['Ã³']='ó' ['Ãº']='ú'
    ['Ã']='Á' ['Ã‰']='É' ['Ã']='Í' ['Ã"']='Ó' ['Ãš']='Ú'
    ['Ã±']='ñ' ['Ã'']='Ñ'
    
    # Símbolos
    ['âœ"']='✓' ['âœ…']='✅' ['â­']='⭐'
    ['â†'']='→' ['â†']='←' ['â†'']='↑' ['â†"']='↓'
    ['â€¢']='•' ['â€"']='–' ['â€'']='—'
    
    # Emojis
    ['ðŸ"‚']='📂' ['ðŸ"']='📊' ['ðŸ"ˆ']='📈'
    ['ðŸŒ']='🌍' ['ðŸŽ¯']='🎯' ['ðŸ'¡']='💡'
    ['ðŸš€']='🚀' ['ðŸ'¼']='💼' ['ðŸ'¥']='👥'
)

# Procesar archivos HTML
for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        echo "📄 Procesando: $file"
        # Aplicar correcciones usando sed
        for wrong in "${!corrections[@]}"; do
            correct="${corrections[$wrong]}"
            sed -i "s/$wrong/$correct/g" "$file"
        done
    fi
done
```

### TAREA FINAL: CORREGIR PROBLEMAS TIPOGRÁFICOS
**Archivos con errores conocidos:**
- `acciones.html`: 28+ errores
- `cronologia.html`: 5 errores
- `casos/index.html`: 4 errores

## PIPELINE DE DEPLOYMENT COMPLETO

### SECUENCIA OBLIGATORIA DESPUÉS DE CORRECCIONES:

1. **Validar cambios localmente**:
   ```bash
   # Ejecutar script de validación
   ./validate-typography.sh
   
   # Verificar que no hay errores críticos
   grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html | wc -l
   # Debe mostrar: 0
   ```

2. **Verificar estado del repositorio**:
   ```bash
   git status
   git diff --name-only
   ```

3. **Commit y push al repositorio**:
   ```bash
   # Agregar archivos modificados
   git add *.html casos/*.html lab/*.html
   
   # Commit con mensaje descriptivo
   git commit -m "Fix: Correcciones tipográficas Unicode completas
   
   - Corregidos caracteres Ã¡→á, Ã©→é, Ã³→ó
   - Corregidos símbolos âœ"→✓ 
   - Corregidos emojis ðŸ"‚→📂, ðŸŒ→🌍
   - Archivos afectados: acciones.html, cronologia.html, casos/index.html"
   
   # Push al repositorio remoto
   git push origin main
   ```

4. **Verificar push exitoso**:
   ```bash
   # Confirmar que el push fue exitoso
   git log --oneline -n 3
   git status
   ```

5. **Deployment a Surge.sh** (si Node.js disponible):
   ```bash
   # Verificar si surge está disponible
   which surge || echo "Surge no disponible - usar método alternativo"
   
   # Si surge disponible:
   surge . runartfoundry-micrositio.surge.sh
   
   # Si no, documentar cambios para deployment manual
   echo "✅ Cambios listos para deployment manual a Surge.sh"
   ```

### VERIFICACIÓN FINAL:
```bash
# Confirmar estado limpio
git status

# Verificar último commit
git log --oneline -n 1

# Verificar conexión remota
git remote -v

# Resumen final
echo "🎉 DEPLOYMENT PIPELINE COMPLETADO:"
echo "📝 Cambios committed: $(git log --oneline -n 1)"
echo "🔗 Repositorio: $(git remote get-url origin)"
echo "🌐 Sitio: https://runartfoundry-micrositio.surge.sh"
```

## COMANDOS IMPORTANTES DE VERIFICACIÓN

### VERIFICACIÓN COMPLETA DEL ENTORNO
```bash
# 1. Verificar ubicación correcta
pwd
# Debe mostrar: /home/pepe/work/micrositio

# 2. Listar archivos principales
ls -la
# Debe mostrar: .git/, assets/, casos/, lab/, *.html, *.md

# 3. Verificar repositorio Git local
git status
# Debe mostrar archivos modificados y estado del repositorio

# 4. CRÍTICO: Verificar conexión con repositorio remoto
git remote -v
# Debe mostrar: origin https://github.com/ppkapiro/runartfoundry-micrositio.git

# 5. Verificar conexión remota
git fetch --dry-run
# Debe conectar sin errores

# 6. Verificar rama actual
git branch
# Debe mostrar: * main

# 7. Buscar errores tipográficos críticos
grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html
# Si encuentra errores, mostrar archivos afectados

# 8. Verificar encoding de archivos
file -i *.html | head -5
# Debe mostrar: charset=utf-8

# 9. Verificar estructura de directorios crítica
find . -type d -name "assets" -o -name "casos" -o -name "lab" | wc -l
# Debe mostrar: 3 (tres directorios encontrados)

# 10. Verificar archivos HTML críticos
ls *.html | wc -l
# Debe mostrar al menos 6 archivos HTML
```

### VERIFICACIÓN DE CONECTIVIDAD GITHUB
```bash
# Verificar configuración Git
git config --list | grep -E "user.name|user.email|remote.origin.url"

# Test de conectividad GitHub (opcional)
git ls-remote origin
# Debe listar las referencias remotas sin error
```

## NOTAS CRÍTICAS

### ❌ NO HAGAS ESTO:
- No uses comandos PowerShell (`Get-ChildItem`, `dir`, etc.)
- No ejecutes scripts `.ps1`
- No trabajes desde directorios Windows
- No uses `wsl` desde fuera - ya estás dentro

### ✅ SÍ DEBES HACER:
- Usar comandos bash nativos (`ls`, `grep`, `sed`, `awk`)
- Crear scripts `.sh` con shebang `#!/bin/bash`
- Trabajar directamente en Ubuntu
- Verificar encoding UTF-8 en todos los archivos

## ESTADO DE ARCHIVOS CONOCIDO

### Archivos con errores tipográficos confirmados:
1. **acciones.html** - 28+ errores (crítico)
2. **cronologia.html** - 5 errores
3. **casos/index.html** - 4 errores

### Patrones de error más comunes:
- `Ã³` → `ó` (muy frecuente)
- `âœ"` → `✓` (checkmarks)
- `ðŸ"‚` → `📂` (folder emoji)
- `ðŸŒ` → `🌍` (world emoji)

## RESULTADO ESPERADO

Al finalizar deberías tener:
1. ✅ Terminal Ubuntu funcionando correctamente
2. ✅ Scripts bash nativos creados y funcionales
3. ✅ Todos los errores tipográficos corregidos
4. ✅ Sitio web actualizado sin errores de encoding
5. ✅ Repository Git actualizado

## INICIO INMEDIATO - VERIFICACIÓN COMPLETA

**SECUENCIA DE COMANDOS OBLIGATORIA AL INICIAR:**

```bash
# 1. VERIFICAR UBICACIÓN Y ARCHIVOS
pwd && ls -la

# 2. VERIFICAR REPOSITORIO GIT
git status

# 3. VERIFICAR CONEXIÓN REMOTA GITHUB
git remote -v
git fetch --dry-run

# 4. VERIFICAR PROBLEMAS TIPOGRÁFICOS CRÍTICOS
echo "🔍 Buscando errores tipográficos..."
grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html | wc -l

# 5. MOSTRAR RESUMEN DEL ESTADO
echo "📊 RESUMEN DEL ENTORNO:"
echo "📍 Ubicación: $(pwd)"
echo "📁 Archivos HTML: $(ls *.html | wc -l)"
echo "🔧 Git remoto: $(git remote get-url origin 2>/dev/null || echo 'NO CONFIGURADO')"
echo "⚠️  Errores tipográficos: $(grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html 2>/dev/null | wc -l)"
```

**🚨 CONDICIONES OBLIGATORIAS PARA CONTINUAR:**
- ✅ Debe estar en `/home/pepe/work/micrositio`
- ✅ Debe ver archivos: `index.html`, `acciones.html`, `cronologia.html`, etc.
- ✅ Debe existir directorio `.git/`
- ✅ `git remote -v` debe mostrar: `https://github.com/ppkapiro/runartfoundry-micrositio.git`
- ✅ `git fetch --dry-run` debe ejecutarse sin errores de conectividad

**⛔ SI ALGUNA CONDICIÓN FALLA:**
**PARA INMEDIATAMENTE** y reporta el problema específico antes de continuar.

---

## INFORMACIÓN CRÍTICA DEL REPOSITORIO

### CONFIGURACIÓN GITHUB:
- **Repositorio**: https://github.com/ppkapiro/runartfoundry-micrositio
- **Branch principal**: main
- **URL de deployment**: https://runartfoundry-micrositio.surge.sh
- **Último deployment**: Funcional con problemas tipográficos identificados

### CREDENCIALES Y ACCESO:
- **Git debe estar configurado** con credenciales válidas
- **Surge.sh**: Requiere login (si Node.js disponible)
- **Permisos**: Acceso completo de escritura al repositorio

### ARCHIVOS CRÍTICOS PARA EL PRÓXIMO COPILOT:
1. `INSTRUCCIONES_PARA_COPILOT_UBUNTU.md` - Este archivo con instrucciones completas
2. `validate-typography.sh` - Script bash para correcciones (crear si no existe)
3. `.git/` - Repositorio completo con historial
4. `*.html` - Archivos con errores tipográficos a corregir

---

**Fecha de migración**: 29 de septiembre de 2025  
**Estado**: Entorno Ubuntu completamente preparado y verificado  
**Prioridad**: ALTA - Problemas tipográficos críticos en producción  
**Repositorio**: ✅ Migrado completamente con historial Git intacto  
**Conectividad**: ⚠️ Pendiente de verificación con GitHub remoto