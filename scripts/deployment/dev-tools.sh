#!/bin/bash
echo "🏗️  HERRAMIENTAS DE DESARROLLO - MICROSITIO RUNART FOUNDRY"
echo "========================================================="

# Colores para mejor visualización
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para mostrar el estado actual completo
show_full_status() {
    echo ""
    echo -e "${BLUE}📊 ESTADO COMPLETO DEL PROYECTO${NC}"
    echo "==============================="
    
    echo -e "${CYAN}🌐 Información de ramas:${NC}"
    echo "  Rama actual: $(git branch --show-current)"
    echo "  Ramas disponibles:"
    git branch -a | sed 's/^/    /'
    
    echo ""
    echo -e "${CYAN}📝 Últimos commits:${NC}"
    git log --oneline -3 | sed 's/^/    /'
    
    echo ""
    echo -e "${CYAN}🔄 Estado de archivos:${NC}"
    if [ -n "$(git status --porcelain)" ]; then
        git status --short | sed 's/^/    /'
    else
        echo "    ✅ Todo limpio"
    fi
    
    echo ""
    echo -e "${CYAN}🌐 URLs de deployment:${NC}"
    echo "    📱 Producción:  https://runartfoundry-micrositio-ubuntu.surge.sh"
    echo "    🧪 Staging:     https://runartfoundry-micrositio-dev.surge.sh"
    
    echo ""
    echo -e "${CYAN}🔗 Verificando conectividad:${NC}"
    PROD_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://runartfoundry-micrositio-ubuntu.surge.sh)
    DEV_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://runartfoundry-micrositio-dev.surge.sh)
    
    if [ "$PROD_STATUS" = "200" ]; then
        echo -e "    📱 Producción: ${GREEN}✅ Online (HTTP $PROD_STATUS)${NC}"
    else
        echo -e "    📱 Producción: ${RED}❌ Issues (HTTP $PROD_STATUS)${NC}"
    fi
    
    if [ "$DEV_STATUS" = "200" ]; then
        echo -e "    🧪 Staging: ${GREEN}✅ Online (HTTP $DEV_STATUS)${NC}"
    else
        echo -e "    🧪 Staging: ${RED}❌ Issues (HTTP $DEV_STATUS)${NC}"
    fi
}

