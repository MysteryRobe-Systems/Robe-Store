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
    read -rp "> " act

    case "$act" in

        # ==================================
        # FLATPAK
        # ==================================

        1)

            # Verificar se Flatpak está instalado
            if ! command -v flatpak &>/dev/null; then
                echo "Flatpak is not installed."
                continue
            fi

            # Carregar lista de apps
            source "$FreeAndOpenSource"

            while true; do

                echo
                read -rp "Write the app you want to install (or 'back'): " appTI

                # Voltar ao menu principal
                if [[ "${appTI,,}" == "back" ]]; then
                    break
                fi

                # Impedir pesquisa vazia
                if [[ -z "$appTI" ]]; then
                    echo "Please write an app name."
                    continue
                fi

                echo
                echo "Searching for: $appTI"
                echo

                found=0

                # Pesquisar na array
                for app in "${apps[@]}"; do

                    # Pesquisa sem diferenciar maiúsculas/minúsculas
                    if [[ "${app,,}" == *"${appTI,,}"* ]]; then

                        echo "Found: $app"

                        read -rp "Do you want to install it? (y/n): " act1

                        case "${act1,,}" in

                            y|yes)
                                flatpak install flathub "$app"
                                ;;

                            n|no)
                                echo "Installation cancelled."
                                ;;

                            *)
                                echo "Invalid option. Use y or n."
                                ;;

                        esac

                        found=1
                    fi

                done

                # Nenhum resultado
                if [[ "$found" -eq 0 ]]; then
                    echo "No app found."
                fi

            done

            ;;

        # ==================================
        # APT
        # ==================================

        2)

            read -rp "Write the APT package you want to install: " appAPT

            if [[ -z "$appAPT" ]]; then
                echo "Please write a package name."
                continue
            fi

            sudo apt install "$appAPT"

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
