#!/bin/bash
echo "🧪 DEPLOY RÁPIDO A DESARROLLO/STAGING"
echo "===================================="

# Verificar que estamos en la rama correcta
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "development" ]; then
    echo "❌ Error: Debes estar en la rama 'development' para deploy a staging"
    echo "   Rama actual: $CURRENT_BRANCH"
    echo "   Usa: git checkout development"
    exit 1
fi

# Manejar cambios sin commitear
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Hay cambios sin commitear"
    echo "📝 Archivos modificados:"
    git status --short
    echo ""
    read -p "💾 Mensaje para commit automático: " COMMIT_MSG
    
    if [ -z "$COMMIT_MSG" ]; then
        echo "❌ Se requiere un mensaje de commit"
        exit 1
    fi
    
    git add .
    git commit -m "$COMMIT_MSG"
    echo "✅ Cambios commiteados"
fi

echo "✅ Verificaciones pasadas"
echo ""

# Push a GitHub
echo "📤 Subiendo a GitHub..."
git push origin development
if [ $? -ne 0 ]; then
    echo "❌ Error al subir a GitHub"
    exit 1
fi

# Deploy a Surge
echo "🌐 Desplegando a staging..."
surge . runartfoundry-micrositio-dev.surge.sh
if [ $? -ne 0 ]; then
    echo "❌ Error en deploy a Surge"
    exit 1
fi

echo ""
echo "🎉 ¡DEPLOY A STAGING EXITOSO!"
echo "============================="
echo "🧪 URL de testing: https://runartfoundry-micrositio-dev.surge.sh"
echo "📝 Commit: $(git log --oneline -1)"
echo "⏰ Tiempo: $(date)"

# Verificar que el sitio responde
echo ""
echo "🔍 Verificando disponibilidad del sitio de testing..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://runartfoundry-micrositio-dev.surge.sh)
if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ Sitio de testing accesible (HTTP $HTTP_STATUS)"
else
    echo "⚠️  Advertencia: Sitio de testing retorna HTTP $HTTP_STATUS"
fi

echo ""
echo "💡 PRÓXIMOS PASOS:"
echo "=================="
echo "1. Prueba los cambios en: https://runartfoundry-micrositio-dev.surge.sh"
echo "2. Si todo está bien, mergea a main:"
echo "   git checkout main && git merge development"
echo "3. Deploy a producción: ./deploy-production.sh"