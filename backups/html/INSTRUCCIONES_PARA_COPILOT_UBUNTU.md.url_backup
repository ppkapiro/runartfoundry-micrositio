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

5. **Deployment a Surge.sh**:

   **MÉTODO A: Con Surge CLI (Recomendado)**
   ```bash
   # Verificar si surge está disponible
   which surge || echo "Surge no disponible - instalar primero"
   
   # Si surge no está disponible, instalar:
   # npm install -g surge  # (requiere Node.js)
   
   # Login a Surge (solo primera vez)
   surge login
   
   # Deployment directo al dominio configurado
   surge . runartfoundry-micrositio.surge.sh
   
   # Verificar deployment exitoso
   curl -I https://runartfoundry-micrositio.surge.sh
   ```

   **MÉTODO B: Deployment Manual (Si no hay Node.js)**
   ```bash
   # 1. Comprimir archivos para deployment manual
   tar -czf micrositio-deployment.tar.gz *.html casos/ lab/ assets/ sw.js
   
   # 2. Documentar cambios para deployment manual
   echo "📦 ARCHIVOS LISTOS PARA DEPLOYMENT MANUAL:"
   echo "   - Archivo: micrositio-deployment.tar.gz"
   echo "   - URL destino: https://runartfoundry-micrositio.surge.sh"
   echo "   - Cambios: Correcciones tipográficas Unicode"
   echo "   - Archivos modificados: $(git diff --name-only | wc -l)"
   
   # 3. Crear script de deployment para uso posterior
   cat > deploy.sh << 'EOF'
#!/bin/bash
echo "🚀 Deploying to Surge.sh..."
surge . runartfoundry-micrositio.surge.sh
echo "✅ Deployment completed!"
echo "🌐 Site: https://runartfoundry-micrositio.surge.sh"
EOF
   chmod +x deploy.sh
   ```

   **MÉTODO C: Via GitHub (Alternativo)**
   ```bash
   # Si Surge no funciona, los cambios en GitHub pueden activar 
   # deployment automático si está configurado
   echo "🔄 Cambios pusheados a GitHub"
   echo "🌐 Verificar: https://runartfoundry-micrositio.surge.sh"
   echo "📝 Si no se actualiza automáticamente, usar deployment manual"
   ```

### VERIFICACIÓN FINAL Y TESTING:
```bash
# 1. Confirmar estado limpio del repositorio
git status

# 2. Verificar último commit
git log --oneline -n 1

# 3. Verificar conexión remota
git remote -v

# 4. Test del sitio desplegado
curl -I https://runartfoundry-micrositio.surge.sh
echo "HTTP Status debe ser: 200 OK"

# 5. Verificar páginas críticas
echo "🔍 Verificando páginas críticas:"
curl -s https://runartfoundry-micrositio.surge.sh/acciones.html | grep -c "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚" || echo "✅ Sin errores tipográficos"
curl -s https://runartfoundry-micrositio.surge.sh/cronologia.html | grep -c "Ã¹\|ðŸŒ" || echo "✅ Sin errores tipográficos"

# 6. Resumen final completo
echo ""
echo "🎉 DEPLOYMENT PIPELINE COMPLETADO:"
echo "=============================================="
echo "📝 Último commit: $(git log --oneline -n 1)"
echo "🔗 Repositorio: $(git remote get-url origin)"
echo "🌐 Sitio principal: https://runartfoundry-micrositio.surge.sh"
echo "📊 Estado HTTP: $(curl -s -o /dev/null -w "%{http_code}" https://runartfoundry-micrositio.surge.sh)"
echo "⚠️  Errores tipográficos restantes: $(grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html 2>/dev/null | wc -l)"
echo "=============================================="

# 7. URLs de verificación rápida
echo "🔗 URLs para verificación manual:"
echo "   • Principal: https://runartfoundry-micrositio.surge.sh"
echo "   • Acciones: https://runartfoundry-micrositio.surge.sh/acciones.html"
echo "   • Cronología: https://runartfoundry-micrositio.surge.sh/cronologia.html"
echo "   • Casos: https://runartfoundry-micrositio.surge.sh/casos/"
echo "   • RUN Lab: https://runartfoundry-micrositio.surge.sh/lab/"
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

## INFORMACIÓN CRÍTICA DEL REPOSITORIO Y DEPLOYMENT

### CONFIGURACIÓN GITHUB:
- **Repositorio**: https://github.com/ppkapiro/runartfoundry-micrositio
- **Branch principal**: main
- **Usuario GitHub**: ppkapiro
- **Estado actual**: Repositório activo con cambios pendientes de push

### DEPLOYMENT ACTUAL - SURGE.SH:
- **URL ACTIVA**: https://runartfoundry-micrositio.surge.sh
- **Estado**: ✅ FUNCIONAL - Sitio desplegado y accesible
- **Último deployment**: Completado exitosamente con 37 archivos (417KB)
- **Problemas conocidos**: Errores tipográficos Unicode pendientes de corrección

### DETALLES DEL SITIO DESPLEGADO:
```
Sitio: RUN Art Foundry - Micrositio
URL: https://runartfoundry-micrositio.surge.sh
Archivos: 37 archivos totales
Tamaño: 417.1 KB
Estructura:
├── index.html (página principal)
├── uldis.html (biografía Uldis López)
├── run.html (RUN Art Foundry corporativo)
├── cronologia.html (cronología Q1-Q4)
├── evidencias.html (evidencias y testimonios)
├── acciones.html (acciones prácticas) ⚠️ 28+ errores
├── contacto.html (contacto)
├── casos/ (casos de estudio)
│   ├── index.html ⚠️ 4 errores
│   ├── raider.html
│   └── roman.html
├── lab/ (RUN Lab blog técnico)
│   └── index.html
└── assets/ (CSS, JS, imágenes)
```

### CREDENCIALES Y ACCESO:
- **Git**: Debe estar configurado con credenciales GitHub válidas
- **Surge.sh**: 
  - **Email**: ⚠️ [NECESARIO - El email usado para crear la cuenta Surge]
  - **Contraseña**: ⚠️ [NECESARIO - La contraseña de la cuenta Surge]
  - Login necesario: `surge login`
  - Domain: `runartfoundry-micrositio.surge.sh` ya configurado
- **Permisos**: Acceso completo de escritura al repositorio GitHub

### ⚠️ CREDENCIALES ESPECÍFICAS REQUERIDAS:
```bash
# Para hacer deployment necesitas estas credenciales exactas:
surge login
# Email: [EL EMAIL ESPECÍFICO USADO ANTERIORMENTE]
# Password: [LA CONTRASEÑA ESPECÍFICA USADA ANTERIORMENTE]

