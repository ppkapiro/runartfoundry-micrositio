# 📚 ESTRUCTURA ORGANIZACIONAL COMPLETA - MICROSITIO RUN ART FOUNDRY

*Reorganizado el: 29 de Septiembre, 2025*

---

## 🗂️ NUEVA ESTRUCTURA DE CARPETAS

```
📁 runartfoundry-micrositio/
├── 📄 README.md                              ← ESTE ARCHIVO (índice maestro)
├── 📄 index.html                             ← Página principal del sitio
├── 📄 *.html                                 ← Todas las páginas del sitio
├── 📁 assets/                                ← Recursos estáticos
│   ├── 📁 css/                               ← Hojas de estilo
│   ├── 📁 js/                                ← JavaScript
│   └── 📁 images/                            ← Imágenes
├── 📁 casos/                                 ← Casos de estudio (Raider, Roman)
├── 📁 lab/                                   ← Sección laboratorio
├── 📁 docs/                                  ← 📚 TODA LA DOCUMENTACIÓN
│   ├── 📁 technical/                         ← Documentación técnica
│   ├── 📁 guides/                            ← Guías de usuario/desarrollo
│   └── 📁 reports/                           ← Reportes de estado
├── 📁 scripts/                               ← 🛠️ TODOS LOS SCRIPTS
│   ├── 📁 deployment/                        ← Scripts de deploy
│   ├── 📁 maintenance/                       ← Scripts de mantenimiento
│   └── 📁 legacy/                            ← Scripts obsoletos
└── 📁 backups/                               ← 💾 TODOS LOS BACKUPS
    ├── 📁 html/                              ← Backups de HTML
    ├── 📁 css/                               ← Backups de CSS
    └── 📁 js/                                ← Backups de JS
```

---

## 📖 DOCUMENTACIÓN ORGANIZADA

### 📁 `/docs/technical/` - Documentación Técnica
| Archivo | Descripción | Estado |
|---------|-------------|--------|
| `DOCUMENTACION_COMPLETA_MICROSITIO.md` | 📖 **Documentación maestra** (1,046 líneas) | ✅ Activa |
| `INSTRUCCIONES_PARA_COPILOT_UBUNTU.md` | 🤖 Instrucciones para asistente IA | ✅ Activa |
| `instrucciones_de_integracion_para_programador_micrositio_run.md` | 🔧 Instrucciones de integración | ✅ Activa |

### 📁 `/docs/guides/` - Guías de Usuario y Desarrollo  
| Archivo | Descripción | Estado |
|---------|-------------|--------|
| `GUIA_COMPLETA_MICROSITIO.md` | 🏗️ Guía completa del proyecto | ✅ Activa |
| `guia_practica_de_acciones_uldis_lopez_run_art_foundry.md` | 📋 Guía práctica de acciones | ✅ Activa |
| `guia_tecnica_para_programar_el_micrositio_uldis_lopez_run_art_foundry.md` | 💻 Guía técnica de programación | ✅ Activa |

### 📁 `/docs/reports/` - Reportes de Estado
| Archivo | Descripción | Estado |
|---------|-------------|--------|
| `ESTADO_ACTUAL.md` | 📊 Estado actual del proyecto | ✅ Activa |
| `DEPLOYMENT_SUCCESS.md` | 🚀 Reporte de deployment exitoso | ✅ Activa |
| `RESUMEN_OPTIMIZACION_MENU.md` | 🔧 Reporte de optimización del menú | ✅ Activa |

---

## 🛠️ SCRIPTS ORGANIZADOS

### 📁 `/scripts/deployment/` - Scripts de Deploy
| Archivo | Descripción | Uso |
|---------|-------------|-----|
| `dev-tools.sh` | 🎯 **Herramienta maestra** con menú interactivo | `./dev-tools.sh` |
| `branch_manager.sh` | 🌿 Gestión completa de ramas | `./branch_manager.sh` |
| `deploy-production.sh` | 🚀 Deploy seguro a producción | `./deploy-production.sh` |
| `deploy-staging.sh` | 🧪 Deploy flexible a staging | `./deploy-staging.sh` |
| `deploy.sh` | 📤 Deploy básico | `./deploy.sh` |

### 📁 `/scripts/maintenance/` - Scripts de Mantenimiento
| Archivo | Descripción | Uso |
|---------|-------------|-----|
| `clean_menu_css.sh` | 🧹 Limpieza de CSS del menú | Mantenimiento |
| `clean_menu_js.sh` | 🧹 Limpieza de JS del menú | Mantenimiento |
| `standardize_html.sh` | 📝 Estandarización de HTML | Mantenimiento |
| `fix_duplicate_headers.sh` | 🔧 Arreglo de headers duplicados | Corrección |
| `fix_relative_paths.sh` | 🔗 Arreglo de rutas relativas | Corrección |

