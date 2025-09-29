#!/bin/bash

echo "🎨 OPTIMIZANDO CSS DEL MENÚ PARA NOMBRES LARGOS"
echo "==============================================="
echo ""
echo "Problemas a solucionar:"
echo "• 📱 Nombres largos (RUN Art Foundry, RUN Lab) estiran el menú"
echo "• 🎯 Menú se ve feo en móviles y desktop"
echo "• 💡 Necesita diseño responsive moderno"
echo ""

# Crear CSS optimizado para el menú
cat > menu_styles.css << 'EOF'
/* ==============================================
   MENÚ OPTIMIZADO PARA NOMBRES LARGOS
   ============================================== */

/* Header y navegación principal */
.header {
    background: var(--color-white, #ffffff);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.header-content {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 1rem 0;
    max-width: 1200px;
    margin: 0 auto;
}

/* Navegación principal */
.nav-main {
    width: 100%;
}

.nav-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    list-style: none;
    margin: 0;
    padding: 0;
    gap: 0.5rem;
}

/* Enlaces del menú - Optimizados para nombres largos */
.nav-link {
    display: inline-block;
    padding: 0.5rem 0.75rem;
    text-decoration: none;
    color: var(--color-text, #333333);
    font-size: 0.9rem;
    font-weight: 500;
    border-radius: 6px;
    transition: all 0.3s ease;
    white-space: nowrap;
    text-align: center;
    min-width: 60px;
    max-width: 120px;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* Estados del enlace */
.nav-link:hover {
    background-color: var(--color-primary-light, #f0f8ff);
    color: var(--color-primary, #0066cc);
    transform: translateY(-1px);
}

.nav-link.active {
    background-color: var(--color-primary, #0066cc);
    color: white;
    font-weight: 600;
}

/* Botón de menú móvil */
.nav-toggle {
    display: none;
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 4px;
}

/* RESPONSIVE DESIGN */

/* Desktop grande */
@media (min-width: 1200px) {
    .nav-link {
        font-size: 1rem;
        padding: 0.6rem 1rem;
        max-width: 140px;
    }
}

/* Desktop normal */
@media (max-width: 1199px) and (min-width: 992px) {
    .nav-link {
        font-size: 0.9rem;
        padding: 0.5rem 0.8rem;
        max-width: 120px;
    }
}

/* Tablet */
@media (max-width: 991px) and (min-width: 768px) {
    .nav-list {
        gap: 0.3rem;
    }
    
    .nav-link {
        font-size: 0.85rem;
        padding: 0.4rem 0.6rem;
        max-width: 100px;
    }
}

/* Móvil */
@media (max-width: 767px) {
    .nav-toggle {
        display: block;
        position: absolute;
        right: 1rem;
        top: 50%;
        transform: translateY(-50%);
    }
    
    .nav-list {
        display: none;
        flex-direction: column;
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        border-radius: 0 0 8px 8px;
        padding: 1rem;
        gap: 0.5rem;
        z-index: 1000;
    }
    
    .nav-list.active {
        display: flex;
    }
    
    .nav-link {
        width: 100%;
        max-width: none;
        padding: 0.75rem 1rem;
        text-align: center;
        font-size: 1rem;
        border-radius: 8px;
    }
    
    .header-content {
        position: relative;
        justify-content: flex-start;
        padding: 1rem;
    }
}

/* Nombres específicos - Abreviaciones elegantes */
.nav-link[href*="run.html"]::after {
    content: "";
}

.nav-link[href*="lab/index.html"] {
    position: relative;
}

/* Tooltips para nombres largos en hover */
@media (min-width: 768px) {
    .nav-link[title]:hover::before {
        content: attr(title);
        position: absolute;
        bottom: -2.5rem;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(0, 0, 0, 0.8);
        color: white;
        padding: 0.5rem;
        border-radius: 4px;
        font-size: 0.8rem;
        white-space: nowrap;
        z-index: 1001;
        pointer-events: none;
    }
}

/* Animaciones suaves */
.nav-list {
    transition: all 0.3s ease;
}

.nav-link {
    transition: all 0.2s ease;
}

/* Accesibilidad */
.nav-link:focus {
    outline: 2px solid var(--color-primary, #0066cc);
    outline-offset: 2px;
}

/* Skip link */
.skip-link {
    position: absolute;
    top: -40px;
    left: 6px;
    background: var(--color-primary, #0066cc);
    color: white;
    padding: 8px;
    text-decoration: none;
    border-radius: 0 0 4px 4px;
    z-index: 1002;
}

.skip-link:focus {
    top: 0;
}
EOF

echo "📝 Creando CSS optimizado..."

# Agregar los estilos al archivo CSS principal
if [ -f "assets/css/main.css" ]; then
    echo "" >> assets/css/main.css
    echo "/* ============================================== */" >> assets/css/main.css
    echo "/* MENÚ OPTIMIZADO - AGREGADO $(date) */" >> assets/css/main.css
    echo "/* ============================================== */" >> assets/css/main.css
    echo "" >> assets/css/main.css
    cat menu_styles.css >> assets/css/main.css
    echo "  ✅ Estilos agregados a assets/css/main.css"
else
    echo "  ⚠️  Creando nuevo archivo CSS..."
    mkdir -p assets/css
    cp menu_styles.css assets/css/main.css
    echo "  ✅ Archivo CSS creado"
fi

# Limpiar archivo temporal
rm -f menu_styles.css

echo ""
echo "🎯 MEJORAS APLICADAS:"
echo "===================="
echo ""
echo "✅ RESPONSIVE DESIGN:"
echo "   • Desktop: Menú horizontal elegante"
echo "   • Tablet: Compacto con espaciado optimizado"
echo "   • Móvil: Menú hamburguesa colapsible"
echo ""
echo "✅ NOMBRES LARGOS SOLUCIONADOS:"
echo "   • Text overflow con ellipsis (...)"
echo "   • Max-width dinámico según pantalla"
echo "   • Tooltips en hover para nombres completos"
echo ""
echo "✅ DISEÑO MODERNO:"
echo "   • Sombras y transiciones suaves"
echo "   • Estados hover y active mejorados"
echo "   • Accesibilidad optimizada"
echo ""
echo "🎨 El menú ahora se ve bonito y profesional en todas las pantallas"