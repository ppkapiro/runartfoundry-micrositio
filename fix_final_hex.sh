#!/bin/bash

echo "🔧 CORRECCIÓN FINAL CON HEXADECIMAL"
echo "=================================="

# Archivos a procesar
files=(
    "cronologia.html"
    "run.html" 
    "casos/raider.html"
    "casos/roman.html"
    "lab/index.html"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "📝 Procesando: $file"
        
        # Copiar como backup
        cp "$file" "${file}.final_backup"
        
        # Aplicar todas las correcciones hexadecimales conocidas
        
        # Estructura de árbol ├──
        sed -i 's/\xc3\xa2\xe2\x80\x9d\xc5\x93\xc3\xa2\xe2\x80\x9d\xe2\x82\xac\xc3\xa2\xe2\x80\x9d\xe2\x82\xac/├──/g' "$file"
        
        # Estructura de árbol └──
        sed -i 's/\xc3\xa2\xe2\x80\x9d\xe2\x80\x9d\xc3\xa2\xe2\x80\x9d\xe2\x82\xac\xc3\xa2\xe2\x80\x9d\xe2\x82\xac/└──/g' "$file"
        sed -i 's/\xc3\xa2\xe2\x80\x9d\xe2\x80\x9c\xc3\xa2\xe2\x80\x9d\xe2\x82\xac\xc3\xa2\xe2\x80\x9d\xe2\x82\xac/└──/g' "$file"
        
        # Flecha dropdown ▼
        sed -i 's/\xc3\xa2\xe2\x80\x9d\xe2\x80\x93\xc2\xbc/▼/g' "$file"
        
        # Verificar resultado
        remaining=$(grep -c "â" "$file" 2>/dev/null || echo "0")
        if [ $remaining -eq 0 ]; then
            echo "  ✅ COMPLETAMENTE LIMPIO"
        else
            echo "  ⚠️  $remaining caracteres â restantes"
            # Mostrar cuáles quedan
            echo "      $(grep -o "â[^[:space:]]*" "$file" | head -3 | tr '\n' ' ')"
        fi
    fi
done

echo ""
echo "📊 RESUMEN TOTAL:"
echo "================="

all_files=(
    "acciones.html"
    "contacto.html"
    "cronologia.html"
    "evidencias.html"
    "index.html"
    "run.html"
    "uldis.html"
    "casos/index.html"
    "casos/raider.html"
    "casos/roman.html"
    "lab/index.html"
)

total_clean=0
total_files=0

for file in "${all_files[@]}"; do
    if [ -f "$file" ]; then
        total_files=$((total_files + 1))
        remaining=$(grep -c "â" "$file" 2>/dev/null || echo "0")
        
        if [ $remaining -eq 0 ]; then
            echo "  ✅ $file"
            total_clean=$((total_clean + 1))
        else
            echo "  ❌ $file: $remaining caracteres problemáticos"
        fi
    fi
done

echo ""
echo "🎯 RESULTADO: $total_clean/$total_files archivos completamente limpios"

if [ $total_clean -eq $total_files ]; then
    echo "🎉 ¡ÉXITO TOTAL! Todos los archivos están perfectos"
else
    echo "⚠️  Algunos archivos necesitan atención manual"
fi