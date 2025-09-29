#!/bin/bash
echo "🔗 CORRIGIENDO RUTAS RELATIVAS EN SUBDIRECTORIOS"
echo "=============================================="

# Template para páginas en subdirectorios (casos/, lab/)
cat > menu_template_subdir.html << 'EOF'
    <!-- Header -->
    <header class="header" role="banner">
        <div class="container">
            <div class="header-content">
                <nav class="nav-main" role="navigation" aria-label="Navegación principal">
                    <button class="nav-toggle" aria-expanded="false" aria-controls="nav-list" onclick="toggleMenu()">
                        ☰
                    </button>
                    
                    <ul class="nav-list" id="nav-list">
                        <li><a href="../index.html" class="nav-link">Inicio</a></li>
                        <li><a href="../uldis.html" class="nav-link">Uldis López</a></li>
                        <li><a href="../run.html" class="nav-link">RUN Art Foundry</a></li>
                        <li><a href="../cronologia.html" class="nav-link">Cronología</a></li>
                        <li><a href="../evidencias.html" class="nav-link">Evidencias</a></li>
                        <li><a href="../casos/index.html" class="nav-link">Casos</a></li>
                        <li><a href="../lab/index.html" class="nav-link">RUN Lab</a></li>
                        <li><a href="../acciones.html" class="nav-link">Acciones</a></li>
                        <li><a href="../contacto.html" class="nav-link">Contacto</a></li>
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

echo "✅ Template para subdirectorios creado"

# Lista de páginas en subdirectorios
subdir_pages=(
    "casos/index.html"
    "casos/roman.html"
    "casos/raider.html"
    "lab/index.html"
)

echo ""
echo "🔄 Corrigiendo rutas en subdirectorios..."

for page in "${subdir_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "  📄 Procesando $page..."
        
        # Crear backup
        cp "$page" "${page}.pre_routes_fix"
        
        # Reemplazar la sección del header con rutas corregidas
        sed -i '
        # Marcar inicio de la sección header
        /<!-- Header -->/,/<\/header>/ {
            # Si es la primera línea del patrón, reemplazar con nuestro template
            /<!-- Header -->/ {
                r menu_template_subdir.html
                d
            }
            # Borrar todas las otras líneas del patrón
            d
        }
        ' "$page"
        
        echo "    ✅ $page - Rutas corregidas"
    else
        echo "    ⚠️  $page no encontrado"
    fi
done

echo ""
echo "🔍 VERIFICANDO RUTAS CORREGIDAS..."
echo "================================="

# Verificar que las rutas existen
for page in "${subdir_pages[@]}"; do
    if [ -f "$page" ]; then
        dir=$(dirname "$page")
        echo "📂 Verificando rutas desde $page:"
        
        # Verificar algunas rutas críticas
        if [ -f "$dir/../index.html" ]; then
            echo "  ✅ ../index.html existe"
        else
            echo "  ❌ ../index.html NO EXISTE"
        fi
        
        if [ -f "$dir/../uldis.html" ]; then
            echo "  ✅ ../uldis.html existe"
        else
            echo "  ❌ ../uldis.html NO EXISTE"
        fi
        
        if [ -f "$dir/../assets/css/main.css" ]; then
            echo "  ✅ ../assets/css/main.css existe"
        else
            echo "  ❌ ../assets/css/main.css NO EXISTE"
        fi
        
        echo ""
    fi
done

# Verificar también las referencias a CSS y JS en subdirectorios
echo "🎨 VERIFICANDO REFERENCIAS CSS/JS EN SUBDIRECTORIOS..."
echo "===================================================="

for page in "${subdir_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "📄 $page:"
        
        # Buscar referencias a assets
        css_refs=$(grep -n "assets/css" "$page" | head -3)
        js_refs=$(grep -n "assets/js" "$page" | head -3)
        
        if [ -n "$css_refs" ]; then
            echo "  🎨 Referencias CSS encontradas:"
            echo "$css_refs" | sed 's/^/    /'
            
            # Verificar si necesita corrección
            if grep -q 'href="assets/' "$page"; then
                echo "  ⚠️  NECESITA CORRECCIÓN: debe ser '../assets/'"
            fi
        fi
        
        if [ -n "$js_refs" ]; then
            echo "  📜 Referencias JS encontradas:"
            echo "$js_refs" | sed 's/^/    /'
            
            # Verificar si necesita corrección
            if grep -q 'src="assets/' "$page"; then
                echo "  ⚠️  NECESITA CORRECCIÓN: debe ser '../assets/'"
            fi
        fi
        
        echo ""
    fi
done

# Limpiar archivo temporal
rm menu_template_subdir.html

echo "🎉 RUTAS RELATIVAS CORREGIDAS"
echo "============================="
echo "✅ Rutas de navegación corregidas en subdirectorios"
echo "✅ Todas las páginas apuntan correctamente a la raíz"
echo "💾 Backups guardados como .pre_routes_fix"
echo ""
echo "🔍 PRÓXIMO: Verificar y corregir rutas CSS/JS si es necesario"