#!/bin/bash

# Script mejorado para corregir caracteres Unicode malformados
# Usa Python para manejar mejor los caracteres especiales

echo "🔧 CORRECCIÓN AVANZADA DE UNICODE CON PYTHON..."
echo "=============================================="

# Crear script Python temporal
cat > fix_unicode.py << 'EOF'
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import sys
import os

def fix_unicode_file(filepath):
    """Corrige caracteres Unicode malformados en un archivo."""
    try:
        # Leer archivo
        with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
            content = f.read()
        
        original_content = content
        
        # Reemplazos específicos de secuencias malformadas conocidas
        replacements = {
            'ðŸ"‚': '📂',  # Folder
            'ðŸ"¥': '🔥',  # Fire
            'ðŸ"–': '📖',  # Book
            'ðŸ¢': '🏢',   # Building
            'ðŸ"Š': '📊',  # Chart
            'ðŸ'¼': '💼',  # Briefcase
            'ðŸ'°': '💰',  # Money
            'ðŸŽ¬': '🎬',  # Movie camera
            'ðŸ"±': '📱',  # Mobile phone
            'ðŸ"': '📺',   # TV
            'ðŸ§ ': '🧠',  # Brain
            'ðŸ¤–': '🤖',  # Robot
            'ðŸŒ': '🌍',   # Globe
            'ðŸ"': '🔍',   # Magnifying glass
            'ðŸ"…': '📅',  # Calendar
            'ðŸ"ˆ': '📈',  # Chart increasing
            'ðŸŽ¯': '🎯',  # Target
            'ðŸ'¡': '💡',  # Light bulb
        }
        
        # Aplicar reemplazos
        for old, new in replacements.items():
            content = content.replace(old, new)
        
        # Verificar si hubo cambios
        changes_made = content != original_content
        
        if changes_made:
            # Escribir archivo corregido
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            
            # Contar reemplazos
            total_replacements = sum(original_content.count(old) for old in replacements.keys())
            print(f"  ✅ {filepath}: {total_replacements} caracteres corregidos")
        else:
            print(f"  ℹ️  {filepath}: Sin cambios necesarios")
            
        return changes_made
        
    except Exception as e:
        print(f"  ❌ Error procesando {filepath}: {e}")
        return False

def main():
    html_files = [
        "acciones.html",
        "contacto.html", 
        "cronologia.html",
        "evidencias.html",
        "index.html",
        "run.html",
        "uldis.html",
        "casos/index.html",
        "casos/raider.html", 
        "casos/roman.html",
        "lab/index.html"
    ]
    
    total_files_processed = 0
    total_files_changed = 0
    
    for file in html_files:
        if os.path.exists(file):
            if fix_unicode_file(file):
                total_files_changed += 1
            total_files_processed += 1
        else:
            print(f"  ⚠️  Archivo no encontrado: {file}")
    
    print(f"\n📊 RESUMEN: {total_files_changed}/{total_files_processed} archivos modificados")

if __name__ == "__main__":
    main()
EOF

# Ejecutar el script Python
python3 fix_unicode.py

# Verificar resultados
echo ""
echo "🔍 VERIFICACIÓN FINAL:"
echo "===================="

# Contar caracteres problemáticos restantes
total_remaining=0
for file in *.html casos/*.html lab/*.html; do
    if [ -f "$file" ]; then
        count=$(python3 -c "
with open('$file', 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()
    print(content.count('ðŸ'))
" 2>/dev/null)
        if [ "$count" -gt 0 ]; then
            echo "  $file: $count caracteres ðŸ restantes"
            total_remaining=$((total_remaining + count))
        fi
    fi
done

if [ $total_remaining -eq 0 ]; then
    echo "🎉 ¡PERFECTO! Todos los caracteres Unicode malformados fueron corregidos"
else
    echo "⚠️  Quedan $total_remaining caracteres problemáticos"
fi

# Limpiar archivo temporal
rm -f fix_unicode.py

echo ""
echo "✅ Corrección avanzada completada"