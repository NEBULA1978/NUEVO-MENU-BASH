#!/bin/bash

# Define los nombres de los archivos y los números de opción correspondientes
file1="expresiones regulares mastermind"
num1="1"
file2="menubase-crear-eliminar-archivos.sh"
num2="2"
file3="menubase-simplificado-chatgpt.sh"
num3="3"
# Agrega aquí más archivos y números de opción según sea necesario

# Muestra el menú y solicita la selección del usuario
while true; do
    clear
    echo "Seleccione una opción:"
    echo "  $num1) $file1"
    echo "  $num2) $file2"
    echo "  $num3) $file3"
    # Agrega aquí más opciones según sea necesario
    read -p "> " choice

    # Ejecuta el script correspondiente a la opción seleccionada
    case $choice in
        $num1) ./"$file1"; break;;
        $num2) ./"$file2"; break;;
        $num3) ./"$file3"; break;;
        # Agrega aquí más casos según sea necesario
        *) echo "Opción inválida"; read -p "Presione ENTER para continuar";;
    esac
done
