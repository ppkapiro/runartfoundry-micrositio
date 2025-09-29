#!/bin/bash
echo "🚀 DEPLOYMENT AUTOMATIZADO - RUN ART FOUNDRY MICROSITIO"
echo "======================================================="

# Verificar estado de git
echo "📋 Verificando estado del repositorio..."
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Hay cambios sin commitear. Abortando deployment."
    echo "   Usa 'git status' para ver los cambios pendientes."
    exit 1
fi

echo "✅ Repositorio limpio, procediendo con deployment..."

# Push a GitHub
echo ""
echo "📤 Subiendo a GitHub..."
git push origin main
if [ $? -eq 0 ]; then
    echo "✅ GitHub actualizado exitosamente"
else
    echo "❌ Error al subir a GitHub"
    exit 1
fi

# Deploy a Surge
echo ""
echo "🌐 Desplegando a Surge.sh..."
surge . runartfoundry-micrositio-ubuntu.surge.sh
if [ $? -eq 0 ]; then
    echo "✅ Surge deployment exitoso"
else
    echo "❌ Error en deployment a Surge"
    exit 1
fi

echo ""
echo "🎉 DEPLOYMENT COMPLETADO"
echo "======================="
echo "🌐 Sitio en vivo: https://runartfoundry-micrositio-ubuntu.surge.sh"
echo "📚 GitHub: https://github.com/ppkapiro/runartfoundry-micrositio"
echo ""
echo "🔍 Verifica que todo funcione correctamente en:"
echo "  • Desktop"
echo "  • Tablet" 
echo "  • Móvil"
echo "  • Diferentes navegadores"
