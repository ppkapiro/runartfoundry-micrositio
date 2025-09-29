#!/bin/bash
echo "🌿 SISTEMA DE RAMAS - GESTIÓN DE DESARROLLO Y PRODUCCIÓN"
echo "========================================================"

# Función para mostrar el estado actual
show_status() {
    echo ""
    echo "📍 ESTADO ACTUAL:"
    echo "=================="
    echo "🌐 Rama actual: $(git branch --show-current)"
    echo "📝 Último commit: $(git log --oneline -1)"
    echo "🔄 Estado de archivos:"
    git status --short | head -5
    if [ $(git status --short | wc -l) -gt 5 ]; then
        echo "   ... y $(($(git status --short | wc -l) - 5)) archivos más"
    fi
}

# Función para cambiar a rama main (producción)
switch_to_main() {
    echo ""
    echo "🔄 CAMBIANDO A RAMA MAIN (PRODUCCIÓN)"
    echo "===================================="
    
    # Verificar si hay cambios sin commitear
    if [ -n "$(git status --porcelain)" ]; then
        echo "⚠️  Hay cambios sin commitear. ¿Qué deseas hacer?"
        echo "1) Commitear y cambiar"
        echo "2) Descartar cambios y cambiar"
        echo "3) Cancelar"
        read -p "Selecciona (1-3): " choice
        
        case $choice in
            1)
                echo "💾 Commiteando cambios..."
                git add .
                read -p "Mensaje del commit: " commit_msg
                git commit -m "$commit_msg"
                ;;
            2)
                echo "🗑️  Descartando cambios..."
                git reset --hard
                git clean -fd
                ;;
            3)
                echo "❌ Operación cancelada"
                return 1
                ;;
        esac
    fi
    
    git checkout main
    git pull origin main
    echo "✅ Cambiado a rama main"
}

# Función para cambiar a rama development
switch_to_dev() {
    echo ""
    echo "🔄 CAMBIANDO A RAMA DEVELOPMENT"
    echo "==============================="
    
    # Verificar si hay cambios sin commitear
    if [ -n "$(git status --porcelain)" ]; then
        echo "⚠️  Hay cambios sin commitear. ¿Qué deseas hacer?"
        echo "1) Commitear y cambiar"
        echo "2) Descartar cambios y cambiar"
        echo "3) Cancelar"
        read -p "Selecciona (1-3): " choice
        
        case $choice in
            1)
                echo "💾 Commiteando cambios..."
                git add .
                read -p "Mensaje del commit: " commit_msg
                git commit -m "$commit_msg"
                ;;
            2)
                echo "🗑️  Descartando cambios..."
                git reset --hard
                git clean -fd
                ;;
            3)
                echo "❌ Operación cancelada"
                return 1
                ;;
        esac
    fi
    
    git checkout development
    git pull origin development
    echo "✅ Cambiado a rama development"
}

# Función para deploy a producción
deploy_production() {
    echo ""
    echo "🚀 DEPLOY A PRODUCCIÓN"
    echo "====================="
    
    if [ "$(git branch --show-current)" != "main" ]; then
        echo "❌ Debes estar en la rama main para deploy a producción"
        echo "   Usa: ./branch_manager.sh main"
        return 1
    fi
    
    echo "📋 Verificando estado del repositorio..."
    if [ -n "$(git status --porcelain)" ]; then
        echo "❌ Hay cambios sin commitear. Commitea primero."
        return 1
    fi
    
    echo "📤 Subiendo a GitHub..."
    git push origin main
    
    echo "🌐 Desplegando a producción (Surge)..."
    surge . runartfoundry-micrositio-ubuntu.surge.sh
    
    echo "✅ Deploy a producción completado"
    echo "🌐 URL: https://runartfoundry-micrositio-ubuntu.surge.sh"
}

# Función para deploy a desarrollo
deploy_development() {
    echo ""
    echo "🧪 DEPLOY A DESARROLLO/STAGING"
    echo "=============================="
    
    if [ "$(git branch --show-current)" != "development" ]; then
        echo "❌ Debes estar en la rama development para deploy a staging"
        echo "   Usa: ./branch_manager.sh dev"
        return 1
    fi
    
    echo "📋 Verificando estado del repositorio..."
    if [ -n "$(git status --porcelain)" ]; then
        echo "⚠️  Hay cambios sin commitear. ¿Commitear automáticamente?"
        read -p "Mensaje del commit: " commit_msg
        if [ -n "$commit_msg" ]; then
            git add .
            git commit -m "$commit_msg"
        else
            echo "❌ Se necesita un mensaje de commit"
            return 1
        fi
    fi
    
    echo "📤 Subiendo a GitHub..."
    git push origin development
    
    echo "🌐 Desplegando a staging (Surge)..."
    surge . runartfoundry-micrositio-dev.surge.sh
    
    echo "✅ Deploy a desarrollo completado"
    echo "🧪 URL de testing: https://runartfoundry-micrositio-dev.surge.sh"
}

# Función para sincronizar development con main
sync_dev_with_main() {
    echo ""
    echo "🔄 SINCRONIZANDO DEVELOPMENT CON MAIN"
    echo "====================================="
    
    # Cambiar a main y actualizar
    git checkout main
    git pull origin main
    
    # Cambiar a development y mergear
    git checkout development
    git merge main
    
    echo "✅ Development sincronizado con main"
    echo "📤 ¿Subir cambios? (y/n)"
    read -p "> " sync_push
    if [ "$sync_push" = "y" ]; then
        git push origin development
        echo "✅ Cambios subidos a GitHub"
    fi
}

# Función para crear pull request (manual)
create_pr() {
    echo ""
    echo "📝 CREAR PULL REQUEST"
    echo "===================="
    echo "Para crear un PR de development → main:"
    echo "🌐 Visita: https://github.com/ppkapiro/runartfoundry-micrositio/pull/new/development"
    echo "📋 O usa GitHub CLI si está instalado: gh pr create"
}

# Función principal
main() {
    show_status
    
    echo ""
    echo "🛠️  OPCIONES DISPONIBLES:"
    echo "========================"
    echo "1) Cambiar a rama main (producción)"
    echo "2) Cambiar a rama development"
    echo "3) Deploy a producción"
    echo "4) Deploy a desarrollo/staging"
    echo "5) Sincronizar development con main"
    echo "6) Crear Pull Request"
    echo "7) Solo mostrar estado actual"
    echo "8) Salir"
    
    read -p "Selecciona una opción (1-8): " option
    
    case $option in
        1) switch_to_main ;;
        2) switch_to_dev ;;
        3) deploy_production ;;
        4) deploy_development ;;
        5) sync_dev_with_main ;;
        6) create_pr ;;
        7) echo "✅ Estado mostrado arriba" ;;
        8) echo "👋 ¡Hasta luego!" ;;
        *) echo "❌ Opción inválida" ;;
    esac
}

# Manejo de argumentos de línea de comandos
case "$1" in
    "main") switch_to_main ;;
    "dev") switch_to_dev ;;
    "deploy-prod") deploy_production ;;
    "deploy-dev") deploy_development ;;
    "sync") sync_dev_with_main ;;
    "pr") create_pr ;;
    "status") show_status ;;
    "") main ;;
    *) 
        echo "❌ Argumento inválido: $1"
        echo "Argumentos válidos: main, dev, deploy-prod, deploy-dev, sync, pr, status"
        echo "O ejecuta sin argumentos para menú interactivo"
        ;;
esac