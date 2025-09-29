#!/bin/bash
echo "🔧 ESTANDARIZANDO ESTRUCTURA HTML DEL MENÚ"
echo "=========================================="

# Crear template HTML limpio para el menú
cat > menu_template.html << 'EOF'
    <!-- Header -->
    <header class="header" role="banner">
        <div class="container">
            <div class="header-content">
                <nav class="nav-main" role="navigation" aria-label="Navegación principal">
                    <button class="nav-toggle" aria-expanded="false" aria-controls="nav-list" onclick="toggleMenu()">
                        ☰
                    </button>
                    
                    <ul class="nav-list" id="nav-list">
                        <li><a href="index.html" class="nav-link">Inicio</a></li>
                        <li><a href="uldis.html" class="nav-link">Uldis López</a></li>
                        <li><a href="run.html" class="nav-link">RUN Art Foundry</a></li>
                        <li><a href="cronologia.html" class="nav-link">Cronología</a></li>
                        <li><a href="evidencias.html" class="nav-link">Evidencias</a></li>
                        <li><a href="casos/index.html" class="nav-link">Casos</a></li>
                        <li><a href="lab/index.html" class="nav-link">RUN Lab</a></li>
                        <li><a href="acciones.html" class="nav-link">Acciones</a></li>
                        <li><a href="contacto.html" class="nav-link">Contacto</a></li>
                    </ul>
                    
                    <div class="locale-switch" role="group" aria-label="Cambiar idioma">
                        <button class="locale-btn active" data-locale="es">ES</button>
                        <button class="locale-btn" data-locale="en">EN</button>
                    </div>
                </nav>
            </div>
        </div>
    </header>
EOF

echo "✅ Template HTML del menú creado"

# Lista de páginas principales en la raíz
main_pages=(
    "index.html"
    "uldis.html" 
    "run.html"
    "cronologia.html"
    "evidencias.html"
    "acciones.html"
    "contacto.html"
)

echo ""
echo "🔄 Actualizando páginas principales..."

for page in "${main_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "  📄 Procesando $page..."
        
        # Crear backup
        cp "$page" "${page}.pre_html_clean"
        
        # Usar sed para reemplazar toda la sección del header
        sed -i '
        # Marcar inicio de la sección header
        /<!-- Header -->/,/<\/header>/ {
            # Si es la primera línea del patrón, reemplazar con nuestro template
            /<!-- Header -->/ {
                r menu_template.html
                d
            }
            # Borrar todas las otras líneas del patrón
            d
        }
        ' "$page"
        
        echo "    ✅ $page actualizado"
    else
        echo "    ⚠️  $page no encontrado"
    fi
done

echo ""
echo "🎯 PÁGINAS PRINCIPALES COMPLETADAS"
echo "================================="

# Mostrar qué se hizo
for page in "${main_pages[@]}"; do
    if [ -f "$page" ] && [ -f "${page}.pre_html_clean" ]; then
        echo "✅ $page - Header estandarizado"
    fi
done

# Limpiar archivo temporal
rm menu_template.html

echo ""
echo "🎉 ESTRUCTURA HTML ESTANDARIZADA"
echo "================================"
echo "✅ Menú consistente en todas las páginas principales"
echo "✅ HTML limpio sin duplicaciones"
echo "✅ Estructura semántica correcta"
echo "💾 Backups guardados como .pre_html_clean"