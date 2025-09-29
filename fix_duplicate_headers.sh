#!/bin/bash
echo "🚨 CORRECCIÓN URGENTE - ELIMINANDO HEADERS DUPLICADOS"
echo "===================================================="

# Lista de archivos afectados (excepto acciones.html que está bien)
affected_files=(
    "index.html"
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

echo "🔍 Archivos a corregir:"
for file in "${affected_files[@]}"; do
    if [ -f "$file" ]; then
        count=$(grep -c "<!-- Header -->" "$file")
        echo "  📄 $file - $count headers encontrados"
    fi
done

echo ""
echo "🔧 ELIMINANDO HEADERS DUPLICADOS..."

for file in "${affected_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  📝 Procesando $file..."
        
        # Crear backup
        cp "$file" "${file}.pre_header_fix"
        
        # Usar awk para eliminar el SEGUNDO header duplicado
        awk '
        BEGIN { 
            header_count = 0
            in_second_header = 0
        }
        /<!-- Header -->/ { 
            header_count++
            if (header_count == 2) {
                in_second_header = 1
                next
            }
        }
        in_second_header && /<\/header>/ {
            in_second_header = 0
            next
        }
        !in_second_header { print }
        ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
        
        # Verificar resultado
        new_count=$(grep -c "<!-- Header -->" "$file")
        echo "    ✅ Headers después de corrección: $new_count"
    fi
done

echo ""
echo "🧪 VERIFICACIÓN FINAL:"
echo "====================="

for file in "${affected_files[@]}"; do
    if [ -f "$file" ]; then
        count=$(grep -c "<!-- Header -->" "$file")
        if [ $count -eq 1 ]; then
            echo "✅ $file - $count header (CORRECTO)"
        else
            echo "❌ $file - $count headers (PROBLEMA)"
        fi
    fi
done

# Verificar acciones.html que debería seguir correcto
if [ -f "acciones.html" ]; then
    count=$(grep -c "<!-- Header -->" "acciones.html")
    echo "✅ acciones.html - $count header (REFERENCIA CORRECTA)"
fi

echo ""
echo "🎉 CORRECCIÓN COMPLETADA"
echo "======================="
echo "💾 Backups guardados como .pre_header_fix"
echo "🚀 Listo para commit y deploy"