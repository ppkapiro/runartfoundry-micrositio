#!/bin/bash

# Script para remover enlaces técnicos del menú de navegación demo-venta

echo "🔄 Limpiando navegaciones del demo-venta..."

# Lista de archivos a actualizar (excluyendo los técnicos ya movidos)
files=(
    "uldis.html"
    "run.html"
    "cronologia.html"
    "evidencias.html"
    "contacto.html"
    "casos/index.html"
    "casos/roman.html"
    "casos/raider.html"
    "lab/index.html"
)

# Patrón a buscar y reemplazar
search_pattern='<li><a href="[./]*acciones.html" class="nav-link">Acciones</a></li>'
replace_pattern=''

search_pattern_dev='<li><a href="[./]*dev.html" class="nav-link">🛠️ Dev</a></li>'

for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✏️  Actualizando: $file"
        
        # Remover línea de Acciones
        sed -i '/<li><a href="[.\/]*acciones\.html"/d' "$file"
        
        # Remover línea de Dev
        sed -i '/<li><a href="[.\/]*dev\.html"/d' "$file"
        
        echo "✅ Completado: $file"
    else
        echo "⚠️  Archivo no encontrado: $file"
    fi
done

echo "🎯 Navegaciones del demo-venta limpias - solo páginas comerciales visibles"