#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
    "Mostrar directorio:|ls"
    "Descargar y arrancar instancia de MongoDB:|sudo docker run --rm --name mongo mongo:3.6.22-xenial"
    "Conectarse a MongoDB:|sudo docker exec -it mongo /bin/bash"
    "Acceder a MongoDB:|mongo"
    "Mostrar bases de datos:|show databases;"
    "Crear base de datos:|use crm"
    "Mostrar colecciones de una base de datos:|show collections"
    "Añadir valores a la base de datos:|db.clientes.insert( { id: 1, nombre: \"Juan\", tipo: \"A\", ventas: 150 } ); db.clientes.insert( { id: 1, nombre: \"David\", tipo: \"B\", ventas: 50 } ); db.clientes.insert( { id: 1, nombre: \"Roger\", tipo: \"B\", ventas: 250 } ); db.clientes.insert( { id: 1, nombre: \"Pepe\", tipo: \"A\", ventas: 25 } )"
    "Buscar registros en la base de datos:|db.clientes.find()"
    "Ordenar registros ascendentemente:|db.clientes.find().sort( { nombre: 1 } )"
    "Ordenar registros descendentemente:|db.clientes.find().sort( { nombre: -1 } )"
    "Mostrar registros en formato legible:|db.clientes.find().sort( { nombre: -1 } ).pretty()"
    "Buscar clientes de tipo B:|db.clientes.find( { tipo: \"B\" } ).sort( { nombre: -1 } ).pretty()"
    "Buscar ventas de 150 o más:|db.clientes.find( { ventas: { \$gte: 150 } } ).sort( { nombre: -1 } ).pretty()"
    "Agregar campo de apellidos a un nombre:|db.clientes.update( { id: 3 }, { \$set: { apellidos: \"Garcia\" } } )"
    "Eliminar usuario:|db.clientes.remove( { id: 2 } )"
    "Mostrar ventas totales de clientes de tipo A:|db.clientes.aggregate( [ { \$match: { tipo: \"A\" } }, { \$group: { _id: null, total: { \$sum: \"\$ventas\" } } } ] )"
    "Salir:|exit 0"
)

while true; do
    clear
    echo "Ingrese el número de la opción deseada:"
    for i in "${!opciones[@]}"; do
        echo "$i. ${opciones[$i]%%|*}" # Imprimimos el índice de la opción y su nombre (sin el comando correspondiente).
    done
    read opcion

    # Validamos que la opción ingresada sea un número válido dentro del rango de opciones.
    if [[ $opcion =~ ^[0-9]+$ ]] && [ $opcion -ge 0 ] && [ $opcion -lt ${#opciones[@]} ]; then
        clear
        comando="${opciones[$opcion]#*|}" # Obtenemos el comando correspondiente a la opción seleccionada.
        eval "$comando"                     # Ejecutamos el comando.
        echo ""
        echo "Presione Enter para continuar..."
        read
    else
        echo "Opción inválida. Presione Enter para continuar..."
        read
    fi

done
