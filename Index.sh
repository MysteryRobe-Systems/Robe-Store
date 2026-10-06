#!/bin/bash

# ==========================================
# Robe Store
# ==========================================

# Diretório onde este script está
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# ==========================================
# Repositories
# ==========================================

FreeAndOpenSource="$SCRIPT_DIR/Repositories/Flatpak/FreeAndOpenSource.sh"

# ==========================================
# Verificar arquivos
# ==========================================

if [[ ! -f "$FreeAndOpenSource" ]]; then
    echo "ERROR: FreeAndOpenSource.sh not found!"
    echo
    echo "Expected location:"
    echo "$FreeAndOpenSource"
    exit 1
fi

# ==========================================
# Mensagem inicial
# ==========================================

startMsg=$'Welcome to the Robe Store\n\n\
What do you want to use?\n\
1) Flatpak\n\
2) APT\n\
3) Docker containers (coming soon)\n\
4) Exit'

echo "$startMsg"

# ==========================================
# Main loop
# ==========================================

while true; do

    echo
    read -p "> " act

    case "$act" in

        # ==================================
        # FLATPAK
        # ==================================

        1)
        
        while true; do
            # Verificar se Flatpak está instalado
            if ! command -v flatpak &> /dev/null; then
                echo "Flatpak is not installed."
                continue
            fi

            read -p "Write the app you want to install: " appTI

            # Impedir pesquisa vazia
            if [[ -z "$appTI" ]]; then
                echo "Please write an app name."
                continue
            fi

            # Carregar lista de apps
            source "$FreeAndOpenSource"

            echo
            echo "Searching for: $appTI"
            echo

            found=0

            # Pesquisar na array
            for app in "${apps[@]}"; do

                # Pesquisa sem diferenciar maiúsculas/minúsculas
                if [[ "${app,,}" == *"${appTI,,}"* ]]; then
                    echo "Found: $app"
                    found=1
                fi

            done

            # Nenhum resultado
            if [[ "$found" -eq 0 ]]; then
                echo "No app found."
            fi
            
            echo "Did you want make another instalation"
done
            ;;

        # ==================================
        # APT
        # ==================================

        2)
             read -p "Write the apt who you want install"appAPT
             sudo apt install $appAPT 
            
            
            ;;

        # ==================================
        # DOCKER
        # ==================================

        3)
            echo "Docker containers are not available yet."
            ;;

        # ==================================
        # EXIT
        # ==================================

        4)
            echo "Bye!"
            break
            ;;

        # ==================================
        # INVALID OPTION
        # ==================================

        *)
            echo "Invalid option."
            echo "Please choose 1, 2, 3 or 4."
            ;;

    esac

done
