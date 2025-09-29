#!/bin/bash

echo "🔧 CORRECCIÓN FINAL DE SÍMBOLOS PROBLEMÁTICOS"
echo "============================================="

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
        cp "$file" "${file}.symbols_backup"
        
        # Correcciones de caracteres problemáticos después de emojis
        # Quitar caracteres extraños después de 💡
        sed -i 's/💡"–/📖/g' "$file"
        sed -i 's/💡¢/🏢/g' "$file"
        sed -i 's/💡†/🏆/g' "$file"
        sed -i 's/💡ˆ/📈/g' "$file"
        sed -i 's/💡"/📺/g' "$file"
        
        # Correcciones para 🎯
        sed -i 's/🎯†/🏆/g' "$file"
        sed -i 's/🎯¢/🏢/g' "$file"
        sed -i 's/🎯"/📺/g' "$file"
        
        # Limpiar checkboxes problemáticos
        sed -i 's/☐☐/☐/g' "$file"
        sed -i 's/□□/□/g' "$file"
        
        # Verificar cambios
        if ! diff -q "$file" "${file}.symbols_backup" > /dev/null 2>&1; then
            changes=$(diff "${file}.symbols_backup" "$file" | grep "^[<>]" | wc -l)
            echo "  ✅ $changes líneas modificadas"
        else
            echo "  ℹ️  Sin cambios necesarios"
        fi
    else
        echo "  ❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "🔍 VERIFICACIÓN DE SÍMBOLOS LIMPIOS:"
echo "===================================="

total_clean=0
total_files=0

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        total_files=$((total_files + 1))
        
        # Buscar símbolos problemáticos restantes
        problems=$(grep -c "💡[^[:space:]]\|🎯[^[:space:]]\|☐☐\|†" "$file" 2>/dev/null || echo "0")
        
        if [ "$problems" -eq 0 ]; then
            echo "  ✅ $file: LIMPIO"
            total_clean=$((total_clean + 1))
        else
            echo "  ⚠️  $file: $problems símbolos problemáticos"
        fi
    fi
done

echo ""
echo "📊 RESUMEN:"
echo "==========="
echo "  Archivos procesados: $total_files"
echo "  Archivos limpios: $total_clean" 

if [ $total_clean -eq $total_files ]; then
    echo ""
    echo "🎉 ¡ÉXITO TOTAL! Todos los símbolos están correctos"
else
    echo ""
    echo "⚠️  Algunos archivos necesitan revisión adicional"
fi

echo ""
echo "✅ Corrección de símbolos completada"
