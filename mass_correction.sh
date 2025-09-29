#!/bin/bash

echo "🔧 CORRECCIÓN MASIVA BASADA EN ANÁLISIS PROFUNDO"
echo "================================================"
echo ""

# Lista de archivos a procesar
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

total_corrections=0

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        echo "🔧 Procesando: $file"
        
        # Crear backup
        cp "$file" "${file}.mass_backup"
        
        corrections_in_file=0
        
        # 1. CORRECCIONES DE EMOJIS CON CARACTERES EXTRA ESPECÍFICOS
        # Basado en los patrones encontrados en el análisis
        
        # Narrativa y documentos
        perl -i -pe 's/💡"–/📖/g' "$file" && ((corrections_in_file++))
        perl -i -pe 's/💡"°/📰/g' "$file" && ((corrections_in_file++))
        perl -i -pe 's/💡"/📄/g' "$file" && ((corrections_in_file++))
        perl -i -pe 's/💡"„/📋/g' "$file" && ((corrections_in_file++))
        perl -i -pe 's/💡"š/👨‍🎨/g' "$file" && ((corrections_in_file++))
        
        # Ubicación y lugares
        perl -i -pe 's/💡¢/🏢/g' "$file" && ((corrections_in_file++))
        
        # Instalación y herramientas
        perl -i -pe 's/💡—ï¸/🛠️/g' "$file" && ((corrections_in_file++))
        perl -i -pe 's/💡"§/🔧/g' "$file" && ((corrections_in_file++))
        
        # Reconocimientos y logros
        perl -i -pe 's/💡†/🏆/g' "$file" && ((corrections_in_file++))
        
        # Tiempo y cronología
        perl -i -pe 's/💡"…/⏰/g' "$file" && ((corrections_in_file++))
        
        # Impacto y efectos
        perl -i -pe 's/💡'"'"'¥/💥/g' "$file" && ((corrections_in_file++))
        
        # Tecnología y digital
        perl -i -pe 's/💡'"'"'»/💻/g' "$file" && ((corrections_in_file++))
        perl -i -pe 's/💡Ž/💾/g' "$file" && ((corrections_in_file++))
        
        # 2. CORRECCIONES DE CHECKMARKS PROBLEMÁTICOS
        perl -i -pe 's/âœ"/✓/g' "$file" && ((corrections_in_file++))
        
        # 3. CORRECCIONES DE ADVERTENCIAS MALFORMADAS
        perl -i -pe 's/âš ï¸/⚠️/g' "$file" && ((corrections_in_file++))
        
        # 4. CORRECCIÓN DE GRADOS (360°)
        perl -i -pe 's/360Â°/360°/g' "$file" && ((corrections_in_file++))
        
        # 5. CORRECCIONES DE CRUCES/DAGGERS RESTANTES
        perl -i -pe 's/†/🏆/g' "$file" && ((corrections_in_file++))
        
        # 6. LIMPIAR CARACTERES CONTROL RESIDUALES
        perl -i -pe 's/Â//g' "$file" && ((corrections_in_file++))
        
        # Verificar resultado
        remaining_problems=0
        remaining_problems=$((remaining_problems + $(grep -c "💡[^[:space:]]" "$file" 2>/dev/null || echo "0")))
        remaining_problems=$((remaining_problems + $(grep -c "âœ\|âš\|†\|Â" "$file" 2>/dev/null || echo "0")))
        
        if [ $remaining_problems -eq 0 ]; then
            echo "  ✅ COMPLETAMENTE LIMPIO ($corrections_in_file correcciones aplicadas)"
        else
            echo "  ⚠️  $remaining_problems problemas restantes ($corrections_in_file correcciones aplicadas)"
        fi
        
        total_corrections=$((total_corrections + corrections_in_file))
    else
        echo "  ❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "📊 RESUMEN DE CORRECCIÓN MASIVA:"
echo "================================"
echo "  Total de correcciones aplicadas: $total_corrections"
echo ""

# Verificación final
echo "🔍 VERIFICACIÓN FINAL:"
echo "====================="

total_clean=0
total_files=0

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        total_files=$((total_files + 1))
        
        # Contar problemas restantes
        problems=0
        problems=$((problems + $(grep -c "💡[^[:space:]]" "$file" 2>/dev/null || echo "0")))
        problems=$((problems + $(grep -c "âœ\|âš\|†\|Â" "$file" 2>/dev/null || echo "0")))
        
        if [ $problems -eq 0 ]; then
            echo "  ✅ $file: PERFECTO"
            total_clean=$((total_clean + 1))
        else
            echo "  ❌ $file: $problems problemas"
            # Mostrar ejemplos de lo que queda
            grep -o "💡[^[:space:]]\|âœ[^[:space:]]*\|âš[^[:space:]]*" "$file" 2>/dev/null | head -2
        fi
    fi
done

echo ""
echo "🏁 RESULTADO FINAL:"
echo "=================="
echo "  Archivos procesados: $total_files"
echo "  Archivos completamente limpios: $total_clean"
echo "  Porcentaje de éxito: $((total_clean * 100 / total_files))%"

if [ $total_clean -eq $total_files ]; then
    echo ""
    echo "🎉 ¡ÉXITO TOTAL! Todos los archivos están perfectamente limpios"
    echo "✅ Todas las correcciones de caracteres Unicode completadas"
else
    echo ""
    echo "⚠️  $((total_files - total_clean)) archivos necesitan revisión adicional"
fi

echo ""
echo "✅ Corrección masiva completada"