#!/bin/bash


disminuirCantMascotas(){
	cantidadMascotas=$(head -n 1 "cantMascotas.txt")
	echo "La cantidad de mascotas actual es: $cantidadMascotas"
	((cantidadMascotas--))
	echo "Esta es la cantidad de mascotas si adopto : $cantidadMascotas"
	echo "$cantidadMascotas" >> tempCant.txt 
	mv tempCant.txt cantMascotas.txt
}

adoptarMascota(){
	#FLAG
	adopto=false
	
	while [ "$adopto" = false ];do
		#Mostramos las mascotas disponibles
		while read -r linea; do
			echo $linea
		done < "$ARCHIVO_MASCOTAS"

		read -p "Ingrese el número de la mascota que desea adoptar: " idMascota
	
		# <<< guarda la salida del grep en la variable mascota
		read -r mascota <<< "$(grep "^$idMascota -" "$ARCHIVO_MASCOTAS")"
		echo "La mascota que eligió es : $mascota"

	
		if [ -z "$mascota" ];then
			echo "El ID no existe"
		else
			echo "$mascota" >> "adopciones.txt"
			#Elimino la mascota de  ARCHIVO_MASCOTAS
			# -v invierte el patron del grep. Usamos un archivo temporal para seguir con el mismo mascotas.txt
			grep -v "^$idMascota -" "$ARCHIVO_MASCOTAS" > temp.txt && mv temp.txt "$ARCHIVO_MASCOTAS"
			if grep "^$idMascota -" temp.txt > /dev/null; then
                		echo "Error: La mascota no se eliminó correctamente."
            		else
                		# Mover el archivo temporal a ARCHIVO_MASCOTAS si todo está bien
                		mv temp.txt "$ARCHIVO_MASCOTAS"
                		echo "La mascota ha sido adoptada y eliminada de la lista."
				disminuirCantMascotas
				menuCliente
                		adopto=true
            		fi
		fi
	done
	
}

registrarAnimal(){

	echo " "
	echo "REGISTRO DE ANIMALES"
	echo " "
	
	#FLAGS
	pedirNro=true #ID
	pedirNom=true
	pedirTipo=true
	pedirSexo=true
	pedirEdad=true
	pedirDescripcion=true
	pedirFecha=true
	
	#VARIABLES
	local idDato
	local tipoDato
	local nombreDato
	local sexoDato
	local edadDato
	local descDato
	local fechaDato
	

   
	#Ingreso ID mascota
	cantidad=$(head -n 1 "cantMascotas.txt")
	idDato=$(( cantidad + 1))

	echo "$idDato"

	#Limpiamos el archivo y actualizamos el valor
	> "cantMascotas.txt"
	echo $idDato >> "cantMascotas.txt"

	#Ingreso Nombre mascota
	while [ "$pedirNom" = true ]; do
		echo "Ingrese nombre del animal"
		read nom

		if [ -z "$nom" ]; then
			echo "El nombre no puede ser vacio"
		else
			nombreDato="$nom"
			pedirNom=false
		fi 
	done

	#Ingreso Tipo mascota
	while [ "$pedirTipo" = true ]; do
		read -p "Ingrese tipo de la mascota" tipo
		
		if [ -z "$tipo" ]; then
			echo "El tipo no puede estar vació"
		elif [[ $tipo =~ ^[a-zA-Z]+$ ]]; then #El tipo tiene que ser un String
			echo "Tipo Valido"
			tipoDato="$tipo"
			pedirTipo=false
		else
			echo "Tipo invalido, debe solo contener letras"
		fi
	done
	
	#Ingreso Sexo mascota
	while [ "$pedirSexo" = true ]; do
		read -p "Ingrese sexo de la mascota" sexo
		
		if [ -z "$sexo" ]; then
			echo "El sexo no puede ser vacío"
		elif [ "$sexo" == "Macho" ] || [ "$sexo" == "Hembra" ]; then #El tipo tiene que ser un String. Poner regexs
			echo "Sexo Valido"
			sexoDato="$sexo"
			pedirSexo=false
		else
			echo "Sexo invalido, debe ser  'Macho' o 'Hembra'"
		fi
	done
	
	#Ingreso Edad mascota
	while [ "$pedirEdad" = true ]; do
		read -p "Ingrese edad de la mascota" edad
		
		if [ -z "$edad" ]; then
			echo "La edad no puede ser vacía"
		elif [ $edad -gt 1 ] && [ $edad -le 30 ] && [[ $edad =~ ^[0-9]+$ ]]; then
			echo "Edad Válida"
			edadDato="$edad"
			pedirEdad=false
		else
			echo "Edad Inválida"
		fi
	done
	
	#Ingreso Descripcion mascota
	while [ "$pedirDescripcion" = true ]; do
		read -p "Ingrese descripcion de la mascota" descripcion
		

		if [ -z "$descripcion" ]; then
			echo "Descripción no puede ser vacía"
		elif [[ $tipo =~ ^[a-zA-Z]+$ ]]; then
			descDato="$descripcion"
			pedirDescripcion=false
		else
			echo "Descripcion solo puede contener letras"
		fi
	done

	#Ingreso Fecha 
	while [ "$pedirFecha" = true ]; do
		read -p "Ingrese fecha de hoy (dd/mm/yyyy)" fecha


		if [ -z "$fecha" ]; then
			echo "Debe ingresar una fecha"
		elif  [[ $fecha =~ ^([0-2][0-9]|(3[0-1]))/(0[1-9]|1[0-2])/[0-9]{4}$ ]]; then
			echo "Fecha Valida"
			fechaDato="$fecha"
			pedirFecha=false
		else
			echo "Ingrese fecha valida"
		fi
	done
	
	echo "$idDato - $nombreDato - $tipoDato - $sexoDato - $descDato - $fechaDato" >>  "$ARCHIVO_MASCOTAS"

	menuAdmin
}


