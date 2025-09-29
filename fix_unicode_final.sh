#!/bin/bash
# fix_unicode_final.sh
# Script definitivo para eliminar TODOS los caracteres Unicode problemáticos

echo "🔧 CORRECTOR UNICODE DEFINITIVO - ELIMINACIÓN TOTAL"
echo "=================================================="

# Función para mostrar reemplazos
show_replacement() {
    echo "  ✏️  $1 → $2 ($3 veces en $4)"
}

# Contadores
total_files=0
total_replacements=0

echo ""
echo "📄 Procesando archivos HTML..."

# Procesar cada archivo HTML
for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        echo "📄 Procesando: $file"
        ((total_files++))
        
        file_replacements=0
        
        # REEMPLAZOS ESPECÍFICOS CON TEXTO CLARO
        
        # Documentos y gráficos → texto descriptivo
        if grep -q 'ðŸ"Š' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"Š' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"Š/📊/g' "$file" 2>/dev/null || sed -i 's/ðŸ"Š/[GRÁFICO]/g' "$file"
            show_replacement "ðŸ"Š" "📊/[GRÁFICO]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ"ˆ' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"ˆ' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"ˆ/📈/g' "$file" 2>/dev/null || sed -i 's/ðŸ"ˆ/[ESTADÍSTICA]/g' "$file"
            show_replacement "ðŸ"ˆ" "📈/[ESTADÍSTICA]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ"' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"/📋/g' "$file" 2>/dev/null || sed -i 's/ðŸ"/[LISTA]/g' "$file"
            show_replacement "ðŸ"" "📋/[LISTA]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ"„' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"„' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"„/📄/g' "$file" 2>/dev/null || sed -i 's/ðŸ"„/[DOCUMENTO]/g' "$file"
            show_replacement "ðŸ"„" "📄/[DOCUMENTO]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ"§' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"§' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"§/📧/g' "$file" 2>/dev/null || sed -i 's/ðŸ"§/[EMAIL]/g' "$file"
            show_replacement "ðŸ"§" "📧/[EMAIL]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        # Premios y construcción
        if grep -q 'ðŸ†' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ†' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ†/🏆/g' "$file" 2>/dev/null || sed -i 's/ðŸ†/[PREMIO]/g' "$file"
            show_replacement "ðŸ†" "🏆/[PREMIO]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ—ï¸' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ—ï¸' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ—ï¸/🏗️/g' "$file" 2>/dev/null || sed -i 's/ðŸ—ï¸/[CONSTRUCCIÓN]/g' "$file"
            show_replacement "ðŸ—ï¸" "🏗️/[CONSTRUCCIÓN]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        # Herramientas
        if grep -q 'ðŸ"¥' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"¥' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"¥/🔥/g' "$file" 2>/dev/null || sed -i 's/ðŸ"¥/[DESTACADO]/g' "$file"
            show_replacement "ðŸ"¥" "🔥/[DESTACADO]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ"°' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ"°' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ"°/📰/g' "$file" 2>/dev/null || sed -i 's/ðŸ"°/[NOTICIAS]/g' "$file"
            show_replacement "ðŸ"°" "📰/[NOTICIAS]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        # Otros elementos específicos
        if grep -q 'ðŸ'»' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ'»' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ'»/💻/g' "$file" 2>/dev/null || sed -i 's/ðŸ'»/[DIGITAL]/g' "$file"
            show_replacement "ðŸ'»" "💻/[DIGITAL]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸº' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸº' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸº/🏺/g' "$file" 2>/dev/null || sed -i 's/ðŸº/[ARTE]/g' "$file"
            show_replacement "ðŸº" "🏺/[ARTE]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        if grep -q 'ðŸ¢' "$file" 2>/dev/null; then
            count=$(grep -o 'ðŸ¢' "$file" 2>/dev/null | wc -l)
            sed -i 's/ðŸ¢/🏢/g' "$file" 2>/dev/null || sed -i 's/ðŸ¢/[EMPRESA]/g' "$file"
            show_replacement "ðŸ¢" "🏢/[EMPRESA]" "$count" "$file"
            ((file_replacements += count))
        fi
        
        # ELIMINACIÓN DE CUALQUIER CARÁCTER ðŸ RESTANTE
        if grep -q 'ðŸ' "$file" 2>/dev/null; then
            remaining=$(grep -o 'ðŸ[^ ]*' "$file" 2>/dev/null | wc -l)
            if [ "$remaining" -gt 0 ]; then
                # Eliminar completamente cualquier secuencia ðŸ restante
                sed -i 's/ðŸ[^ ]*//g' "$file"
                echo "  🗑️  Eliminados $remaining caracteres ðŸ restantes"
                ((file_replacements += remaining))
            fi
        fi
        
        total_replacements=$((total_replacements + file_replacements))
        
        if [ "$file_replacements" -gt 0 ]; then
            echo "  ✅ $file_replacements correcciones aplicadas"
        else
            echo "  ✓ Sin errores Unicode"
        fi
        echo ""
    fi
done

echo "🎉 CORRECCIÓN COMPLETADA"
echo "========================="
echo "📁 Archivos procesados: $total_files"
echo "🔧 Total correcciones: $total_replacements"
echo ""

# Verificación final
echo "🔍 VERIFICACIÓN FINAL..."
remaining_errors=0
problem_files=()

for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        errors=$(grep -c 'ðŸ' "$file" 2>/dev/null || echo "0")
        if [ "$errors" -gt 0 ]; then
            remaining_errors=$((remaining_errors + errors))
            problem_files+=("$file")
        fi
    fi
done

if [ "$remaining_errors" -eq 0 ]; then
    echo "✅ ¡PERFECTO! Todos los caracteres Unicode problemáticos eliminados"
    echo "✅ El sitio está completamente limpio"
else
    echo "❌ $remaining_errors caracteres Unicode aún presentes en:"
    for pfile in "${problem_files[@]}"; do
        echo "   - $pfile"
    done
fi

echo ""
echo "📝 Archivos listos para deployment final"