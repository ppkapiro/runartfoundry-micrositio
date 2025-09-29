#!/bin/bash
# fix-all-typography-complete.sh
# Script COMPLETO para corregir TODOS los errores tipográficos Unicode

echo "🔧 INICIANDO CORRECCIÓN COMPLETA DE TIPOGRAFÍA"
echo "=============================================="

# Definir TODAS las correcciones de emojis encontradas
declare -A corrections=(
    # Emojis de objetos
    ['ðŸ"‚']='📂' ['ðŸ"']='📊' ['ðŸ"ˆ']='📈' ['ðŸ"–']='📖' ['ðŸ"']='📋'
    ['ðŸ"§']='📧' ['ðŸ"±']='📱' ['ðŸ"']='📍' ['ðŸ"„']='📄' ['ðŸ"°']='📰'
    ['ðŸ"¥']='🔥' ['ðŸ"§']='🔧' ['ðŸ"']='🔍' ['ðŸ"º']='📺' ['ðŸ"Š']='📊'
    
    # Emojis de actividades
    ['ðŸŽ¬']='🎬' ['ðŸŽ¨']='🎨' ['ðŸŽ¯']='🎯' ['ðŸŽ"']='🎓' ['ðŸŽ­']='🎭'
    ['ðŸŽŠ']='🎊' ['ðŸŽ¤']='🎤'
    
    # Emojis de edificios y lugares
    ['ðŸ¢']='🏢' ['ðŸ—ï¸']='🏗️' ['ðŸ›¡ï¸']='🛡️'
    
    # Emojis de símbolos
    ['ðŸ†']='🏆' ['ðŸ¤–']='🤖' ['ðŸ¤']='🤝' ['ðŸ'¥']='👥' ['ðŸ'»']='💻'
    ['ðŸ–¨ï¸']='🖨️' ['ðŸº']='🏺'
    
    # Emojis de tiempo
    ['ðŸ•']='🕐'
    
    # Emojis de naturaleza
    ['ðŸŒ']='🌍' ['ðŸŒŽ']='🌎' ['ðŸŒ±']='🌱' ['ðŸŒŠ']='🌊'
    
    # Emojis de ciencia
    ['ðŸ"¬']='🔬'
    
    # Acentos y caracteres especiales
    ['Ã¡']='á' ['Ã©']='é' ['Ã­']='í' ['Ã³']='ó' ['Ãº']='ú'
    ['Ã']='Á' ['Ã‰']='É' ['Ã']='Í' ['Ã"']='Ó' ['Ãš']='Ú'
    ['Ã±']='ñ' ['Ã'']='Ñ'
    
    # Símbolos especiales
    ['âœ"']='✓' ['âœ…']='✅' ['â­']='⭐'
    ['â†'']='→' ['â†']='←' ['â†'']='↑' ['â†"']='↓'
    ['â€¢']='•' ['â€"']='–' ['â€'']='—'
)

# Contadores
total_fixes=0
files_processed=0

echo "📊 Procesando archivos HTML..."

# Procesar todos los archivos HTML
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
                echo "  ✏️  '$wrong' → '$correct' ($count veces)"
                sed -i "s/$wrong/$correct/g" "$file"
                ((file_fixes += count))
                ((total_fixes += count))
            fi
        done
        
        if [ "$file_fixes" -gt 0 ]; then
            echo "  ✅ $file_fixes correcciones en $file"
        else
            echo "  ✓ Sin errores en $file"
        fi
    fi
done

echo ""
echo "🎉 CORRECCIÓN COMPLETA FINALIZADA"
echo "================================="
echo "📁 Archivos procesados: $files_processed"
echo "🔧 Total de correcciones: $total_fixes"

# Verificar errores restantes
echo ""
echo "🔍 Verificando errores restantes..."
remaining_errors=$(grep -r "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | wc -l)
echo "⚠️  Errores Unicode restantes: $remaining_errors"

if [ "$remaining_errors" -eq 0 ]; then
    echo "✅ ¡TODOS los errores tipográficos han sido corregidos!"
else
    echo "❌ Errores que necesitan revisión manual:"
    grep -rn "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | head -10
fi

echo ""
echo "📝 Archivos listos para nuevo deployment"