# NOTA: Estas son las mismas credenciales que se usaron para:
# - Crear el dominio runartfoundry-micrositio.surge.sh
# - Hacer deployments anteriores exitosos
# - El último deployment de 37 archivos (417KB)
```

### 🔍 CÓMO ENCONTRAR LAS CREDENCIALES:
1. **Verificar si ya estás logueado**:
   ```bash
   surge whoami
   # Si muestra un email, ese es el correcto
   ```

2. **Si no recuerdas las credenciales**:
   - Revisar tu gestor de contraseñas
   - Buscar emails de registro de Surge.sh
   - Verificar en otro entorno donde funcione el deployment

3. **Si tienes acceso desde otra máquina**:
   ```bash
   # En la máquina donde funciona el deployment:
   surge whoami
   # Esto te mostrará el email correcto
   ```

### ESTADO ACTUAL DEL DEPLOYMENT (29 Sep 2025):
```
✅ SITIO ACTIVO: https://runartfoundry-micrositio.surge.sh
✅ Repositorio GitHub: Sincronizado y funcional
✅ Estructura completa: 11+ páginas HTML funcionando
⚠️  PROBLEMAS IDENTIFICADOS:
   - acciones.html: 28+ errores tipográficos Unicode
   - cronologia.html: 5 errores tipográficos
   - casos/index.html: 4 errores tipográficos
   - Emojis mal codificados: ðŸ"‚→📂, ðŸŒ→🌍
   - Acentos mal codificados: Ã³→ó, Ã©→é, Ã¡→á
   - Símbolos mal codificados: âœ"→✓

🎯 OBJETIVO INMEDIATO:
1. Corregir todos los errores tipográficos
2. Hacer deployment con correcciones
3. Verificar sitio actualizado sin errores
```

### ARCHIVOS CRÍTICOS PARA EL PRÓXIMO COPILOT:
1. `INSTRUCCIONES_PARA_COPILOT_UBUNTU.md` - Este archivo con instrucciones completas
2. `validate-typography.sh` - Script bash para correcciones (crear si no existe)
3. `.git/` - Repositorio completo con historial
4. `*.html` - Archivos con errores tipográficos a corregir
5. `deploy.sh` - Script de deployment automatizado (se creará)

### COMANDOS DE EMERGENCIA PARA DEPLOYMENT:
```bash
# Si hay problemas con el deployment normal
# 1. Verificar estado del sitio actual
curl -I https://runartfoundry-micrositio.surge.sh

# 2. Verificar credenciales actuales
surge whoami
# Si no muestra email: surge login y usar credenciales correctas

# 3. Login forzado con credenciales correctas
surge logout
surge login
# Ingresar EMAIL y PASSWORD específicos usados anteriormente

# 4. Deployment forzado (después del login correcto)
surge --domain runartfoundry-micrositio.surge.sh

# 5. Rollback de emergencia (si es necesario)
git reset --hard HEAD~1
surge . runartfoundry-micrositio.surge.sh

# 6. Verificación post-deployment
curl https://runartfoundry-micrositio.surge.sh | head -20
```

### 🆘 TROUBLESHOOTING CREDENCIALES:
```bash
# PROBLEMA: "Not logged in" o "Authentication failed"
# SOLUCIÓN:
surge logout
surge login
# Usar las credenciales EXACTAS que funcionaron antes

# PROBLEMA: "You do not have permission to deploy to this domain"
# SOLUCIÓN: Verificar que el email de login sea el mismo que creó el dominio
surge whoami  # Debe mostrar el email correcto
surge list    # Debe mostrar runartfoundry-micrositio.surge.sh

# PROBLEMA: No recuerdas las credenciales
# SOLUCIÓN: Buscar en:
# 1. Historial de comandos: history | grep surge
# 2. Archivos de configuración: ~/.netrc o ~/.surge/
# 3. Otro entorno donde funcione: surge whoami
```

---

**Fecha de migración**: 29 de septiembre de 2025  
**Estado**: Entorno Ubuntu completamente preparado y verificado  
**Prioridad**: ALTA - Problemas tipográficos críticos en producción  
**Repositorio**: ✅ Migrado completamente con historial Git intacto  
**Conectividad**: ⚠️ Pendiente de verificación con GitHub remoto