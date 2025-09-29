#!/bin/bash
# validate-typography-complete.sh
# Script de validación tipográfica completo con correcciones Unicode

echo "🔍 Iniciando validación tipográfica..."

# Definir correcciones según las instrucciones
declare -A corrections=(
    # Acentos
    ['Ã¡']='á' ['Ã©']='é' ['Ã­']='í' ['Ã³']='ó' ['Ãº']='ú'
    ['Ã']='Á' ['Ã‰']='É' ['Ã']='Í' ['Ã"']='Ó' ['Ãš']='Ú'
    ['Ã±']='ñ' ['Ã'']='Ñ'
    
    # Símbolos
    ['âœ"']='✓' ['âœ…']='✅' ['â­']='⭐'
    ['â†'']='→' ['â†']='←' ['â†'']='↑' ['â†"']='↓'
    ['â€¢']='•' ['â€"']='–' ['â€'']='—'
    
    # Emojis más comunes encontrados
    ['ðŸ"‚']='📂' ['ðŸ"']='📊' ['ðŸ"ˆ']='📈'
    ['ðŸŒ']='🌍' ['ðŸŒŽ']='🌎' ['ðŸŒ±']='🌱' ['ðŸŒŠ']='🌊'
    ['ðŸŽ¯']='🎯' ['ðŸ'¡']='💡' ['ðŸš€']='🚀' 
    ['ðŸ'¼']='💼' ['ðŸ'¥']='👥'
)

# Contadores
total_fixes=0
files_processed=0

echo "📊 Procesando archivos HTML..."

# Procesar archivos HTML en directorio raíz y subdirectorios
for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        echo "📄 Procesando: $file"
        ((files_processed++))
        
        file_fixes=0
        
        # Aplicar correcciones usando sed
        for wrong in "${!corrections[@]}"; do
            correct="${corrections[$wrong]}"
            # Contar ocurrencias antes de corregir
            count=$(grep -o "$wrong" "$file" 2>/dev/null | wc -l)
            if [ "$count" -gt 0 ]; then
                echo "  ✏️  Corrigiendo '$wrong' → '$correct' ($count ocurrencias)"
                sed -i "s/$wrong/$correct/g" "$file"
                ((file_fixes += count))
                ((total_fixes += count))
            fi
        done
        
        if [ "$file_fixes" -gt 0 ]; then
            echo "  ✅ $file_fixes correcciones aplicadas en $file"
        else
            echo "  ✓ Sin errores en $file"
        fi
    fi
done

echo ""
echo "🎉 VALIDACIÓN COMPLETADA"
echo "========================="
echo "📁 Archivos procesados: $files_processed"
echo "🔧 Total de correcciones: $total_fixes"

# Verificar que no quedan errores
remaining_errors=$(grep -r "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html 2>/dev/null | wc -l)
echo "⚠️  Errores restantes: $remaining_errors"

if [ "$remaining_errors" -eq 0 ]; then
    echo "✅ ¡Todos los errores tipográficos han sido corregidos!"
else
    echo "❌ Aún quedan errores por corregir. Revisando..."
    grep -rn "Ã¡\|Ã©\|Ã³\|âœ"\|ðŸ"‚\|ðŸŒ" *.html casos/*.html lab/*.html 2>/dev/null
fi

echo ""
echo "📝 Archivos listos para commit al repositorio Git"