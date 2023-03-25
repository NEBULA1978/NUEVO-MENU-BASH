#!/bin/bash

#!/bin/bash

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
    "Ejecutar script menubase-simplificado.sh:| ./menubase-simplificado.sh"
    "Salir:|exit 0"
)

# -eq es un operador de comparación en Bash que significa "igual a". Aquí están los otros operadores de comparación con sus traducciones en inglés y español:

#     -ne: not equal to (no igual a)
#     -lt: less than (menor que)
#     -le: less than or equal to (menor o igual que)
#     -gt: greater than (mayor que)
#     -ge: greater than or equal to (mayor o igual que)


while true; do
    clear
    echo "Ingrese el número de la opción deseada:"
    for i in ${!opciones[@]}; do
        echo "$i. ${opciones[$i]%%|*}"
    done
    read opcion

    if [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then
        clear
        comando="${opciones[$opcion]#*|}"
        echo "El comando es: $comando"
        read -p "¿Desea ejecutar este comando en una nueva consola? (s/n): " respuesta
        if [ "$respuesta" = "s" ]; then
            if [ "$(which xterm)" != "" ]; then
                xterm -e "$comando"
            elif [ "$(which gnome-terminal)" != "" ]; then
                gnome-terminal -- bash -c "$comando; exec bash"
            else
                echo "No se encontró un terminal compatible"
                read -p "Presione Enter para continuar..."
            fi
        else
            if [ "$comando" = "exit 0" ]; then
                exec "$comando"
            else
                eval "$comando" -r
                read -p "Presione Enter para continuar..."
            fi
        fi
    else
        clear
        echo "Opción inválida"
        read -p "Presione Enter para continuar..."
    fi
done

# Tienes razón, hay un problema en la línea 29 del código actualizado que puede causar que la función "eval" falle al tratar de ejecutar el comando "exit 0" después de salir del ciclo while. Esto se debe a que "eval" interpreta el comando "exit 0" como dos argumentos separados.

# Para solucionar este problema, podemos usar el comando "exec" en lugar de "eval" para ejecutar el comando en la terminal actual.

# /////////////////////////////////////////////
# /////////////////////////////////////////////

# ERROR:
# El comando es: exit 0
# ¿Desea ejecutar este comando en una nueva consola? (s/n): n
# ./menubase-simplificado-plantilla3-2-3-4-consola.sh: línea 41: exit: demasiados argumentos

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
#     "Salir:|exit 0"
# )

# while true; do
#     clear
#     echo "Ingrese el número de la opción deseada:"
#     for i in ${!opciones[@]}; do
#         echo "$i. ${opciones[$i]%%|*}"
#     done
#     read opcion

#     if [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then
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
#         else
#             eval "$comando" -r
#             read -p "Presione Enter para continuar..."
#         fi
#     else
#         clear
#         echo "Opción inválida"
#         read -p "Presione Enter para continuar..."
#     fi
# done

# En este código modificado, hemos agregado un mensaje que muestra el comando que se va a ejecutar, seguido de una pregunta al usuario para ejecutar el comando en una nueva consola. Si el usuario responde "s", el script verifica si "xterm" o "gnome-terminal" están instalados y ejecuta el comando en una nueva ventana de terminal usando una de estas herramientas. Si el usuario responde "n", el script ejecuta el comando en la terminal actual.