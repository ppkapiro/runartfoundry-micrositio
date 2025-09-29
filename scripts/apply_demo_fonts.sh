#!/bin/bash

# Script para añadir tipografías demo-venta a todas las páginas principales

echo "🎨 Aplicando tipografías demo-venta..."

# Lista de archivos HTML principales a actualizar
files=(
    "uldis.html"
    "run.html"
    "cronologia.html"
    "evidencias.html"
    "contacto.html"
    "casos/index.html"
    "casos/roman.html"
    "casos/raider.html"
    "lab/index.html"
)

# Patrón de fuentes a añadir
fonts_html='    <!-- DNS prefetch for external resources -->
    <link rel="dns-prefetch" href="//fonts.googleapis.com">
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    
    <!-- Google Fonts - Demo-venta optimized typography -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Lato:ital,wght@0,300;0,400;0,700;0,900;1,400&display=swap" rel="stylesheet">'

for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✏️  Actualizando tipografías: $file"
        
        # Buscar y reemplazar la sección de DNS prefetch
        if grep -q "dns-prefetch.*fonts.googleapis.com" "$file"; then
            # Si ya existe, reemplazar la sección completa
            sed -i '/dns-prefetch.*fonts\.googleapis\.com/,/Stylesheet/{
                /dns-prefetch.*fonts\.googleapis\.com/c\
    <!-- DNS prefetch for external resources -->\
    <link rel="dns-prefetch" href="//fonts.googleapis.com">\
    <link rel="dns-prefetch" href="//fonts.gstatic.com">\
    \
    <!-- Google Fonts - Demo-venta optimized typography -->\
    <link rel="preconnect" href="https://fonts.googleapis.com">\
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Lato:ital,wght@0,300;0,400;0,700;0,900;1,400&display=swap" rel="stylesheet">
                /Stylesheet/!d
            }' "$file"
        else
            echo "⚠️  No se encontró patrón de fuentes en: $file"
        fi
        
        echo "✅ Completado: $file"
    else
        echo "⚠️  Archivo no encontrado: $file"
    fi
done

echo "🎯 Tipografías demo-venta aplicadas a todas las páginas principales"