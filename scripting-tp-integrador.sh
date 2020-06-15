#!/bin/bash
while :
do
	clear
	opcion=0
	echo "---------------------MENU PRINCIPAL-------------------------"
	echo "------------------------------------------------------------"
	echo "1. Pide un numero entero y muestra esa cantidad de elementos"
	echo "   de la sucesion de Fibonacci"
	echo ""
	echo "2. Pide un numero entero y mustra por pantalla ese numero "
        echo "   en forma invertida"
        echo ""
        echo "3. Pide una cadena de texto y evalua si es palindromo "
	echo ""
	echo "4. Pide un PATH de un archivo de texto y devuelve la cantidad "
	echo "   de lineas que posee"
	echo ""
	echo "5. Pide el ingreso de 5 numeros enteros y los muestra por "
	echo "   pantalla en forma ordenada."
	echo ""
	echo "6. Pide el PATH a un directorio y muestra por pantalla"
	echo "   cuantos archivos de cada tipo contiene "
	echo ""
	echo "7. Salir"
	echo "------------------------------------------------------------"
	echo
	echo -n "Elige una opcion: "
	read opcion
	case $opcion in
	    ########################################################
	    ## 1 - Serie Fibonacci
 	    #######################################################
	    1)
	    	clear
	  	echo -n "Ingrese un Numero Entero Positivo: "
		read entero
		## Chequeo que el Numero sea Entero positivo ##
		if [[ $entero =~ ^[+]?[0-9]+$ ]]; then
		    echo -n "Serie de Fibonacci: "
		    a=0
		    b=1
		    for (( i=0; i<entero; i++ ))
		    do
		    	echo -n "$a "
			fn=$((a + b))
    			a=$b
    			b=$fn
		    done
		    echo ""
		    echo "------------------------------------"
		    echo "Presione la tecla enter para salir"
		    echo "------------------------------------"
		else
		    echo "Error: El nummero ingresado no es un numero entero positivo"
		fi
		read enterkey;
		;;

            #######################################################
      	    ## 2 - Invertir Numero Entero
	    ######################################################
	    2)
	        clear
                echo -n "Ingrese un Numero Entero: "
                read entero
                ## Chequeo que el Numero sea Entero positivo ##
		if [[ $entero =~ ^[+-]?[0-9]+$ ]]; then
		    invertido=""
		    len=${#entero}
		    for (( i=$len-1; i>=0; i-- ))
		    do
			invertido="$invertido${entero:$i:1}"
		    done
		    echo "El Entero Inertido es: $invertido"
                    echo ""
                    echo "------------------------------------"
	            echo "Presione una tecla para salir"
		    echo "------------------------------------"
		 else
                    echo "Error: El nummero ingresado no es un numero entero positivo"
                 fi
                 read enterkey
		 ;;

	    #######################################################
            ## 3 - Evaluar Cadena Palindromo
            ######################################################
            3)
                clear
                echo -n "Ingrese una Palabra: "
                read cadena
                ## Chequeo que lo Ingresado sea String  e invierto palabra##
                if [[ $cadena =~ [a-zA-Z]*$ ]]; then

    		    ## Elimino espacios en cadena
		    cadena_sin_espacio=$(echo "$cadena" | tr -d '[[:space:]]')
                    invertido=""
                    len=${#cadena_sin_espacio}
                    for (( i=$len-1; i>=0; i-- ))
                    do
                        invertido="$invertido${cadena_sin_espacio:$i:1}"
                    done

		    ## Comparo Cadena invertida y Original
		    if [[ $cadena_sin_espacio == $invertido ]]; then
		    	echo "La cadena: \' $cadena \'- ES palindromo"
		    else
			echo "La cadena: \' $cadena \'- NO ES palindromo"
		    fi
                 else
                    echo "Error: El valor ingresado no es una cadena de texto"
                 fi
                 echo "------------------------------------"
                 echo "Presione la tecla enter para salir"
 		 echo "------------------------------------"


                 read enterkey
                 ;;

            #######################################################
            ## 4 - Muestra Cant. Lineas de Archivo Texto
            ######################################################
            4)
                clear
                echo -n "Ingrese PATH a un Archivo de Texo (EJ: /home/usuario/archivo.txt): "
                read cadena
		if [ -f "$cadena" ]; then
   		    cantidad=$(cat "$cadena" | wc -l)
    		    echo "El archivo de Texto posee $cantidad lineas."
		else
		    echo "El PATH ingresado no pertenece a un archivo existente."
		fi
		echo "------------------------------------"
		echo "Presione la tecla enter para salir"
 		echo "------------------------------------"

                read enterkey
		;;

	    #######################################################
            ## 5 - Ordenar 5 Numeros enteros
            ######################################################
            5)
		clear
		for (( i=1; i<6; i++ ))
                do
   		    flag_entero=0
		    while [[ $flag_entero -lt 1 ]]; do
  		    	echo -n "Ingrese Numero $i: "
		    	read numero
		    	## Chequeo que el Numero sea Entero positivo ##
                    	if [[ $numero =~ ^[+-]?[0-9]+$ ]]; then
			    numeros[$i]=$numero
			    flag_entero=1
		    	else
			    echo "El valor ingresado no es un Entero"
		    	fi
		    done
		done

		## Metodo para Ordenar Array
		ordenados=($(echo ${numeros[*]}| tr " " "\n" | sort -n))
		echo "Secuencia numerica ordenada: ${ordenados[@]}"
		echo ""
		echo "------------------------------------"
		echo "Presione la tecla enter para salir"
   	        echo "------------------------------------"

                read enterkey
		;;

	    #######################################################
            ## 6 - Muestra cantidad de archivos por extensiones
            ######################################################
	    6)
		clear
                echo -n "Ingrese PATH a una Carpeta (EJ: /home/usuario): "
                read cadena
                if [ -d "$cadena" ]; then
		    cantidad_carpetas=$(cd $cadena && ls -l | grep ^d | wc -l)
		    cantidad_regulares=$(cd $cadena && ls -l | grep ^- | wc -l)
		    cantidad_simbolicos=$(cd $cadena && ls -l | grep ^l | wc -l)
		    cantidad_chardev=$(cd $cadena && ls -l | grep ^c | wc -l)
		    cantidad_bloques=$(cd $cadena && ls -l | grep ^b | wc -l)
		    cantidad_pipes=$(cd $cadena && ls -l | grep ^p | wc -l)
		    cantidad_sockets=$(cd $cadena && ls -l | grep ^s | wc -l)

   		    echo "------------------------------------------"
		    echo "Listado de Cantidad de Archivos por Tipos"
		    echo "------------------------------------------"
		    echo ""
		    echo "Directorios: $cantidad_carpetas"
		    echo "Link Simbolicos: $cantidad_simbolicos"
		    echo "Archivos Regulares: $cantidad_regulares"
		    echo "Archivos de Caracter: $cantidad_chardev"
		    echo "Archivos de Bloques: $cantidad_bloques"
		    echo "Pipes: $cantidad_pipes"
		    echo "Sockets: $cantidad_sockets"

                else
                    echo "El PATH ingresado no pertenece a un directorio existente."
                fi
		echo ""
                echo "------------------------------------"
                echo "Presione la tecla enter para salir"
                echo "------------------------------------"

                read enterkey
                ;;

	    #######################################################
            ## 7 - Salida del Sistema
            ######################################################
	    7)
	        exit
		;;

	    *)
		clear
		echo "La opcion $opcion no esta en la lista"
		read enterkey
		;;

	esac
done
