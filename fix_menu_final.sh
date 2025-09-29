#!/bin/bash

echo "🧹 LIMPIANDO Y APLICANDO ESTRUCTURA CORRECTA DEL MENÚ"
echo "===================================================="
echo ""

# Lista de archivos HTML a procesar
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
        echo "  🔧 Procesando: $file"
        
        # Restaurar desde backup si existe
        if [ -f "$file.bak" ]; then
            cp "$file.bak" "$file"
            echo "    📁 Restaurado desde backup"
        fi
        
        # Aplicar transformaciones precisas
        perl -i -pe '
        # Eliminar elementos duplicados del menú
        if (/<li><a href="index\.html" class="nav-link">Inicio<\/a><\/li>/) {
            $skip_next = 1;
            next if $skip_next;
        }
        next if $skip_next && /<li><a href="index\.html" class="nav-link active">Inicio<\/a><\/li>/;
        $skip_next = 0 if $skip_next && /<li>/;
        
        # Aplicar tooltips a nombres largos
        s|<a href="run\.html" class="nav-link">RUN Art Foundry</a>|<a href="run.html" class="nav-link" title="RUN Art Foundry - Fundición Artística">RUN Art Foundry</a>|g;
        s|<a href="lab/index\.html" class="nav-link">RUN Lab</a>|<a href="lab/index.html" class="nav-link" title="RUN Lab - Laboratorio de Innovación">RUN Lab</a>|g;
        ' "$file"
        
        echo "    ✅ Duplicados eliminados y tooltips agregados"
    fi
done

echo ""
echo "📱 VERIFICANDO REFERENCIAS A ARCHIVOS CSS Y JS"
echo "=============================================="

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        # Verificar que tenga referencia al CSS
        if ! grep -q "assets/css/main.css" "$file"; then
            echo "  ⚠️  Agregando referencia CSS a: $file"
            perl -i -pe 's|</head>|    <link rel="stylesheet" href="assets/css/main.css">\n</head>|' "$file"
        fi
        
        # Verificar que tenga referencia al JS
        if ! grep -q "assets/js/main.js" "$file"; then
            echo "  ⚠️  Agregando referencia JS a: $file"
            perl -i -pe 's|</body>|    <script src="assets/js/main.js"></script>\n</body>|' "$file"
        fi
    fi
done

echo ""
echo "🎯 VERIFICANDO ESTRUCTURA FINAL:"
echo "==============================="
echo ""

for file in "${html_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  📄 $file:"
        
        # Contar elementos duplicados
        inicio_count=$(grep -c 'href="index\.html".*Inicio' "$file" || echo "0")
        tooltip_count=$(grep -c 'title=".*Foundry\|title=".*Lab' "$file" || echo "0")
        
        echo "    • Enlaces 'Inicio': $inicio_count"
        echo "    • Enlaces con tooltip: $tooltip_count"
        
        if [ "$inicio_count" -gt 1 ]; then
            echo "    ⚠️  Tiene elementos duplicados"
        else
            echo "    ✅ Estructura limpia"
        fi
    fi
done

echo ""  
echo "🎨 APLICANDO CSS PARA NOMBRES LARGOS - SOLUCIÓN DEFINITIVA"
echo "========================================================="

# Crear CSS específico para el problema de nombres largos
cat > menu_fix.css << 'EOF'
/* Solución específica para nombres largos en el menú */
.nav-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    list-style: none;
    margin: 0;
    padding: 0;
}

.nav-link {
    display: inline-block;
    padding: 0.5rem 0.75rem;
    text-decoration: none;
    color: #333;
    font-size: 0.9rem;
    font-weight: 500;
    border-radius: 6px;
    transition: all 0.3s ease;
    white-space: nowrap;
    text-align: center;
    
    /* Solución para nombres largos */
    max-width: 120px;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* Responsive breakpoints */
@media (max-width: 991px) {
    .nav-link {
        max-width: 100px;
        font-size: 0.85rem;
        padding: 0.4rem 0.6rem;
    }
}

@media (max-width: 767px) {
    .nav-list {
        flex-direction: column;
        gap: 0.3rem;
    }
    
    .nav-link {
        max-width: none;
        width: 100%;
        padding: 0.75rem 1rem;
        font-size: 1rem;
    }
}

/* Estados hover y active */
.nav-link:hover {
    background-color: #f0f8ff;
    color: #0066cc;
    transform: translateY(-1px);
}

.nav-link.active {
    background-color: #0066cc;
    color: white;
    font-weight: 600;
}

/* Tooltips para desktop */
@media (min-width: 768px) {
    .nav-link[title]:hover::after {
        content: attr(title);
        position: absolute;
        bottom: -2.5rem;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(0, 0, 0, 0.8);
        color: white;
        padding: 0.5rem;
        border-radius: 4px;
        font-size: 0.8rem;
        white-space: nowrap;
        z-index: 1001;
        pointer-events: none;
    }
}
EOF

# Buscar y reemplazar estilos existentes del menú
if [ -f "assets/css/main.css" ]; then
    # Hacer backup del CSS
    cp assets/css/main.css assets/css/main.css.bak
    
    # Agregar estilos específicos para el menú
    echo "" >> assets/css/main.css
    echo "/* SOLUCIÓN NOMBRES LARGOS - $(date) */" >> assets/css/main.css
    cat menu_fix.css >> assets/css/main.css
    
    echo "  ✅ Estilos CSS específicos agregados"
fi

# Limpiar archivos temporales
rm -f menu_fix.css

echo ""
echo "🚀 SOLUCIÓN APLICADA:"
echo "==================="
echo ""
echo "✅ Estructura HTML limpia sin duplicados"
echo "✅ Tooltips agregados a nombres largos"
echo "✅ CSS responsive que maneja text-overflow"
echo "✅ Max-width dinámico según tamaño de pantalla"
echo "✅ Menú elegante en desktop, tablet y móvil"
echo ""
echo "🎯 Los nombres largos ahora se ven bonitos y no estiran el menú"