#!/bin/bash

echo "🔧 CORRECCIÓN HEXADECIMAL DE UNICODE - MÉTODO DEFINITIVO"
echo "======================================================="

# Lista de archivos a procesar
files=(
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

# Mapeo de secuencias hexadecimales problemáticas a emojis correctos
declare -A replacements=(
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xe2\x80\x9a']='📂'    # ðŸ"‚ -> 📂
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xc2\xa5']='🔥'        # ðŸ"¥ -> 🔥
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xe2\x80\x96']='📖'    # ðŸ"– -> 📖
    ['\xc3\xb0\xc5\xb8\xc2\xa2']='🏢'                     # ðŸ¢ -> 🏢
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xc5\xa0']='📊'        # ðŸ"Š -> 📊
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xcb\x86']='📈'        # ðŸ"ˆ -> 📈
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xc2\xa7']='🔧'        # ðŸ"§ -> 🔧
    ['\xc3\xb0\xc5\xb8\xc2\x86']='🏆'                     # ðŸ† -> 🏆
    ['\xc3\xb0\xc5\xb8\xe2\x80\x99\xc2\xa1']='💡'        # ðŸ'¡ -> 💡
    ['\xc3\xb0\xc5\xb8\xc2\xa4\xe2\x80\x96']='🤖'        # ðŸ¤– -> 🤖
    ['\xc3\xb0\xc5\xb8\xc5\x92']='🌍'                     # ðŸŒ -> 🌍
    ['\xc3\xb0\xc5\xb8\xc5\xa0\xc2\xac']='🎬'             # ðŸŽ¬ -> 🎬
    ['\xc3\xb0\xc5\xb8\xe2\x80\x9c\xc2\xb1']='📱'        # ðŸ"± -> 📱
    ['\xc3\xb0\xc5\xb8\xe2\x80\x99\xc2\xbc']='💼'        # ðŸ'¼ -> 💼
    ['\xc3\xb0\xc5\xb8\xe2\x80\x99\xc2\xb0']='💰'        # ðŸ'° -> 💰
    ['\xc3\xb0\xc5\xb8\xc5\xa0\xc2\xaf']='🎯'             # ðŸŽ¯ -> 🎯
)

# Procesar cada archivo
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "📝 Procesando: $file"
        
        # Crear backup
        cp "$file" "${file}.hex_backup"
        
        # Aplicar cada reemplazo
        for hex_pattern in "${!replacements[@]}"; do
            emoji="${replacements[$hex_pattern]}"
            sed -i "s/$hex_pattern/$emoji/g" "$file"
        done
        
        # Verificar cambios
        remaining=$(grep -c "ðŸ" "$file" 2>/dev/null || echo "0")
        if [ $remaining -eq 0 ]; then
            echo "  ✅ Completamente limpio"
        else
            echo "  ⚠️  $remaining caracteres ðŸ restantes"
        fi
    else
        echo "  ❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "🔍 VERIFICACIÓN FINAL:"
echo "===================="

total_files_clean=0
total_files_processed=0

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        remaining=$(grep -c "ðŸ" "$file" 2>/dev/null || echo "0")
        total_files_processed=$((total_files_processed + 1))
        
        if [ $remaining -eq 0 ]; then
            echo "  ✅ $file: LIMPIO"
            total_files_clean=$((total_files_clean + 1))
        else
            echo "  ❌ $file: $remaining caracteres problemáticos"
        fi
    fi
done

echo ""
echo "📊 RESUMEN:"
echo "==========="
echo "  Archivos procesados: $total_files_processed"
echo "  Archivos limpios: $total_files_clean"
echo "  Archivos con problemas: $((total_files_processed - total_files_clean))"

if [ $total_files_clean -eq $total_files_processed ]; then
    echo ""
    echo "🎉 ¡ÉXITO TOTAL! Todos los archivos están perfectamente limpios"
    echo ""
    echo "📋 Verificando algunos títulos clave:"
    echo "======================================"
    grep -n "📂.*organización\|🔥.*Narrativa\|🎬.*Testimonios" acciones.html 2>/dev/null | head -3
else
    echo ""
    echo "⚠️  Algunos archivos necesitan revisión manual"
fi

echo ""
echo "✅ Corrección hexadecimal completada"