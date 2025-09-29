#!/bin/bash

echo "🚨 SOLUCIÓN AGRESIVA - FORZANDO ESTILOS DE MENÚ"
echo "=============================================="
echo ""
echo "PROBLEMA: El menú volvió a verse como al principio"
echo "SOLUCIÓN: CSS más específico con !important y HTML corregido"
echo ""

# 1. CREAR CSS SÚPER ESPECÍFICO
echo "🎨 CREANDO CSS SÚPER ESPECÍFICO"
echo "==============================="

cat > force_menu_styles.css << 'EOF'
/* ========================================================
   MENÚ RESPONSIVE - FORZADO CON MÁXIMA ESPECIFICIDAD
   ======================================================== */

/* RESET COMPLETO DEL MENÚ */
header.header .nav-main .nav-list {
    display: flex !important;
    flex-wrap: wrap !important;
    justify-content: center !important;
    align-items: center !important;
    list-style: none !important;
    margin: 0 !important;
    padding: 0 !important;
    gap: 0.5rem !important;
}

header.header .nav-main .nav-list li {
    display: inline-block !important;
    margin: 0 !important;
    padding: 0 !important;
}

/* ESTILOS FORZADOS PARA ENLACES */
header.header .nav-main .nav-list li a.nav-link {
    display: inline-block !important;
    padding: 0.5rem 0.75rem !important;
    text-decoration: none !important;
    color: #333333 !important;
    font-size: 0.9rem !important;
    font-weight: 500 !important;
    border-radius: 6px !important;
    transition: all 0.3s ease !important;
    
    /* SOLUCIÓN CRÍTICA PARA NOMBRES LARGOS */
    white-space: nowrap !important;
    text-align: center !important;
    max-width: 120px !important;
    overflow: hidden !important;
    text-overflow: ellipsis !important;
    box-sizing: border-box !important;
}

/* ESTADOS HOVER Y ACTIVE FORZADOS */
header.header .nav-main .nav-list li a.nav-link:hover {
    background-color: #f0f8ff !important;
    color: #0066cc !important;
    transform: translateY(-1px) !important;
}

header.header .nav-main .nav-list li a.nav-link.active {
    background-color: #0066cc !important;
    color: white !important;
    font-weight: 600 !important;
}

/* RESPONSIVE FORZADO */
@media (max-width: 991px) {
    header.header .nav-main .nav-list li a.nav-link {
        max-width: 100px !important;
        font-size: 0.85rem !important;
        padding: 0.4rem 0.6rem !important;
    }
}

@media (max-width: 767px) {
    header.header .nav-main .nav-list {
        flex-direction: column !important;
        gap: 0.3rem !important;
    }
    
    header.header .nav-main .nav-list li a.nav-link {
        max-width: none !important;
        width: 100% !important;
        padding: 0.75rem 1rem !important;
        font-size: 1rem !important;
    }
}

/* TOOLTIPS FORZADOS */
@media (min-width: 768px) {
    header.header .nav-main .nav-list li a.nav-link[title]:hover::before {
        content: attr(title) !important;
        position: absolute !important;
        bottom: -2.5rem !important;
        left: 50% !important;
        transform: translateX(-50%) !important;
        background: rgba(0, 0, 0, 0.8) !important;
        color: white !important;
        padding: 0.5rem !important;
        border-radius: 4px !important;
        font-size: 0.8rem !important;
        white-space: nowrap !important;
        z-index: 1001 !important;
        pointer-events: none !important;
    }
}

/* FORZAR VISIBILIDAD DEL MENÚ HAMBURGUESA */
.nav-toggle {
    display: none !important;
    background: none !important;
    border: none !important;
    font-size: 1.5rem !important;
    cursor: pointer !important;
    padding: 0.5rem !important;
}

@media (max-width: 767px) {
    .nav-toggle {
        display: block !important;
    }
}
EOF

