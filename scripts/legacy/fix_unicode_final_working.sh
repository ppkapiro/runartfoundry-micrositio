#!/bin/bash

echo "🔧 CORRECCIÓN DEFINITIVA DE CARACTERES UNICODE"
echo "=============================================="

# Función para procesar cada archivo
fix_file() {
    local file="$1"
    echo "📝 Procesando: $file"
    
    # Crear backup
    cp "$file" "${file}.backup"
    
    # Usar perl para reemplazos más confiables
    perl -i -pe 's/ðŸ"‚/📂/g' "$file"
    perl -i -pe 's/ðŸ"¥/🔥/g' "$file"
    perl -i -pe 's/ðŸ"–/📖/g' "$file"
    perl -i -pe 's/ðŸ¢/🏢/g' "$file"
    perl -i -pe 's/ðŸ"Š/📊/g' "$file"
    perl -i -pe 's/ðŸ"ˆ/📈/g' "$file"
    perl -i -pe 's/ðŸ"§/🔧/g' "$file"
    perl -i -pe 's/ðŸ†/🏆/g' "$file"
    perl -i -pe 's/ðŸ'¡/💡/g' "$file"
    perl -i -pe 's/ðŸ¤–/🤖/g' "$file"
    perl -i -pe 's/ðŸŒ/🌍/g' "$file"
    perl -i -pe 's/ðŸŽ¬/🎬/g' "$file"
    perl -i -pe 's/ðŸ"±/📱/g' "$file"
    perl -i -pe 's/ðŸ'¼/💼/g' "$file"
    perl -i -pe 's/ðŸ'°/💰/g' "$file"
    perl -i -pe 's/ðŸŽ¯/🎯/g' "$file"
    
    # Verificar cambios
    if ! diff -q "$file" "${file}.backup" > /dev/null 2>&1; then
        local changes=$(diff "${file}.backup" "$file" | grep "^[<>]" | wc -l)
        echo "  ✅ $changes líneas modificadas"
    else
        echo "  ℹ️  Sin cambios necesarios"
    fi
}

# Lista de archivos a procesar
files_to_fix=(
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

# Procesar archivos
for file in "${files_to_fix[@]}"; do
    if [ -f "$file" ]; then
        fix_file "$file"
    else
        echo "⚠️  Archivo no encontrado: $file"
    fi
done

echo ""
echo "🔍 VERIFICACIÓN FINAL:"
echo "===================="

# Contar caracteres restantes
total_remaining=0
for file in "${files_to_fix[@]}"; do
    if [ -f "$file" ]; then
        count=$(grep -c "ðŸ" "$file" 2>/dev/null || echo "0")
        if [ $count -gt 0 ]; then
            echo "  ❌ $file: $count caracteres ðŸ restantes"
            total_remaining=$((total_remaining + count))
        else
            echo "  ✅ $file: Limpio"
        fi
    fi
done

echo ""
if [ $total_remaining -eq 0 ]; then
    echo "🎉 ¡ÉXITO TOTAL! Todos los caracteres Unicode fueron corregidos"
    echo ""
    echo "📋 Verificando contenido clave:"
    grep -n "organización\|Narrativa\|Testimonios\|Estrategia" acciones.html | head -3
else
    echo "⚠️  Quedan $total_remaining caracteres problemáticos por revisar"
fi

echo ""
echo "✅ Proceso completado"