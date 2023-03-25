#!/bin/bash

#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
    "Mostrar directorio:|ls"
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
    "Ejecutar script menubase-simplificado.sh:|./menubase-simplificado.sh"
    "Salir:|exit 0"
)

while true; do
    clear
    echo "Ingrese el número de la opción deseada:"
    for i in ${!opciones[@]}; do
        echo "$i. ${opciones[$i]%%|*}" # Imprimimos el índice de la opción y su nombre (sin el comando correspondiente).
    done
    read opcion

    # Validamos que la opción ingresada sea un número válido dentro del rango de opciones.
    if [[ $opcion =~ ^[0-9]+$ ]] && [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then
        clear
        comando="${opciones[$opcion]#*|}" # Obtenemos el comando correspondiente a la opción seleccionada.
        echo "El comando es: $comando"
        read -p "¿Desea ejecutar este comando en una nueva consola? (s/n): " respuesta

        # Si el usuario desea ejecutar el comando en una nueva consola, lo abrimos usando 'xterm' o 'gnome-terminal'.
        if [ "$respuesta" = "s" ]; then
            if [ "$(which xterm)" != "" ]; then
                xterm -e "$comando"
            elif [ "$(which gnome-terminal)" != "" ]; then
                gnome-terminal -- bash -c "$comando; exec bash"
            else
                echo "No se encontró un terminal compatible"
                read -p "Presione Enter para continuar..."
            fi
        # Si el usuario desea ejecutar el comando en la consola actual, lo ejecutamos usando 'eval'.
        elif [ "$respuesta" = "n" ]; then
            if [ "$comando" = "exit 0" ]; then
                break # Si el usuario selecciona la opción de salir, salimos del bucle 'while' y terminamos la ejecución del script.
            else
                eval "$comando" -r
                read read -p "Presione Enter para continuar..."
            fi
        # Si el usuario no ingresó 's' o 'n', le informamos que su respuesta es inválida y pedimos que intente de nuevo.
        else
            echo "Respuesta inválida. Por favor, introduzca 's' o 'n'."
            read -p "Presione Enter para continuar..."
        fi
    # Si el usuario ingresó una opción inválida, le informamos y pedimos que intente de nuevo.
    else
        echo "Opción inválida. Por favor, introduzca un número válido."
        read -p "Presione Enter para continuar..."
    fi
done

# Código sin comentarios

# opciones=(
#     "Mostrar directorio:|ls"
#     "Mostrar calendario:|cal"
#     "Mostrar fecha de hoy:|date"
#     "Archivos con un solo carácter:|ls ?"
#     "Archivos que empiezan con 'a' seguidos de un carácter:|ls a?"
#     "Archivos que contienen uno de los caracteres 'A', 'B' o 'C':|ls *[ABC]*"
#     "Archivos que no contienen los caracteres 'A', 'B' o 'C':|echo \"ls *[!ABC]*\" && ls *[!ABC]* | more"
#     "Archivos que acaban en un dígito:|ls *[0-9].* | more"
#     "Archivos que acaban en dos dígitos:|ls *[0-9][0-9].*"
#     "Archivos que acaban en una mayúscula:|ls *[A-Z].*"
#     "Archivos que acaban en una minúscula o mayúscula:|ls *[a-zA-Z].*"
#     "Ejecutar script menubase-simplificado.sh:|./menubase-simplificado.sh"
#     "Salir:|exit 0"
# )

# while true; do
#     clear
#     echo "Ingrese el número de la opción deseada:"
#     for i in ${!opciones[@]}; do
#         echo "$i. ${opciones[$i]%%|*}"
#     done
#     read opcion

#     if [[ $opcion =~ ^[0-9]+$ ]] && [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then
#         clear
#         comando="${opciones[$opcion]#*|}"
#         echo "El comando es: $comando"
#         read -p "¿Desea ejecutar este comando en una nueva consola? (s/n): " respuesta
#         if [ "$respuesta" = "s" ]; then
#             if [ "$(which xterm)" != "" ]; then
#                 xterm -e "$comando"
#             elif [ "$(which gnome-terminal)" != "" ]; then
#                 gnome-terminal -- bash -c "$comando; exec bash"
#             else
#                 echo "No se encontró un terminal compatible"
#                 read -p "Presione Enter para continuar..."
#             fi
#         elif [ "$respuesta" = "n" ]; then
#             if [ "$comando" = "exit 0" ]; then
#                 break
#             else
#                 eval "$comando" -r
#                 read -p "Presione Enter para continuar..."
#             fi
#         else
#             echo "Respuesta inválida. Por favor, introduzca 's' o 'n'."
#             read -p "Presione Enter para continuar..."
#         fi
#     else
#         echo "Opción inválida. Por favor, introduzca un número válido."
#         read -p "Presione Enter para continuar..."
#     fi
# done
