#!/bin/bash
# unicode_fixer_complete.sh
# Script DEFINITIVO para corregir TODOS los caracteres Unicode malformados

echo "🔧 CORRECTOR UNICODE DEFINITIVO"
echo "==============================="
echo ""

# Función para mostrar progreso
show_progress() {
    echo "  ✏️  $1 → $2 ($3 ocurrencias en $4)"
}

# Función para corregir usando múltiples métodos
fix_unicode_char() {
    local file="$1"
    local wrong="$2" 
    local correct="$3"
    local count=0
    
    # Método 1: Perl (mejor para Unicode)
    if command -v perl >/dev/null 2>&1; then
        count=$(perl -ne "print \$1 while /$wrong/g" "$file" 2>/dev/null | wc -c)
        if [ "$count" -gt 0 ]; then
            perl -i -pe "s/$wrong/$correct/g" "$file" 2>/dev/null
            show_progress "$wrong" "$correct" "$count" "$file"
            return 0
        fi
    fi
    
    # Método 2: sed con codificación específica
    if [ "$count" -eq 0 ]; then
        count=$(grep -o "$wrong" "$file" 2>/dev/null | wc -l)
        if [ "$count" -gt 0 ]; then
            sed -i "s/$wrong/$correct/g" "$file" 2>/dev/null
            show_progress "$wrong" "$correct" "$count" "$file"
            return 0
        fi
    fi
    
    return 1
}

# MAPEO COMPLETO DE CORRECCIONES - Todos los caracteres encontrados
declare -A unicode_map=(
    # Emojis de documentos y objetos
    ["ðŸ""]="📋"
    ["ðŸ"„"]="📄" 
    ["ðŸ"‚"]="📂"
    ["ðŸ"Š"]="📊"
    ["ðŸ"ˆ"]="📈"
    ["ðŸ"°"]="📰"
    ["ðŸ"–"]="📖"
    
    # Emojis de comunicación
    ["ðŸ"§"]="📧"
    ["ðŸ"±"]="📱"
    ["ðŸ""]="📍"
    
    # Emojis de herramientas
    ["ðŸ"¥"]="🔥"
    ["ðŸ"§"]="🔧" 
    ["ðŸ""]="🔍"
    
    # Emojis de multimedia
    ["ðŸ"º"]="📺"
    ["ðŸŽ¬"]="🎬"
    ["ðŸŽ¨"]="🎨"
    ["ðŸŽ¯"]="🎯"
    ["ðŸŽ""]="🎓"
    ["ðŸŽ­"]="🎭"
    ["ðŸŽŠ"]="🎊"
    ["ðŸŽ¤"]="🎤"
    
    # Emojis de edificios
    ["ðŸ¢"]="🏢"
    ["ðŸ—ï¸"]="🏗️"
    
    # Emojis de premios y símbolos
    ["ðŸ†"]="🏆"
    ["ðŸ¤–"]="🤖"
    ["ðŸ¤"]="🤝"
    ["ðŸ'¥"]="👥"
    ["ðŸ'»"]="💻"
    ["ðŸº"]="🏺"
    ["ðŸ•"]="🕐"
    ["ðŸ"¬"]="🔬"
    ["ðŸ–¨ï¸"]="🖨️"
    ["ðŸ›¡ï¸"]="🛡️"
    
    # Emojis de naturaleza  
    ["ðŸŒ"]="🌍"
    ["ðŸŒŽ"]="🌎"
    ["ðŸŒ±"]="🌱"
    ["ðŸŒŠ"]="🌊"
)

echo "📋 Iniciando corrección de $(echo ${!unicode_map[@]} | wc -w) caracteres Unicode diferentes..."
echo ""

# Contadores globales
total_files=0
total_corrections=0
files_with_corrections=0

# Procesar todos los archivos HTML
for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        echo "📄 Procesando: $file"
        ((total_files++))
        
        file_corrections=0
        
        # Aplicar todas las correcciones
        for wrong_char in "${!unicode_map[@]}"; do
            correct_char="${unicode_map[$wrong_char]}"
            
            if fix_unicode_char "$file" "$wrong_char" "$correct_char"; then
                ((file_corrections++))
                ((total_corrections++))
            fi
        done
        
        if [ "$file_corrections" -gt 0 ]; then
            echo "  ✅ $file_corrections correcciones aplicadas"
            ((files_with_corrections++))
        else
            echo "  ✓ Sin errores Unicode"
        fi
        echo ""
    fi
done

echo "🎉 CORRECCIÓN COMPLETADA"
echo "========================"
echo "📁 Archivos procesados: $total_files"
echo "📝 Archivos corregidos: $files_with_corrections" 
echo "🔧 Total correcciones: $total_corrections"
echo ""

# Verificación final
echo "🔍 VERIFICACIÓN FINAL..."
remaining_errors=0
for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        errors=$(grep -c "ðŸ" "$file" 2>/dev/null || echo "0")
        remaining_errors=$((remaining_errors + errors))
        if [ "$errors" -gt 0 ]; then
            echo "⚠️  $file: $errors errores restantes"
        fi
    fi
done

echo ""
if [ "$remaining_errors" -eq 0 ]; then
    echo "✅ ¡PERFECTO! Todos los caracteres Unicode han sido corregidos"
    echo "✅ El proyecto está listo para deployment limpio"
else
    echo "❌ $remaining_errors caracteres Unicode aún necesitan atención"
    echo "🔍 Mostrando primeros 5 errores restantes:"
    grep -rn "ðŸ" *.html casos/*.html lab/*.html 2>/dev/null | head -5
fi

echo ""
echo "📝 Archivos listos para commit y deployment"