registrarCliente(){

	local pedirCedula=true
	local pedirNombre=true
	local pedirTelefono=true
	local pedirNac=true
	local pedirContra=true

	local nombre
	local cedula
	local telefono
	local nacimiento
	local contra

	while [ "$pedirCedula" = true ]; do
		echo "Ingrese Cedula del usuario:"
		read cedulaIngresada

		grep -q "$cedulaIngresada" "$ARCHIVO_CLIENTES"
		res=$?
		if [ -z "$cedulaIngresada" ]; then
			echo "Ingrese cedula valida, no puede estar vacía"
		elif ! [[ "$cedulaIngresada" =~ ^[0-9]{8}$ ]]; then
			echo "Error, formato incorrecto"
		elif [ "$res" -eq 0 ]; then
			echo "Usuario ya registrado!"
		else
			cedula="$cedulaIngresada"
			pedirCedula=false
		fi
	done

	while [ "$pedirNombre" = true ]; do
		echo "Ingrese Nombre del usuario:"
		read nombreIngresado

		grep -q "^$nombreIngresado -" "$ARCHIVO_ADMINS"
		res=$?
	
		if [ -z "$nombreIngresado" ]; then
			echo "Ingrese nombre valido!"
		elif ! [[ "$nombreIngresado" =~ ^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$ ]]; then
			echo "Error, solo puede contener letras"
		elif [ "$res" -eq 0 ]; then
			echo "Usuario es ADMIN "
		else
			nombre="$nombreIngresado"
			pedirNombre=false
		fi
	done


	while [ "$pedirTelefono" = true ]; do
		echo "Ingrese Telefono del usuario:"
		read telIngresado

		if [ -z "$telIngresado" ]; then
			echo "Ingrese telefono valido!"
		elif ! [[ "$telIngresado" =~ ^[0-9]{9}$ ]]; then
			echo "Error, formato incorrecto"
		else
			telefono="$telIngresado"
			pedirTelefono=false
		fi
	done

	while [ "$pedirNac" = true ]; do
		echo "Ingrese Fecha de Nacimiento del usuario:"
		read fechaIngresada

		if [ -z "$fechaIngresada" ]; then
			echo "Ingrese fecha valida!"
		elif ! [[ "$fechaIngresada" =~ ^([0-2][0-9]|(3[0-1]))/(0[1-9]|1[0-2])/[0-9]{4}$ ]]; then
			echo "Formato de la fecha incorrecto, debe ser dd/mm/YYYY"
		else
			nacimiento="$fechaIngresada"
			pedirNac=false
		fi
	done

	while [ "$pedirContra" = true ]; do
		echo "Ingrese Contrasena del usuario:"
		read contraIngresada

		if [ -z "$contraIngresada" ]; then
			echo "Ingrese contrasena valida!"
		else
			contra="$contraIngresada"
			pedirContra=false
		fi
	done

	echo "$cedula - $nombre - $contra - $telefono - $nacimiento" >> "$ARCHIVO_CLIENTES"

	menuAdmin

}




