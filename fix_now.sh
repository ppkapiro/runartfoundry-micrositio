#!/bin/bash

echo "🔧 ARREGLANDO UNICODE AHORA MISMO"
echo "================================="

for file in acciones.html contacto.html cronologia.html evidencias.html index.html run.html uldis.html; do
    if [ -f "$file" ]; then
        echo "📝 $file"
        cp "$file" "${file}.bak"
        
        # Reemplazos directos con perl
        perl -i -pe 's/ðŸ"‚/📂/g; s/ðŸ"¥/🔥/g; s/ðŸ"–/📖/g; s/ðŸ¢/🏢/g; s/ðŸ"Š/📊/g; s/ðŸ"ˆ/📈/g; s/ðŸ"§/🔧/g; s/ðŸ†/🏆/g; s/ðŸ'¡/💡/g; s/ðŸ¤–/🤖/g; s/ðŸŒ/🌍/g; s/ðŸŽ¬/🎬/g; s/ðŸ"±/📱/g; s/ðŸ'¼/💼/g; s/ðŸ'°/💰/g; s/ðŸŽ¯/🎯/g' "$file"
        
        remaining=$(grep -c "ðŸ" "$file")
        if [ $remaining -eq 0 ]; then
            echo "  ✅ Completado"
        else
            echo "  ⚠️  $remaining restantes"
        fi
    fi
done

# Archivos en subdirectorios
for file in casos/index.html casos/raider.html casos/roman.html lab/index.html; do
    if [ -f "$file" ]; then
        echo "📝 $file"
        cp "$file" "${file}.bak"
        perl -i -pe 's/ðŸ"‚/📂/g; s/ðŸ"¥/🔥/g; s/ðŸ"–/📖/g; s/ðŸ¢/🏢/g; s/ðŸ"Š/📊/g; s/ðŸ"ˆ/📈/g; s/ðŸ"§/🔧/g; s/ðŸ†/🏆/g; s/ðŸ'¡/💡/g; s/ðŸ¤–/🤖/g; s/ðŸŒ/🌍/g; s/ðŸŽ¬/🎬/g; s/ðŸ"±/📱/g; s/ðŸ'¼/💼/g; s/ðŸ'°/💰/g; s/ðŸŽ¯/🎯/g' "$file"
        
        remaining=$(grep -c "ðŸ" "$file")
        if [ $remaining -eq 0 ]; then
            echo "  ✅ Completado"
        else
            echo "  ⚠️  $remaining restantes"
        fi
    fi
done

echo ""
echo "🔍 RESUMEN FINAL:"
total=$(grep -c "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | grep -v ":0" | wc -l)
if [ $total -eq 0 ]; then
    echo "�� ¡PERFECTO! Todos los archivos están limpios"
else
    echo "📊 Archivos con problemas restantes:"
    grep -c "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | grep -v ":0"
fi
