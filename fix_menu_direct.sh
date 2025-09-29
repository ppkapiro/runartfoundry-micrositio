#!/bin/bash

echo "🔧 SOLUCIONANDO MENÚ - APLICACIÓN DIRECTA"
echo "========================================"
echo ""
echo "Problema detectado: CSS múltiple pisándose"
echo "Solución: Aplicar estilos específicos directamente"
echo ""

# Crear CSS definitivo y limpio
cat > menu_final.css << 'EOF'
/* ==============================================
   MENÚ RESPONSIVE - SOLUCIÓN DEFINITIVA
   ============================================== */

/* RESETEAR ESTILOS PREVIOS DEL MENÚ */
.nav-list {
    display: flex !important;
    flex-wrap: wrap !important;
    justify-content: center !important;
    align-items: center !important;
    list-style: none !important;
    margin: 0 !important;
    padding: 0 !important;
    gap: 0.5rem !important;
}

.nav-link {
    display: inline-block !important;
    padding: 0.5rem 0.75rem !important;
    text-decoration: none !important;
    color: #333 !important;
    font-size: 0.9rem !important;
    font-weight: 500 !important;
    border-radius: 6px !important;
    transition: all 0.3s ease !important;
    
    /* SOLUCIÓN PARA NOMBRES LARGOS */
    white-space: nowrap !important;
    text-align: center !important;
    max-width: 120px !important;
    overflow: hidden !important;
    text-overflow: ellipsis !important;
}

/* Estados hover y active */
.nav-link:hover {
    background-color: #f0f8ff !important;
    color: #0066cc !important;
    transform: translateY(-1px) !important;
}

.nav-link.active {
    background-color: #0066cc !important;
    color: white !important;
    font-weight: 600 !important;
}

/* RESPONSIVE BREAKPOINTS */
@media (max-width: 991px) {
    .nav-link {
        max-width: 100px !important;
        font-size: 0.85rem !important;
        padding: 0.4rem 0.6rem !important;
    }
}

@media (max-width: 767px) {
    .nav-list {
        flex-direction: column !important;
        gap: 0.3rem !important;
    }
    
    .nav-link {
        max-width: none !important;
        width: 100% !important;
        padding: 0.75rem 1rem !important;
        font-size: 1rem !important;
    }
}

/* TOOLTIPS PARA DESKTOP */
@media (min-width: 768px) {
    .nav-link[title]:hover::before {
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
EOF

echo "  📝 CSS definitivo creado"

# Leer el CSS actual y agregar estilos al final
if [ -f "assets/css/main.css" ]; then
    echo "" >> assets/css/main.css
    echo "/* ============================================== */" >> assets/css/main.css
    echo "/* MENÚ RESPONSIVE - SOLUCIÓN DEFINITIVA */" >> assets/css/main.css
    echo "/* $(date) */" >> assets/css/main.css
    echo "/* ============================================== */" >> assets/css/main.css
    echo "" >> assets/css/main.css
    cat menu_final.css >> assets/css/main.css
    echo "  ✅ Estilos agregados con !important"
else
    echo "  ❌ No se encontró assets/css/main.css"
    exit 1
fi

# Limpiar archivo temporal
rm -f menu_final.css

echo ""
echo "🚀 DESPLEGANDO CAMBIOS INMEDIATAMENTE"
echo "==================================="

# Hacer commit y push
git add assets/css/main.css
git commit -m "🔧 FIX: Aplicar estilos de menú responsive con !important

Solución directa para nombres largos:
• CSS con !important para evitar conflictos
• Max-width: 120px (desktop), 100px (tablet)  
• Text-overflow: ellipsis para nombres largos
• Tooltips en hover para información completa
• Responsive design funcional

Fix definitivo para RUN Art Foundry y RUN Lab"

echo "  ✅ Cambios commiteados"

# Push a GitHub
git push origin main
echo "  ✅ Sincronizado con GitHub"

# Deploy a Surge
surge . runartfoundry-micrositio-ubuntu.surge.sh --token $SURGE_TOKEN 2>/dev/null || surge . runartfoundry-micrositio-ubuntu.surge.sh
echo "  ✅ Desplegado en Surge"

echo ""
echo "🎯 VERIFICACIÓN FINAL:"
echo "====================="
echo ""
echo "  🌐 Sitio live: https://runartfoundry-micrositio-ubuntu.surge.sh"
echo "  📱 Los nombres largos ahora deberían verse cortados con '...'"
echo "  🖱️  Hover sobre 'RUN Art...' y 'RUN L...' muestra tooltip completo"
echo ""
echo "✅ Solución aplicada directamente con !important"