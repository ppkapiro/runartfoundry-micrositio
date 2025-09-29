#!/bin/bash

echo "🔍 ANÁLISIS PROFUNDO DE CARACTERES PROBLEMÁTICOS"
echo "================================================="
echo ""

# Lista de archivos HTML
html_files=(
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

echo "📊 REPORTE DETALLADO POR ARCHIVO:"
echo "================================="

total_problems=0

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        echo ""
        echo "🔍 $file:"
        echo "$(printf '=%.s' {1..40})"
        
        # Buscar caracteres problemáticos específicos
        problems_found=0
        
        # 1. Emojis con caracteres extra
        emoji_problems=$(grep -n "💡[^[:space:]]\|🎯[^[:space:]]\|📂[^[:space:]]\|📊[^[:space:]]\|🔥[^[:space:]]" "$file" | wc -l)
        if [ $emoji_problems -gt 0 ]; then
            echo "  ❌ Emojis con caracteres extra: $emoji_problems casos"
            grep -n "💡[^[:space:]]\|🎯[^[:space:]]\|📂[^[:space:]]\|📊[^[:space:]]\|🔥[^[:space:]]" "$file" | head -3
            problems_found=$((problems_found + emoji_problems))
        fi
        
        # 2. Caracteres â problemáticos
        a_problems=$(grep -c "â" "$file" 2>/dev/null || echo "0")
        if [ $a_problems -gt 0 ]; then
            echo "  ❌ Caracteres â problemáticos: $a_problems casos"
            grep -n "â" "$file" | head -3
            problems_found=$((problems_found + a_problems))
        fi
        
        # 3. Comillas malformadas
        quote_problems=$(grep -c "â€œ\|â€\|â€™\|â€˜" "$file" 2>/dev/null || echo "0")
        if [ $quote_problems -gt 0 ]; then
            echo "  ❌ Comillas malformadas: $quote_problems casos"
            grep -n "â€œ\|â€\|â€™\|â€˜" "$file" | head -3
            problems_found=$((problems_found + quote_problems))
        fi
        
        # 4. Símbolos de estructura
        struct_problems=$(grep -c "â"œ\|â""\|â"€" "$file" 2>/dev/null || echo "0")
        if [ $struct_problems -gt 0 ]; then
            echo "  ❌ Símbolos de estructura: $struct_problems casos"
            grep -n "â"œ\|â""\|â"€" "$file" | head -3
            problems_found=$((problems_found + struct_problems))
        fi
        
        # 5. Cruces y daggers
        cross_problems=$(grep -c "†\|‡\|✝" "$file" 2>/dev/null || echo "0")
        if [ $cross_problems -gt 0 ]; then
            echo "  ❌ Cruces/daggers: $cross_problems casos"
            grep -n "†\|‡\|✝" "$file" | head -3
            problems_found=$((problems_found + cross_problems))
        fi
        
        # 6. Checkboxes dobles/problemáticos
        checkbox_problems=$(grep -c "☐☐\|□□\|▢▢" "$file" 2>/dev/null || echo "0")
        if [ $checkbox_problems -gt 0 ]; then
            echo "  ❌ Checkboxes problemáticos: $checkbox_problems casos"
            grep -n "☐☐\|□□\|▢▢" "$file" | head -3
            problems_found=$((problems_found + checkbox_problems))
        fi
        
        # 7. Caracteres de control y espacios problemáticos
        control_problems=$(grep -c "Â\|Ã\|À\|Á" "$file" 2>/dev/null || echo "0")
        if [ $control_problems -gt 0 ]; then
            echo "  ❌ Caracteres de control: $control_problems casos"
            grep -n "Â\|Ã\|À\|Á" "$file" | head -3
            problems_found=$((problems_found + control_problems))
        fi
        
        # 8. Símbolos matemáticos malformados
        math_problems=$(grep -c "â‰¥\|â‰¤\|â‰ \|Â±" "$file" 2>/dev/null || echo "0")
        if [ $math_problems -gt 0 ]; then
            echo "  ❌ Símbolos matemáticos: $math_problems casos"
            grep -n "â‰¥\|â‰¤\|â‰ \|Â±" "$file" | head -3
            problems_found=$((problems_found + math_problems))
        fi
        
        # 9. Emojis malformados específicos
        malformed_emoji=$(grep -c "âš\|â­\|â¤\|â¡\|â¢\|â£" "$file" 2>/dev/null || echo "0")
        if [ $malformed_emoji -gt 0 ]; then
            echo "  ❌ Emojis malformados: $malformed_emoji casos"
            grep -n "âš\|â­\|â¤\|â¡\|â¢\|â£" "$file" | head -3
            problems_found=$((problems_found + malformed_emoji))
        fi
        
        # 10. Caracteres raros de puntuación
        punct_problems=$(grep -c "â€¦\|â€¢\|â€°\|â€±" "$file" 2>/dev/null || echo "0")
        if [ $punct_problems -gt 0 ]; then
            echo "  ❌ Puntuación malformada: $punct_problems casos"
            grep -n "â€¦\|â€¢\|â€°\|â€±" "$file" | head -3
            problems_found=$((problems_found + punct_problems))
        fi
        
        if [ $problems_found -eq 0 ]; then
            echo "  ✅ ARCHIVO LIMPIO - Sin problemas detectados"
        else
            echo "  📊 TOTAL PROBLEMAS EN ARCHIVO: $problems_found"
        fi
        
        total_problems=$((total_problems + problems_found))
    else
        echo "❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "🏁 RESUMEN FINAL DEL ANÁLISIS:"
echo "=============================="
echo "  Total de archivos analizados: ${#html_files[@]}"
echo "  Total de problemas encontrados: $total_problems"
echo ""

if [ $total_problems -eq 0 ]; then
    echo "🎉 ¡PERFECTO! Todos los archivos están completamente limpios"
else
    echo "⚠️  Se encontraron $total_problems problemas que necesitan corrección"
    echo ""
    echo "🔧 PATRONES DETECTADOS PARA CORRECCIÓN:"
    echo "======================================="
    
    # Mostrar ejemplos de los patrones más comunes
    echo "📋 Ejemplos de patrones problemáticos encontrados:"
    for file in "${html_files[@]}"; do
        if [ -f "$file" ]; then
            echo ""
            echo "En $file:"
            # Mostrar una muestra de cada tipo de problema
            grep -o "💡[^[:space:]]\|🎯[^[:space:]]\|â[^[:space:]]*\|†\|☐☐" "$file" 2>/dev/null | sort | uniq -c | head -5
        fi
    done
fi

echo ""
echo "✅ Análisis profundo completado"