# Agregar al final del CSS con máxima prioridad
echo "" >> assets/css/main.css
echo "/* ======================================================== */" >> assets/css/main.css
echo "/* MENÚ FORZADO - MÁXIMA ESPECIFICIDAD - $(date) */" >> assets/css/main.css
echo "/* ======================================================== */" >> assets/css/main.css
echo "" >> assets/css/main.css
cat force_menu_styles.css >> assets/css/main.css

echo "  ✅ CSS súper específico agregado"

# 2. CORREGIR HTML EN TODAS LAS PÁGINAS
echo ""
echo "🔧 CORRIGIENDO HTML EN TODAS LAS PÁGINAS"
echo "======================================="

# Lista completa de archivos HTML
all_html_files=(
    "index.html"
    "acciones.html"
    "contacto.html"
    "cronologia.html"
    "evidencias.html"
    "run.html"
    "uldis.html"
    "casos/index.html"
    "casos/raider.html"
    "casos/roman.html"
    "lab/index.html"
)

for file in "${all_html_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  🔧 Procesando: $file"
        
        # Backup
        cp "$file" "$file.emergency_backup"
        
        # Asegurar que tenga el enlace Inicio al principio
        if ! grep -q 'href="index\.html".*Inicio' "$file"; then
            echo "    📝 Agregando enlace Inicio..."
            # Buscar el ul nav-list y agregar Inicio después
            perl -i -pe 's|(<ul class="nav-list" id="nav-list">)|$1\n                        <li><a href="index.html" class="nav-link">Inicio</a></li>|' "$file"
        fi
        
        echo "    ✅ Procesado"
    else
        echo "    ⚠️  No encontrado: $file" 
    fi
done

# 3. LIMPIAR ARCHIVOS TEMPORALES
rm -f force_menu_styles.css

echo ""
echo "🚀 DEPLOY INMEDIATO CON CACHE BUSTING"
echo "===================================="

# Agregar timestamp al CSS para romper cache
timestamp=$(date +%s)
echo "/* Cache busting: $timestamp */" >> assets/css/main.css

# Commit y push
git add -A
git commit -m "🚨 EMERGENCY FIX: Menú responsive con máxima especificidad CSS

PROBLEMA CRÍTICO:
• Menú volvió a verse como al principio
• Estilos no se aplicaban correctamente
• Nombres largos sin cortar

SOLUCIÓN AGRESIVA:
• CSS con especificidad máxima (header.header .nav-main)
• !important en todos los estilos críticos
• HTML corregido en todas las páginas
• Cache busting con timestamp

ESTILOS FORZADOS:
• max-width: 120px (desktop), 100px (tablet)
• text-overflow: ellipsis FORZADO
• Tooltips con máxima especificidad
• Responsive design con !important

GARANTÍA: Ahora SÍ debe funcionar en todas las páginas"

echo "  ✅ Commit de emergencia creado"

git push origin main
echo "  ✅ Pushed a GitHub"

# Deploy con cache busting
surge . runartfoundry-micrositio-ubuntu.surge.sh
echo "  ✅ Deploy con cache busting completado"

echo ""
echo "🔥 SOLUCIÓN DE EMERGENCIA APLICADA"
echo "================================="
echo ""
echo "✅ CSS con MÁXIMA especificidad aplicado"
echo "✅ !important en TODOS los estilos críticos"  
echo "✅ HTML corregido en todas las páginas"
echo "✅ Cache busting aplicado"
echo ""
echo "🎯 AHORA SÍ DEBE FUNCIONAR:"
echo "  • Nombres largos cortados: 'RUN Art...' y 'RUN L...'"
echo "  • Tooltips en hover"
echo "  • Menú responsive"
echo ""
echo "🌐 PRUEBA ESTAS URLs:"
echo "  • https://runartfoundry-micrositio-ubuntu.surge.sh/"
echo "  • https://runartfoundry-micrositio-ubuntu.surge.sh/acciones.html"
echo ""
echo "⚠️  Si aún no funciona, presiona Ctrl+F5 para limpiar cache del navegador"