### 📁 `/scripts/legacy/` - Scripts Obsoletos
*Todos los scripts antiguos de corrección que ya no se necesitan*

---

## ⚡ SCRIPTS DE ACCESO RÁPIDO

Para tu comodidad, hay scripts de acceso rápido en el directorio raíz:

| Script | Descripción | Redirige a |
|--------|-------------|------------|
| `./dev-tools.sh` | 🎯 Herramienta maestra | `scripts/deployment/dev-tools.sh` |
| `./deploy-staging.sh` | 🧪 Deploy a staging | `scripts/deployment/deploy-staging.sh` |
| `./deploy-production.sh` | 🚀 Deploy a producción | `scripts/deployment/deploy-production.sh` |

---

## 💾 BACKUPS ORGANIZADOS

### 📁 `/backups/html/` - Backups de HTML
- Todos los archivos `.backup`, `.bak`, `.emergency_backup`
- Organizados por fecha y tipo de backup

### 📁 `/backups/css/` - Backups de CSS  
- `main.css.full_backup` - ✅ **Backup completo funcional**
- `main.css.pre_clean_backup_*` - Backups antes de limpieza
- `main_old_chaos.css` - CSS caótico original

### 📁 `/backups/js/` - Backups de JavaScript
- `main.js.pre_clean_backup_*` - Backups antes de limpieza  
- `main_old_chaos.js` - JS caótico original

---

## 🌐 INFORMACIÓN DE DEPLOYMENT

### Ambientes Activos
- 📱 **Producción:** https://runartfoundry-micrositio-ubuntu.surge.sh
- 🧪 **Staging:** https://runartfoundry-micrositio-dev.surge.sh

### Sistema de Ramas
- 🌿 **main** - Producción estable
- 🔬 **development** - Desarrollo y testing

### Workflow Recomendado
1. Desarrollar en rama `development`
2. Probar en staging con `./deploy-staging.sh`
3. Mergear a `main` cuando esté listo
4. Deploy a producción con `./deploy-production.sh`

---

## 🚀 CÓMO USAR ESTA ORGANIZACIÓN

### Para Desarrollo Diario:
```bash
./dev-tools.sh                 # Herramienta principal con menú
./dev-tools.sh status          # Ver estado rápido
cd docs/                       # Consultar documentación
```

### Para Consultar Documentación:
```bash
cd docs/technical/             # Documentación técnica
cd docs/guides/                # Guías de desarrollo  
cd docs/reports/               # Reportes de estado
```

### Para Scripts:
```bash
cd scripts/deployment/         # Scripts de deploy
cd scripts/maintenance/        # Scripts de mantenimiento
```

### Para Backups:
```bash
cd backups/                    # Todos los backups seguros
```

---

## 📋 PRÓXIMOS PASOS

✅ **Completado:**
- Estructura de carpetas creada
- Documentación identificada y categorizada
- Scripts organizados por función
- Sistema de backups estructurado
- Archivos movidos a sus ubicaciones correctas
- Scripts de acceso rápido creados

🔄 **En Proceso:**
- Eliminar archivos duplicados restantes
- Actualizar referencias cruzadas en documentación

---

## 🆘 SOPORTE

Si necesitas ayuda con cualquier parte de la organización:
1. Consulta este README
2. Revisa la documentación en `/docs/`
3. Usa `./dev-tools.sh` para operaciones comunes
4. Los backups están seguros en `/backups/`

---

*📅 Última actualización: 29 de Septiembre, 2025*  
*🏗️ Micrositio RUN Art Foundry - Versión Organizada*
- Blog técnico (RUN Lab)

## Tecnologías

- HTML5 semántico
- CSS3 con variables nativas
- JavaScript vanilla modular
- Service Worker para cache
- Optimizado para SEO y accesibilidad

## URL del Sitio

https://runartfoundry-micrositio-ubuntu.surge.sh

## Estructura

- **Index**: Página principal con overview
- **Uldis López**: Biografía del maestro fundidor
- **RUN Art Foundry**: Información corporativa
- **Cronología**: Plan estratégico Q1-Q4
- **Evidencias**: Testimonios y métricas
- **Casos**: Estudios de proyectos específicos
- **RUN Lab**: Blog técnico especializado
- **Contacto**: Formulario y información

© 2025 RUN Art Foundry
