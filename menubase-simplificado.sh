#!/bin/bash

# Definimos un array que contiene las opciones del menú
opciones=(
    "Mostrar directorio:|./menubase3.sh"
    "Mostrar calendario:|cal"
    "Mostrar fecha de hoy:|date"
    "Archivos con un solo carácter:|ls ?"
    "Archivos que empiezan con 'a' seguidos de un carácter:|ls a?"
    "Archivos que contienen uno de los caracteres 'A', 'B' o 'C':|ls *[ABC]*"
    "Archivos que no contienen los caracteres 'A', 'B' o 'C':|echo \"ls *[!ABC]*\" && ls *[!ABC]* | more"
    "Archivos que acaban en un dígito:|ls *[0-9].* | more"
    "Archivos que acaban en dos dígitos:|ls *[0-9][0-9].*"
    "Archivos que acaban en una mayúscula:|ls *[A-Z].*"
    "Archivos que acaban en una minúscula o mayúscula:|ls *[a-zA-Z].*"
    "Salir:|exit 0"
)

# -eq es un operador de comparación en Bash que significa "igual a". Aquí están los otros operadores de comparación con sus traducciones en inglés y español:

#     -ne: not equal to (no igual a)
#     -lt: less than (menor que)
#     -le: less than or equal to (menor o igual que)
#     -gt: greater than (mayor que)
#     -ge: greater than or equal to (mayor o igual que)


# Iniciamos un bucle infinito para mostrar el menú hasta que se elija la opción de salida
while true; do
    clear
    echo "Ingrese el número de la opción deseada:"
    for i in ${!opciones[@]}; do
        echo "$i. ${opciones[$i]%%|*}" # Mostramos el número de la opción y el nombre de la opción
    done
    read opcion

    if [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then # Verificamos que la opción ingresada sea válida
        clear
        comando="${opciones[$opcion]#*|}" # Extraemos el comando de la opción elegida
        echo "El comando es: $comando"
        read -p "¿Desea ejecutar este comando en una nueva consola? (s/n): " respuesta
        if [ "$respuesta" = "s" ]; then               # Si se desea ejecutar el comando en una nueva consola
            if [ "$(which xterm)" != "" ]; then       # Si el terminal xterm está instalado
                if [[ "$comando" == "exit 0" ]]; then # Verificamos si el comando es 'exit 0', que no se puede ejecutar en una nueva consola
                    echo "No se puede ejecutar el comando 'exit 0' en una nueva terminal"
                else
                    xterm -e "$comando" # Ejecutamos el comando en una nueva ventana de terminal xterm
                    sleep 3             # Esperamos 3 segundos antes de cerrar la ventana de terminal
                fi
            elif [ "$(which gnome-terminal)" != "" ]; then # Si el terminal gnome-terminal está instalado
                if [[ "$comando" == "exit 0" ]]; then      # Verificamos si el comando es 'exit 0', que no se puede ejecutar en una nueva consola
                    exit                                   # Ejecutamos 'exit' sin argumentos para salir del script
                else
                    gnome-terminal -- bash -c "$comando; sleep 3" & # Ejecutamos el comando en una nueva ventana de terminal
                fi
            else
                echo "No se encontró un terminal compatible"
                read -p "Presione Enter para continuar..."
            fi
        else                                      # Si no se desea ejecutar el comando en una nueva consola
            if [[ "$comando" == "exit 0" ]]; then # Verificamos si el comando es 'exit 0', para salir del script
                exit
            else
                eval "$comando" -r # Ejecutamos el comando en la misma terminal
                read -p "Presione Enter para continuar..."
            fi
        fi
    else
        clear
        echo "Opción inválida"
        read -p "Presione Enter para continuar..."
    fi
done

# El código es un script de Bash que implementa un menú interactivo que permite al usuario elegir entre varias opciones y ejecutar comandos. Las opciones del menú están almacenadas en un array que contiene una serie de strings con el siguiente formato: "nombre de la opción|comando a ejecutar".

# Cuando el usuario elige una opción del menú, el script extrae el comando correspondiente y le pregunta al usuario si desea ejecutar el comando en una nueva ventana de terminal. Si el usuario responde "s", el script verifica si el terminal xterm o gnome-terminal está instalado en el sistema y ejecuta el comando en una nueva ventana de terminal correspondiente. Si el usuario responde "n", el script ejecuta el comando en la misma terminal.

# Además, se han añadido expresiones regulares para filtrar archivos en las opciones del menú, y se ha incluido la opción de cerrar la ventana de terminal después de un cierto número de segundos si se ha ejecutado en una nueva ventana. También se muestran mensajes de error si se intenta ejecutar ciertos comandos en una nueva ventana de terminal que no son compatibles.

# El código está bien comentado para facilitar su comprensión y se ha añadido un bucle infinito para que el menú se siga mostrando hasta que el usuario elige la opción de salida.