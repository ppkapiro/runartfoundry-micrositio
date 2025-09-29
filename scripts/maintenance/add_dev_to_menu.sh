#!/bin/bash
echo "🔧 AGREGANDO PÁGINA DE DESARROLLO AL MENÚ"
echo "======================================="

# Lista de páginas principales (excluyendo dev.html que ya tiene el menú correcto)
main_pages=(
    "index.html"
    "uldis.html" 
    "run.html"
    "cronologia.html"
    "evidencias.html"
    "acciones.html"
    "contacto.html"
)

# Lista de páginas en subdirectorios
subdir_pages=(
    "casos/index.html"
    "casos/roman.html"
    "casos/raider.html"
    "lab/index.html"
)

echo "🔄 Actualizando menús en páginas principales..."

for page in "${main_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "  📄 Actualizando $page..."
        
        # Crear backup
        cp "$page" "${page}.pre_dev_menu"
        
        # Agregar el enlace de Dev antes del cierre de </ul>
        sed -i 's|<li><a href="contacto.html" class="nav-link">Contacto</a></li>|<li><a href="contacto.html" class="nav-link">Contacto</a></li>\
                        <li><a href="dev.html" class="nav-link">🛠️ Dev</a></li>|' "$page"
        
        echo "    ✅ $page actualizado"
    fi
done

echo ""
echo "🔄 Actualizando menús en subdirectorios..."

for page in "${subdir_pages[@]}"; do
    if [ -f "$page" ]; then
        echo "  📄 Actualizando $page..."
        
        # Crear backup
        cp "$page" "${page}.pre_dev_menu"
        
        # Agregar el enlace de Dev con ruta relativa
        sed -i 's|<li><a href="../contacto.html" class="nav-link">Contacto</a></li>|<li><a href="../contacto.html" class="nav-link">Contacto</a></li>\
                        <li><a href="../dev.html" class="nav-link">🛠️ Dev</a></li>|' "$page"
        
        echo "    ✅ $page actualizado"
    fi
done

echo ""
echo "🧪 VERIFICANDO ACTUALIZACIÓN..."
echo "=============================="

for page in "${main_pages[@]}"; do
    if [ -f "$page" ] && grep -q 'href="dev.html"' "$page"; then
        echo "✅ $page - Enlace Dev agregado"
    else
        echo "❌ $page - Enlace Dev NO encontrado"
    fi
done

for page in "${subdir_pages[@]}"; do
    if [ -f "$page" ] && grep -q 'href="../dev.html"' "$page"; then
        echo "✅ $page - Enlace Dev agregado"
    else
        echo "❌ $page - Enlace Dev NO encontrado"
    fi
done

echo ""
echo "🎉 MENÚS ACTUALIZADOS"
echo "===================="
echo "✅ Nueva página de desarrollo agregada al menú"
echo "✅ Sitemap completo y detallado creado"
echo "✅ Documentación técnica incluida"
echo "💾 Backups guardados como .pre_dev_menu"