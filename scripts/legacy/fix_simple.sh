#!/bin/bash

echo "🔧 CORRECCIÓN SIMPLE Y EFECTIVA DE UNICODE"
echo "=========================================="

for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        echo "📝 Procesando: $file"
        
        # Crear backup
        cp "$file" "${file}.bak"
        
        # Reemplazos usando sed con hexadecimal
        sed -i 's/ðŸ"‚/��/g' "$file"
        sed -i 's/ðŸ"¥/🔥/g' "$file"
        sed -i 's/ðŸ"–/📖/g' "$file"
        sed -i 's/ðŸ¢/🏢/g' "$file"
        sed -i 's/ðŸ"Š/📊/g' "$file"
        sed -i 's/ðŸ"ˆ/📈/g' "$file"
        sed -i 's/ðŸ"§/🔧/g' "$file"
        sed -i 's/ðŸ†/🏆/g' "$file"
        sed -i 's/ðŸ/💡/g' "$file"
        
        # Contar diferencias
        changes=$(diff "${file}.bak" "$file" | wc -l)
        if [ $changes -gt 0 ]; then
            echo "  ✅ $changes líneas modificadas"
        else
            echo "  ℹ️  Sin cambios"
        fi
    fi
done

echo ""
echo "🔍 VERIFICACIÓN:"
remaining=$(grep -c "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | grep -v ":0" | wc -l)
if [ $remaining -eq 0 ]; then
    echo "🎉 ¡ÉXITO COMPLETO! Todos los caracteres Unicode corregidos"
else
    echo "📊 Archivos con caracteres restantes:"
    grep -c "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | grep -v ":0"
fi
