#!/bin/bash

echo "🔧 OPTIMIZANDO MENÚ DE NAVEGACIÓN"
echo "================================="
echo ""
echo "Cambios a aplicar:"
echo "• ❌ Eliminar botón 'Inicio' duplicado (el logo ya funciona)"
echo "• ✅ Optimizar navegación sin redundancia"
echo "• 🎨 Mejorar responsive design del menú"
echo ""

# Lista de archivos HTML a actualizar
html_files=(
    "index.html"
    "acciones.html"
    "contacto.html"
    "cronologia.html"
    "evidencias.html"
    "run.html"
    "uldis.html"
    "casos/index.html"
    "casos/raider.html"
    "lab/index.html"
)

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        echo "📝 Procesando: $file"
        
        # Crear backup
        cp "$file" "${file}.menu_backup"
        
        # Determinar la ruta relativa correcta según el archivo
        if [[ "$file" == casos/* ]] || [[ "$file" == lab/* ]]; then
            # Archivos en subdirectorios - usar rutas ../
            perl -i -pe '
                # Eliminar línea de Inicio duplicada
                s|.*<li><a href="\.\./index\.html" class="nav-link">Inicio</a></li>.*\n||g;
                s|.*<li><a href="index\.html" class="nav-link">Inicio</a></li>.*\n||g;
            ' "$file"
        else
            # Archivos en directorio raíz
            perl -i -pe '
                # Eliminar línea de Inicio duplicada
                s|.*<li><a href="index\.html" class="nav-link">Inicio</a></li>.*\n||g;
            ' "$file"
        fi
        
        echo "  ✅ Menú optimizado"
    else
        echo "  ❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "🎨 APLICANDO MEJORAS DE CSS PARA MENÚ RESPONSIVE..."
echo "=================================================="

# Verificar si existe el archivo CSS
if [ -f "assets/css/main.css" ]; then
    echo "📝 Actualizando estilos del menú..."
    
    # Agregar estilos para mejor responsive design del menú
    cat >> assets/css/main.css << 'EOF'

/* Mejoras para menú responsive */
@media (max-width: 768px) {
    .nav-list {
        flex-direction: column;
        gap: 0.5rem;
    }
    
    .nav-link {
        padding: 0.75rem 1rem;
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .header-content {
        flex-wrap: wrap;
    }
}

/* Optimización para nombres largos */
.nav-link {
    max-width: 120px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

@media (min-width: 769px) {
    .nav-link {
        max-width: none;
    }
}
EOF
    
    echo "  ✅ Estilos CSS actualizados"
else
    echo "  ⚠️  Archivo CSS no encontrado, solo se actualizó el HTML"
fi

echo ""
echo "✅ OPTIMIZACIÓN DE MENÚ COMPLETADA"
echo "=================================="
echo ""
echo "📊 Cambios aplicados:"
echo "• Eliminado botón 'Inicio' duplicado de todos los archivos"
echo "• Logo mantiene funcionalidad de ir a inicio"
echo "• Menú optimizado para responsive design"
echo "• Nombres largos manejados correctamente"
echo ""
echo "🎯 Beneficios:"
echo "• Menos redundancia en navegación"
echo "• Mejor experiencia de usuario"
echo "• Menú más limpio y profesional"
echo "• Responsive mejorado para móviles"