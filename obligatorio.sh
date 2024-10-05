#!/bin/bash

# Archivos
ARCHIVO_ADMINS="admin.txt"
ARCHIVO_CLIENTES="clientes.txt"
ARCHIVO_MASCOTAS="mascotas.txt"
ARCHIVO_ADOPCIONES="adopciones.txt"

authenticate(){
	local usuario=$1
	local contrasena=$2
	local archivo=$3
	
	local retorno
	#Chequeo usuario vacio
	if [ -z "$usuario" ] || [ -z "$contrasena" ]; then
		return 1
	fi

	#Chequeo existencia usuario
	grep "$usario - $contrasena" "$archivo"
	res=$?
	echo "$res"

	if [ "$res" -eq 1 ]; then
		return 0
	else
	#Usuario existente
		return 2
	fi
}


registarAdmin(){

	local pedir=true

	while [ "$pedir" = true ]; do
		echo  "Ingrese Usuario"
		read Usuario

		echo "Ingrese Contraseña"
		read Contrasena
		
		authenticate "$Usuario" "$Contrasena" "$ARCHIVO_ADMINS"
		res=$?
		
		#Si no existe lo agrega
		if [ "$res" -eq 0 ]; then
			echo "$Usuario - $Contrasena" >> "$ARCHIVO_ADMINS"
			pedir=false
		elif [ "$res" -eq 2 ]; then
			echo "Usuario existente"
		else 
			echo "Usuario o Contraseña vacios"
		fi
	done
}


archivoVacio(){
	local archivo=$1
	if [ -s "$archivo" ]; then
		echo "Tiene contenido"
		registarAdmin 
		
	else
		echo "Vacio"

	fi
}

archivoVacio "$ARCHIVO_ADMINS" 





