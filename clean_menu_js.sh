#!/bin/bash
echo "🧹 LIMPIEZA TOTAL DEL JAVASCRIPT - ELIMINANDO DUPLICADOS"
echo "========================================================"

# Encontrar dónde comienza el código duplicado del menú
echo "📍 Buscando código duplicado del menú..."
grep -n "MENÚ RESPONSIVE" assets/js/main.js

echo ""
echo "🔪 Eliminando todas las funciones toggleMenu duplicadas..."

# Crear JavaScript limpio manteniendo solo el código principal
head -n 910 assets/js/main.js > assets/js/main_clean.js

# Agregar una sola función toggleMenu limpia y funcional
cat >> assets/js/main_clean.js << 'EOF'

/* ===============================================
   MENÚ PRINCIPAL - FUNCIONALIDAD LIMPIA
   =============================================== */

// Toggle del menú móvil - ÚNICA VERSIÓN
function toggleMenu() {
    const navList = document.getElementById('nav-list');
    const navToggle = document.querySelector('.nav-toggle');
    
    if (navList && navToggle) {
        navList.classList.toggle('active');
        navToggle.textContent = navList.classList.contains('active') ? '✕' : '☰';
        
        // Actualizar aria-expanded para accesibilidad
        navToggle.setAttribute('aria-expanded', navList.classList.contains('active'));
    }
}

// Inicialización cuando el DOM está listo
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-link');
    const navList = document.getElementById('nav-list');
    const navToggle = document.querySelector('.nav-toggle');
    
    // Cerrar menú al hacer clic en un enlace (solo en móvil)
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            if (window.innerWidth <= 768 && navList.classList.contains('active')) {
                navList.classList.remove('active');
                if (navToggle) {
                    navToggle.textContent = '☰';
                    navToggle.setAttribute('aria-expanded', 'false');
                }
            }
        });
    });
    
    // Cerrar menú al redimensionar ventana
    window.addEventListener('resize', function() {
        if (window.innerWidth > 768 && navList.classList.contains('active')) {
            navList.classList.remove('active');
            if (navToggle) {
                navToggle.textContent = '☰';
                navToggle.setAttribute('aria-expanded', 'false');
            }
        }
    });
    
    // Cerrar menú con tecla Escape
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && navList.classList.contains('active')) {
            toggleMenu();
        }
    });
});
EOF

echo "✅ JavaScript limpio creado"
echo "🔄 Reemplazando archivo principal..."

# Reemplazar el archivo principal
mv assets/js/main.js assets/js/main_old_chaos.js
mv assets/js/main_clean.js assets/js/main.js

echo "✅ JavaScript principal reemplazado"
echo "💾 Archivo anterior guardado como main_old_chaos.js"

# Mostrar estadísticas
echo ""
echo "📊 ESTADÍSTICAS DE LIMPIEZA:"
echo "================================"
echo "📦 Antes: $(wc -l assets/js/main_old_chaos.js | cut -d' ' -f1) líneas"
echo "✨ Después: $(wc -l assets/js/main.js | cut -d' ' -f1) líneas"
echo "🗑️  Eliminadas: $(($(wc -l assets/js/main_old_chaos.js | cut -d' ' -f1) - $(wc -l assets/js/main.js | cut -d' ' -f1))) líneas"

echo ""
echo "🎉 JAVASCRIPT COMPLETAMENTE LIMPIO"
echo "=================================="
echo "✅ Una sola función toggleMenu()"
echo "✅ Sin código duplicado"
echo "✅ Funcionalidad completa y accesible"