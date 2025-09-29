#!/bin/bash

echo "🔄 RESTAURANDO BOTÓN INICIO Y ELIMINANDO LOGO"
echo "============================================="
echo ""
echo "Cambios a aplicar:"
echo "• ❌ Eliminar logo 'RUN Art Foundry'"
echo "• ✅ Restaurar botón 'Inicio' en menú"
echo "• 🎯 Navegación simple como solicitaste"
echo ""

# Lista de archivos HTML a actualizar
html_files=(
    "index.html"
    "acciones.html"
    "contacto.html"
    "cronologia.html"
    "evidencias.html"
    "run.html"
    "uldis.html"
    "casos/index.html"
    "casos/raider.html"
    "casos/roman.html"
    "lab/index.html"
)

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        echo "📝 Procesando: $file"
        
        # Crear backup
        cp "$file" "${file}.logo_backup"
        
        # Determinar rutas según el directorio
        if [[ "$file" == casos/* ]] || [[ "$file" == lab/* ]]; then
            # Archivos en subdirectorios
            
            # 1. Eliminar el logo completo
            perl -i -pe '
                # Eliminar toda la sección del logo (incluyendo las líneas alrededor)
                if (/class="logo"/) {
                    $_ = "";
                    # También eliminar las líneas siguientes del logo
                    while (<>) {
                        last if /<\/a>/;
                        $_ = "";
                    }
                    $_ = "";
                }
            ' "$file"
            
            # 2. Agregar botón Inicio al principio del menú
            perl -i -pe 's|(<ul class="nav-list" id="nav-list">)|$1\n                        <li><a href="../index.html" class="nav-link">Inicio</a></li>|' "$file"
            
        else
            # Archivos en directorio raíz
            
            # 1. Eliminar el logo completo
            perl -i -pe '
                # Eliminar toda la sección del logo
                if (/class="logo"/) {
                    $_ = "";
                    while (<>) {
                        last if /<\/a>/;
                        $_ = "";
                    }
                    $_ = "";
                }
            ' "$file"
            
            # 2. Agregar botón Inicio al principio del menú
            perl -i -pe 's|(<ul class="nav-list" id="nav-list">)|$1\n                        <li><a href="index.html" class="nav-link">Inicio</a></li>|' "$file"
        fi
        
        echo "  ✅ Logo eliminado y botón Inicio restaurado"
    else
        echo "  ❌ Archivo no encontrado: $file"
    fi
done

echo ""
echo "✅ CAMBIOS COMPLETADOS"
echo "====================="
echo ""
echo "📊 Resultado:"
echo "• ❌ Logo 'RUN Art Foundry' eliminado de header"
echo "• ✅ Botón 'Inicio' restaurado en menú de navegación"
echo "• 🎯 Navegación simple y directa como solicitaste"