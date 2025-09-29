#!/bin/bash

# Script para corregir caracteres Unicode malformados de manera selectiva
# Solo reemplaza secuencias específicas conocidas, preservando el contenido legítimo

echo "🔧 INICIANDO CORRECCIÓN SELECTIVA DE UNICODE..."
echo "============================================"

# Función para corregir un archivo específico
fix_unicode_file() {
    local file="$1"
    local backup="${file}.backup"
    
    echo "📝 Procesando: $file"
    
    # Crear backup
    cp "$file" "$backup"
    
    # Reemplazos específicos y seguros de emojis conocidos
    sed -i 's/ðŸ"‚/📂/g' "$file"  # Folder
    sed -i 's/ðŸ"¥/🔥/g' "$file"  # Fire
    sed -i 's/ðŸ"–/📖/g' "$file"  # Book
    sed -i 's/ðŸ¢/🢠/g' "$file"  # Building o similar
    sed -i 's/ðŸ"Š/📊/g' "$file"  # Chart
    sed -i 's/ðŸ'¼/💼/g' "$file"  # Briefcase
    sed -i 's/ðŸ'°/💰/g' "$file"  # Money
    sed -i 's/ðŸŽ¬/🎬/g' "$file"  # Movie camera
    sed -i 's/ðŸ"±/📱/g' "$file"  # Mobile phone
    sed -i 's/ðŸ"/📺/g' "$file"   # TV
    sed -i 's/ðŸ§ /🧠/g' "$file"  # Brain
    
    # Verificar cambios
    local changes=$(diff -u "$backup" "$file" | wc -l)
    if [ $changes -gt 0 ]; then
        echo "  ✅ $changes líneas corregidas"
    else
        echo "  ℹ️  Sin cambios necesarios"
    fi
}

# Lista de archivos HTML a procesar
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

# Procesar cada archivo
for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        fix_unicode_file "$file"
    else
        echo "⚠️  Archivo no encontrado: $file"
    fi
done

echo ""
echo "📊 RESUMEN FINAL:"
echo "================"

# Contar caracteres problemáticos restantes
total_remaining=0
for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        count=$(grep -o "ðŸ" "$file" 2>/dev/null | wc -l)
        if [ $count -gt 0 ]; then
            echo "  $file: $count caracteres ðŸ restantes"
            total_remaining=$((total_remaining + count))
        fi
    fi
done

if [ $total_remaining -eq 0 ]; then
    echo "🎉 ¡ÉXITO! Todos los caracteres Unicode fueron corregidos"
else
    echo "⚠️  Quedan $total_remaining caracteres por revisar manualmente"
fi

echo ""
echo "🔍 Verificando integridad del contenido..."
grep -c "organización\|Narrativa\|Testimonios\|Estrategia\|automatización" *.html | grep -v ":0" | head -3

echo ""
echo "✅ Corrección completada de manera selectiva y segura"