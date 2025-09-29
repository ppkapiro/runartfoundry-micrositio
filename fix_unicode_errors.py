#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import glob

# Definir correcciones Unicode
corrections = {
    'ðŸ"‚': '📂',  
    'ðŸ"Š': '📊',
    'ðŸ"ˆ': '📈',
    'ðŸ"–': '📖',
    'ðŸ"‹': '📋',
    'ðŸ"§': '📧',
    'ðŸ"±': '📱',
    'ðŸ"': '📍',
    'ðŸ"„': '📄',
    'ðŸ"°': '📰',
    'ðŸ"¥': '🔥',
    'ðŸ"§': '🔧',
    'ðŸ"': '🔍',
    'ðŸ"º': '📺',
    'ðŸŽ¬': '🎬',
    'ðŸŽ¨': '🎨',
    'ðŸŽ¯': '🎯',
    'ðŸŽ"': '🎓',
    'ðŸŽ­': '🎭',
    'ðŸŽŠ': '🎊',
    'ðŸŽ¤': '🎤',
    'ðŸ¢': '🏢',
    'ðŸ—ï¸': '🏗️',
    'ðŸ†': '🏆',
    'ðŸ¤–': '🤖',
    'ðŸ¤': '🤝',
    'ðŸ'¥': '👥',
    'ðŸ'»': '💻',
    'ðŸº': '🏺',
    'ðŸ•': '🕐',
    'ðŸ"¬': '🔬',
    'ðŸ–¨ï¸': '🖨️',
    'ðŸ›¡ï¸': '🛡️'
}

print("🔧 CORRIGIENDO TODOS LOS ERRORES TIPOGRÁFICOS")
print("=" * 50)

files_corrected = 0
total_corrections = 0

# Procesar archivos HTML
for pattern in ['*.html', 'casos/*.html', 'lab/*.html']:
    for filepath in glob.glob(pattern):
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            original_content = content
            file_corrections = 0
            
            # Aplicar correcciones
            for wrong, correct in corrections.items():
                if wrong in content:
                    count = content.count(wrong)
                    content = content.replace(wrong, correct)
                    if count > 0:
                        print(f'  ✏️  {filepath}: {wrong} → {correct} ({count} veces)')
                        file_corrections += count
                        total_corrections += count
            
            # Guardar si hubo cambios
            if content != original_content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                files_corrected += 1
                print(f'  ✅ {file_corrections} correcciones aplicadas en {filepath}')
                
        except Exception as e:
            print(f'❌ Error en {filepath}: {e}')

print(f'\n🎉 CORRECCIÓN COMPLETADA')
print(f'📁 Archivos corregidos: {files_corrected}')
print(f'🔧 Total correcciones: {total_corrections}')

# Verificar errores restantes
print(f'\n🔍 Verificando errores restantes...')
remaining_errors = 0
for pattern in ['*.html', 'casos/*.html', 'lab/*.html']:
    for filepath in glob.glob(pattern):
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Buscar cualquier ðŸ restante
            if 'ðŸ' in content:
                count = content.count('ðŸ')
                remaining_errors += count
                print(f'⚠️  {filepath}: {count} errores Unicode restantes')
                
        except Exception as e:
            print(f'❌ Error verificando {filepath}: {e}')

if remaining_errors == 0:
    print('✅ ¡TODOS los errores tipográficos han sido corregidos!')
else:
    print(f'❌ {remaining_errors} errores Unicode aún necesitan corrección')

print('\n📝 Archivos listos para deployment')