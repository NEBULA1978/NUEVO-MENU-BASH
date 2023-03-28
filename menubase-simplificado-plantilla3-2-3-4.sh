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
    "Salir:|exit 0"
)

# Iniciamos el bucle principal del menú.
while true; do
    # Limpiamos la pantalla y mostramos las opciones disponibles.
    clear
    echo "Ingrese el número de la opción deseada:"
    for i in "${!opciones[@]}"; do
        echo "$i. ${opciones[$i]%%|*}" # Imprimimos el índice de la opción y su nombre (sin el comando correspondiente).
    done
    read opcion

    # Validamos que la opción ingresada sea un número válido dentro del rango de opciones.
    if [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then
        # Limpiamos la pantalla y mostramos el comando correspondiente a la opción seleccionada.
        clear
        echo "${opciones[$opcion]#*|}"
        read -p "Presione Enter para continuar..."
        # Ejecutamos el comando correspondiente a la opción seleccionada utilizando 'eval'.
        eval "${opciones[$opcion]#*|}" >/dev/null 2>&1
        # Si el usuario selecciona la opción de salir, salimos del bucle 'while' y terminamos la ejecución del script.
        if [ "${opciones[$opcion]#*|}" = "exit 0" ]; then
            break
        fi
    else
        # Si el usuario ingresó una opción inválida, le informamos y pedimos que intente de nuevo.
        clear
        echo "Opción inválida"
        read -p "Presione Enter para continuar..."
    fi
done

# Salimos del script con código de retorno 0.
# Esto redirige la salida de error (file descriptor 2) al dispositivo /dev/null, lo que significa que cualquier mensaje de error generado por el comando exit será descartado y no se mostrará en la terminal.
exit 0 2>/dev/null



# Muestra el comando al pulsar al numero con la opcion indicada
# En este código modificado, hemos utilizado el comando "more" para mostrar la salida de los comandos "ls" en las opciones "Archivos que no contienen los caracteres 'A', 'B' o 'C': echo "ls [!ABC]" && ls [!ABC] | more" y "Archivos que acaban en un dígito: ls [0-9]. | more". De esta manera, la salida de los comandos "ls" se mostrará en la terminal para que el usuario pueda verla.