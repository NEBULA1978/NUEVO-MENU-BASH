#!/bin/bash

# Define una variable para contar el número de opciones
count=0

# Recorre todos los archivos en la carpeta y agrega una opción para cada uno
for file in *; do
    # Verifica si el archivo es ejecutable y no es el propio script del menú
    if [[ -x "$file" && "$file" != "${0##*/}" ]]; then
        # Incrementa el contador de opciones
        ((count++))

        # Agrega una opción para el archivo con el número de opción correspondiente
        echo "  $count) $file"
        options[$count]=$file
    fi
done

# Solicita la selección del usuario
while true; do
    clear
    echo "Seleccione una opción:"
    for i in $(seq 1 $count); do
        echo "  $i) ${options[$i]}"
    done
    read -p "> " choice

    # Ejecuta el script correspondiente a la opción seleccionada
    if [[ $choice -gt 0 && $choice -le $count ]]; then
        ./${options[$choice]}
        break
    else
        echo "Opción inválida"
        read -p "Presione ENTER para continuar"
    fi
done

# Este código recorre todos los archivos en la carpeta y agrega una opción para cada uno que sea ejecutable y no sea el propio script del menú. Luego, muestra el menú y solicita la selección del usuario. Cuando el usuario selecciona una opción válida, el script correspondiente se ejecuta utilizando el nombre del archivo almacenado en el array options.

# Para utilizar este código, guarda el archivo en la carpeta donde están los archivos a ejecutar y asegúrate de que todos los archivos tengan permisos de ejecución (chmod +x *). Luego, ejecuta el script desde la terminal con el comando ./<nombre_del_archivo>.sh.