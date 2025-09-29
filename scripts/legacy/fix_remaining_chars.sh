#!/bin/bash

echo "🔧 CORRECCIÓN FINAL DE CARACTERES RESTANTES"
echo "==========================================="

# Lista de archivos a procesar
files=(
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

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "📝 Procesando: $file"
        
        # Crear backup
        cp "$file" "${file}.char_backup"
        
        # Correcciones de caracteres de estructura de árbol
        sed -i 's/â"œâ"€â"€/├──/g' "$file"
        sed -i 's/â""â"€â"€/└──/g' "$file"
        
        # Correcciones de símbolos de dropdown
        sed -i 's/â–¼/▼/g' "$file"
        sed -i 's/â–²/▲/g' "$file"
        
        # Correcciones de comillas problemáticas
        sed -i 's/â€œ/"/g' "$file"
        sed -i 's/â€/"/g' "$file"
        sed -i 's/â€™/'/g' "$file"
        sed -i 's/â€˜/'/g' "$file"
        
        # Correcciones de guiones y espacios
        sed -i 's/â€"/–/g' "$file"
        sed -i 's/â€"/—/g' "$file"
        
        # Verificar cambios
        if ! diff -q "$file" "${file}.char_backup" > /dev/null 2>&1; then
            changes=$(diff "${file}.char_backup" "$file" | grep "^[<>]" | wc -l)
            echo "  ✅ $changes líneas modificadas"
        else
            echo "  ℹ️  Sin cambios necesarios"
        fi
    else
        echo "  ❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "🔍 VERIFICACIÓN DE CARACTERES RESTANTES:"
echo "========================================"

# Buscar caracteres problemáticos restantes
problem_chars="â"
total_remaining=0

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        count=$(grep -c "â" "$file" 2>/dev/null || echo "0")
        if [ $count -gt 0 ]; then
            echo "  ⚠️  $file: $count caracteres â restantes"
            total_remaining=$((total_remaining + count))
        else
            echo "  ✅ $file: Limpio"
        fi
    fi
done

echo ""
if [ $total_remaining -eq 0 ]; then
    echo "🎉 ¡PERFECTO! Todos los caracteres problemáticos corregidos"
else
    echo "⚠️  Quedan $total_remaining caracteres problemáticos"
    echo ""
    echo "📋 Ejemplos de caracteres restantes:"
    grep -n "â" *.html casos/*.html lab/*.html 2>/dev/null | head -5
fi

echo ""
echo "✅ Corrección de caracteres completada"