authenticate(){
	local usuario=$1
	local contrasena=$2
	local archivo=$3

	local retorno
	#Chequeo usuario vacio
	if [ -z "$usuario" ] || [ -z "$contrasena" ]; then
		return 1
	fi
	#Chequeo existencia de usuario
	grep "$usuario - $contrasena" "$archivo"
	res=$?
	echo "$res"

	if [ "$res" -eq 1 ]; then	#grep devuelve 1 si no encuentra
		return 0
	else
	#Usuario existente
		return 2
	fi
}

registrarAdmin(){
	local pedir=true

	while [ "$pedir" = true ]; do
		echo "Ingrese Usuario:"
		read Usuario
		echo "Ingrese Contrasena"
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
			echo "Usuario o contrasena vacios"
		fi
	done
}


primerAdmin(){
	local pedirUsuario=true
	local pedirContrasena=true

	local usuario
	local contrasena

	echo "Bienvenido! Registre el primer administrador por favor:"

	while [ "$pedirUsuario" = true ]; do
		echo "Ingrese Usuario Admin:"
		read Usuario

		if [ "$Usuario" = "admin" ]; then
			pedirUsuario=false
			usuario="admin"
		else 
			echo "El primer administrador debe llamarse admin"
		fi
	done
	while [ "$pedirContrasena" = true ]; do 
		echo "Ingrese Contrasena Admin:"
		read Contrasena

		if [ "$Contrasena" = "admin" ]; then
			pedirContrasena=false
			contrasena="admin"
		else
			echo "La contrasena del primer administrador debe ser admin!"
		fi
	done

	if [ "$usuario" = "admin" ] && [ "$contrasena" = "admin" ]; then
		echo "Admin registrado correctamente!"
		echo "$usuario - $contrasena" >> "$ARCHIVO_ADMINS"
		echo " "
	fi
}

archivoVacio(){

	if [ -s "$ARCHIVO_ADMINS" ]; then
		echo "Tiene contenido"
	else
		echo "Vacio"
		primerAdmin
	fi
}

listarAnimales(){

	local usuario=$1

	echo " "
	echo "- - - - - - - - - - - - - - - - -"
	echo "LISTA DE MASCOTAS EN ADOPCION"
	echo "- - - - - - - - - - - - - - - - -"
	echo " "

	if [ -s "$ARCHIVO_MASCOTAS" ]; then
		cat "$ARCHIVO_MASCOTAS"
		menuCliente "$usuario"
	else
		echo "No hay mascotas disponibles para adoptar"
		menuCliente "$usuario"
	fi
	
}

menuCliente(){

	local usuario=$1

	echo " "
	echo "__________________"
	echo "BIENVENIDO $usuario!"
	echo "SELECCIONE SU OPCION"
	echo "__________________"
	echo " "
	echo "1. Regresar"
	echo "2. Ver animales disponibles"
	echo "3. Adoptar animal"

	read opcion

	if [ "$opcion" = "1" ]; then
		menuInicio
	elif [ "$opcion" = "2" ]; then
		listarAnimales "$usuario"
	elif [ "$opcion" = "3" ]; then
		adoptarMascota
	fi

}

menuAdmin(){
	local admin=$1

	echo " "
	echo "__________________"
	echo "BIENVENIDO $admin!"
	echo "__________________"
	echo " "
	echo "1. Regresar"
	echo "2. Registrar Cliente"
	echo "3. Registrar Animal"
	read opcion

	if [ "$opcion" = "1" ]; then
		menuInicio
	elif [ "$opcion" = "2" ]; then
		registrarCliente
	elif [ "$opcion" = "3" ]; then
		registrarAnimal
	fi 

}