# Función para menú interactivo mejorado
interactive_menu() {
    while true; do
        show_full_status
        
        echo ""
        echo -e "${PURPLE}🛠️  HERRAMIENTAS DISPONIBLES:${NC}"
        echo "=============================="
        echo -e "${YELLOW}GESTIÓN DE RAMAS:${NC}"
        echo "  1) Cambiar a rama main (producción)"
        echo "  2) Cambiar a rama development"
        echo "  3) Sincronizar development con main"
        echo ""
        echo -e "${YELLOW}DEPLOYMENT:${NC}"
        echo "  4) Deploy rápido a producción"
        echo "  5) Deploy rápido a staging"
        echo "  6) Deploy completo (staging + producción)"
        echo ""
        echo -e "${YELLOW}UTILIDADES:${NC}"
        echo "  7) Crear Pull Request (GitHub)"
        echo "  8) Abrir URLs en navegador"
        echo "  9) Logs detallados"
        echo " 10) Backup de seguridad"
        echo ""
        echo " 11) Actualizar estado"
        echo " 12) Salir"
        
        echo ""
        read -p "🎯 Selecciona una opción (1-12): " option
        
        case $option in
            1) 
                echo -e "${BLUE}🔄 Cambiando a rama main...${NC}"
                ./branch_manager.sh main
                ;;
            2) 
                echo -e "${BLUE}🔄 Cambiando a rama development...${NC}"
                ./branch_manager.sh dev
                ;;
            3) 
                echo -e "${BLUE}🔄 Sincronizando ramas...${NC}"
                ./branch_manager.sh sync
                ;;
            4) 
                echo -e "${GREEN}🚀 Desplegando a producción...${NC}"
                ./deploy-production.sh
                ;;
            5) 
                echo -e "${CYAN}🧪 Desplegando a staging...${NC}"
                ./deploy-staging.sh
                ;;
            6) 
                echo -e "${PURPLE}🎯 Deploy completo...${NC}"
                echo "Primero staging, luego producción"
                ./deploy-staging.sh
                if [ $? -eq 0 ]; then
                    echo ""
                    read -p "¿Continuar con deploy a producción? (y/n): " continue_prod
                    if [ "$continue_prod" = "y" ]; then
                        git checkout main
                        git merge development
                        ./deploy-production.sh
                    fi
                fi
                ;;
            7) 
                echo -e "${BLUE}📝 Información para Pull Request:${NC}"
                echo "🌐 URL: https://github.com/ppkapiro/runartfoundry-micrositio/pull/new/development"
                read -p "¿Abrir en navegador? (y/n): " open_browser
                if [ "$open_browser" = "y" ]; then
                    xdg-open "https://github.com/ppkapiro/runartfoundry-micrositio/pull/new/development" 2>/dev/null || echo "Abre manualmente la URL"
                fi
                ;;
            8) 
                echo -e "${BLUE}🌐 Abriendo URLs...${NC}"
                xdg-open "https://runartfoundry-micrositio-ubuntu.surge.sh" 2>/dev/null &
                xdg-open "https://runartfoundry-micrositio-dev.surge.sh" 2>/dev/null &
                echo "✅ URLs abiertas en navegador"
                ;;
            9) 
                echo -e "${BLUE}📋 Logs detallados:${NC}"
                echo "Últimos 10 commits:"
                git log --oneline -10
                echo ""
                echo "Diferencias con origin:"
                git fetch
                git status -v
                ;;
            10) 
                echo -e "${YELLOW}💾 Creando backup...${NC}"
                BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S)"
                git tag "$BACKUP_NAME"
                echo "✅ Backup creado: $BACKUP_NAME"
                ;;
            11) 
                echo -e "${GREEN}🔄 Actualizando estado...${NC}"
                # El estado se actualiza automáticamente al inicio del loop
                ;;
            12) 
                echo -e "${GREEN}👋 ¡Hasta luego!${NC}"
                exit 0
                ;;
            *) 
                echo -e "${RED}❌ Opción inválida${NC}"
                sleep 1
                ;;
        esac
        
        echo ""
        read -p "Presiona Enter para continuar..." -r
    done
}

# Función de ayuda
show_help() {
    echo "USO: $0 [COMANDO]"
    echo ""
    echo "COMANDOS DISPONIBLES:"
    echo "  main           - Cambiar a rama main"
    echo "  dev            - Cambiar a rama development"  
    echo "  deploy-prod    - Deploy rápido a producción"
    echo "  deploy-staging - Deploy rápido a staging"
    echo "  sync           - Sincronizar development con main"
    echo "  status         - Mostrar estado completo"
    echo "  interactive    - Menú interactivo (por defecto)"
    echo "  help           - Mostrar esta ayuda"
    echo ""
    echo "EJEMPLOS:"
    echo "  $0              # Menú interactivo"
    echo "  $0 status       # Solo mostrar estado"
    echo "  $0 deploy-staging # Deploy rápido a staging"
}

# Manejo de argumentos
case "$1" in
    "main") 
        ./branch_manager.sh main 
        ;;
    "dev") 
        ./branch_manager.sh dev 
        ;;
    "deploy-prod") 
        ./deploy-production.sh 
        ;;
    "deploy-staging") 
        ./deploy-staging.sh 
        ;;
    "sync") 
        ./branch_manager.sh sync 
        ;;
    "status") 
        show_full_status 
        ;;
    "help"|"-h"|"--help") 
        show_help 
        ;;
    "interactive"|"") 
        interactive_menu 
        ;;
    *) 
        echo -e "${RED}❌ Comando desconocido: $1${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac