#!/bin/bash


while true; do
    # Define una variable para contar el número de opciones
    count=0

    # Recorre todos los archivos en la carpeta y agrega una opción para cada uno
    for file in *; do
        # Verifica si el archivo es ejecutable y no es el propio script del menú
        if [[ -x "$file" && "$file" != "${0##*/}" ]]; then
            # Incrementa el contador de opciones
            ((count++))

            # Agrega una opción para el archivo con el número de opción correspondiente
            # echo "  $count) $file"
            options[$count]=$file
        fi
    done

    # Solicita la selección del usuario
    while true; do
        echo "Seleccione una opción:"
        for i in $(seq 1 $count); do
            echo "  $i) ${options[$i]}"
        done
        read -p "> " choice

        # Ejecuta el script correspondiente a la opción seleccionada
        if [[ $choice -gt 0 && $choice -le $count ]]; then
            ./${options[$choice]}
            read -p "Presione ENTER para continuar"
            break
        elif [[ $choice -eq $((count+1)) ]]; then
            break 2
        else
            echo "Opción inválida"
            read -p "Presione ENTER para continuar"
        fi
    done
done

echo "Adiós!"


# while true; do
#     # Define una variable para contar el número de opciones
#     count=0

#     # Recorre todos los archivos en la carpeta y agrega una opción para cada uno
#     for file in *; do
#         # Verifica si el archivo es ejecutable y no es el propio script del menú
#         if [[ -x "$file" && "$file" != "${0##*/}" ]]; then
#             # Incrementa el contador de opciones
#             ((count++))

#             # Agrega una opción para el archivo con el número de opción correspondiente
#             echo "  $count) $file"
#             options[$count]=$file
#         fi
#     done

#     # Solicita la selección del usuario
#     while true; do
#         echo "Seleccione una opción:"
#         for i in $(seq 1 $count); do
#             echo "  $i) ${options[$i]}"
#         done
#         read -p "> " choice

#         # Ejecuta el script correspondiente a la opción seleccionada
#         if [[ $choice -gt 0 && $choice -le $count ]]; then
#             ./${options[$choice]}
#             read -p "Presione ENTER para continuar"
#             break
#         elif [[ $choice -eq $((count + 1)) ]]; then
#             break 2
#         else
#             echo "Opción inválida"
#             read -p "Presione ENTER para continuar"
#         fi
#     done
# done

# echo "Adiós!"

# En este nuevo script, se agregó un bucle externo while true que se ejecutará hasta que el usuario elija salir del menú. Después de cada ejecución del programa seleccionado, se muestra un mensaje "Presione ENTER para continuar" y se espera a que el usuario presione Enter antes de continuar con la selección de opciones.

# Además, se agregó una nueva opción "Salir" al final del menú, que el usuario puede seleccionar para salir del menú y terminar el script. Cuando se selecciona la opción "Salir", se utiliza el comando break 2 para salir de los dos bucles y terminar el script.

# Finalmente, se agregó un mensaje "Adiós!" que se mostrará cuando el usuario salga del menú.
