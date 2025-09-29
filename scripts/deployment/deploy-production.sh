#!/bin/bash
echo "🚀 DEPLOY RÁPIDO A PRODUCCIÓN"
echo "============================"

# Verificar que estamos en la rama correcta
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "❌ Error: Debes estar en la rama 'main' para deploy a producción"
    echo "   Rama actual: $CURRENT_BRANCH"
    echo "   Usa: git checkout main"
    exit 1
fi

# Verificar que no hay cambios sin commitear
if [ -n "$(git status --porcelain)" ]; then
    echo "❌ Error: Hay cambios sin commitear"
    echo "   Commitea primero con: git add . && git commit -m 'tu mensaje'"
    exit 1
fi

# Verificar que estamos sincronizados con origin
git fetch origin main
BEHIND=$(git rev-list --count HEAD..origin/main)
if [ "$BEHIND" -gt 0 ]; then
    echo "❌ Error: La rama local está desactualizada"
    echo "   Actualiza con: git pull origin main"
    exit 1
fi

echo "✅ Verificaciones pasadas"
echo ""

# Push a GitHub
echo "📤 Subiendo a GitHub..."
git push origin main
if [ $? -ne 0 ]; then
    echo "❌ Error al subir a GitHub"
    exit 1
fi

# Deploy a Surge
echo "🌐 Desplegando a producción..."
surge . runartfoundry-micrositio-ubuntu.surge.sh
if [ $? -ne 0 ]; then
    echo "❌ Error en deploy a Surge"
    exit 1
fi

echo ""
echo "🎉 ¡DEPLOY A PRODUCCIÓN EXITOSO!"
echo "================================"
echo "🌐 URL: https://runartfoundry-micrositio-ubuntu.surge.sh"
echo "📝 Commit: $(git log --oneline -1)"
echo "⏰ Tiempo: $(date)"

# Verificar que el sitio responde
echo ""
echo "🔍 Verificando disponibilidad del sitio..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://runartfoundry-micrositio-ubuntu.surge.sh)
if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ Sitio accesible (HTTP $HTTP_STATUS)"
else
    echo "⚠️  Advertencia: Sitio retorna HTTP $HTTP_STATUS"
fi