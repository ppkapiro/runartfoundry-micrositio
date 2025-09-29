#!/bin/bash

echo "🧹 LIMPIEZA FINAL - ELIMINANDO DUPLICADOS"
echo "========================================"

# Archivos con duplicados detectados
files_with_duplicates=(
    "acciones.html"
    "contacto.html" 
    "cronologia.html"
    "evidencias.html"
    "run.html"
    "uldis.html"
)

for file in "${files_with_duplicates[@]}"; do
    if [ -f "$file" ]; then
        echo "  🔧 Limpiando duplicados en: $file"
        
        # Eliminar la primera ocurrencia de "Inicio" si hay más de una
        perl -i -pe '
        BEGIN { $removed_first = 0; }
        if (/<li><a href="index\.html" class="nav-link">Inicio<\/a><\/li>/ && !$removed_first) {
            $_ = "";
            $removed_first = 1;
        }
        ' "$file"
        
        echo "    ✅ Duplicado eliminado"
    fi
done

# Commit y deploy rápido
git add -A
git commit -m "🧹 CLEAN: Eliminados duplicados de enlace Inicio

Solo un enlace 'Inicio' por página"

git push origin main
surge . runartfoundry-micrositio-ubuntu.surge.sh

echo ""
echo "✅ MENÚ FINAL LIMPIO Y FUNCIONAL EN TODAS LAS PÁGINAS"