ingresoAdmin(){
	echo "INGRESAR COMO ADMINISTRADOR"
	local pedirUsuario=true
	local pedirContra=true
	local usuario
	local contrasena

	while [ "$pedirUsuario" = true ]; do
		echo "Ingrese Usuario"
		read usuarioIngresado
		if [ "$usuarioIngresado" = "" ] || [ "$usuarioIngresado" = " " ]; then
			echo "Ingrese un nombre de usuario valido!"
		else
			usuario="$usuarioIngresado"
			pedirUsuario=false
		fi
	done
	while [ "$pedirContra" = true ]; do
		echo "Ingrese Contrasena"
		read contraIngresada
		if [ "$contraIngresada" = "" ] || [ "$contrasenaIngresada" = " " ]; then
			echo "Ingrese una contrasena valida!"
		else
			contrasena="$contraIngresada"
			pedirContra=false
		fi
	done


	grep -q "$usuario - $contrasena" admin.txt
	res=$?

	if [ "$res" -eq 1 ]; then
		echo "Usuario o contrasena incorrectas!"
		menuInicio
	else
		menuAdmin "$usuario"
	fi
}


ingresoCliente(){
	echo "INGRESAR COMO CLIENTE"
	local pedirCI=true
	local pedirContra=true
	local CI
	local contrasena
	local contrasenaCorrecta

	while [ "$pedirCI" = true ]; do
		echo "Ingrese Cedula"
		read CIingresada
		if [ -z "$CIingresada" ]; then
			echo "Ingrese una CI valida!"
		else
			CI="$CIingresada"
			pedirCI=false
		fi
	done
	while [ "$pedirContra" = true ]; do
		echo "Ingrese Contrasena"
		read contraIngresada
		if [ -z "$contraIngresada" ]; then
			echo "Ingrese una contrasena valida!"
		else
			contrasena="$contraIngresada"
			pedirContra=false
		fi
	done


	grep -q "^$CI -" "$ARCHIVO_CLIENTES"
	resCI=$?
	
	contrasenaCorrecta=$(grep "^$CI - " clientes.txt | cut -d '-' -f 3 | xargs)

	echo "La CI es: $resCI"
	echo "La contraseña encontrada es: $contrasenaCorrecta"
	if [ "$resCI" -eq 1 ]; then
		echo "Usuario incorrecto"
		menuInicio
	elif [ "$contrasena" != "$contrasenaCorrecta" ]; then
		echo "Contraseña incorrecta"
		menuInicio
	else
		usuarioCorrecto=$(grep "^$CI -" "$ARCHIVO_CLIENTES" | cut -d '-' -f 2 | xargs)
		menuCliente "$usuarioCorrecto"
	fi

}



menuInicio(){

	local pedirOpcion=true

	while [ "$pedirOpcion" = true ]; do
		echo " "
		echo "_________________________"
		echo "MENU DE INICIO"
		echo "Seleccione opcion" 
		echo " "
		echo "1. Ingresar como Cliente"
		echo "2. Ingresar como Administrador"
		echo "3. Salir"
		echo "4. Vaciar Archivo Admins"
		echo "_________________________"
		read opcion

		if [ "$opcion" = 1 ]; then
			pedirOpcion=false
			echo "Ingresando como Cliente..."
			ingresoCliente
		elif [ "$opcion" = "2" ]; then
			pedirOpcion=false
			echo "Ingresando como Administrador"
			ingresoAdmin
		elif [ "$opcion" = "3" ]; then
			echo "Saliendo..."
			pedirOpcion=false
		elif [ "$opcion" = "4" ]; then
			> "$ARCHIVO_ADMINS"
			primerAdmin
		fi
	done

}



main(){

#Archivos

ARCHIVO_ADMINS="admin.txt"
ARCHIVO_CLIENTES="clientes.txt"
ARCHIVO_MASCOTAS="mascotas.txt"
ARCHIVO_ADOPCIONES="adopciones.txt"

archivoVacio "ARCHIVO_ADMINS"
menuInicio

}

#Ejecutar a partir del main
main

