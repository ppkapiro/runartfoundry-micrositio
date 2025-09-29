#!/bin/bash
# Script de validación de tipografía con soporte Unicode completo

echo '🔍 Iniciando validación de tipografía...'

# Contadores
total_errors=0
files_with_errors=0

# Función para procesar archivos HTML
process_html_file() {
    local file=\
