#!/bin/bash

#
### -------------------- Variables -------------------------- ####
#

# Globales

PARAMETROS=$@
MIN_PARAM=2
MAX_PARAM=2
ERR_PARAM=1

f_checkExec ()
{

# Si el primer parametro que recibe es distinto de 0 sale con ese codigo

 C_EXIT=${1}
 C_MESSAGE=${2}

 if [ "X${C_EXIT}" != "X0" ]
 then
   echo -e "\n\t${C_MESSAGE} : ERROR ${C_EXIT}" 
   exit ${C_EXIT}
 fi

}

f_getParams ()
{

 # Funcion encargada del trato de parametros.

 if [ $# -lt $MIN_PARAM ] || [ $# -gt $MAX_PARAM ]
 then
   f_help
   f_checkExec $ERR_PARAM "- ERROR $ERR_PARAM: Parametros incorrectos"
 fi

}

f_help ()
{

# Funcion de ayuda

 echo
 echo " + Script: `basename $0`"
 echo
 echo " + Descripcion: Script para copiar ficheros en listado nombrefichero;ip a las ips destino"
 echo ""
 echo " + Pre-requisitos:"
 echo ""
 echo "   1. Los ficheros a copiar se encuentran en un directorio/subdirectorio que el directorio en el que se encuentra el script"
 echo
 echo " + Ejecucion:"
 echo
 echo " basename $0 fichero_listado path_destino"

}

#
### -------------------- Main - Principal ------------------------- ####
#

f_getParams "$@"

# Enviamos el nombre de fichero coincidente a su correspondiente ip

for i in `cat $1`
do

  STR_FICHERO_A_ENVIAR=`echo $i | awk -F";" '{print $1}'`
  FICHERO_A_ENVIAR=`find . -name "$STR_FICHERO_A_ENVIAR.*"`
  IP_DESTINO=`echo $i | awk -F";" '{print $2}'`

  echo "$FICHERO_A_ENVIAR $IP_DESTINO"

  #scp $FICHERO_A_ENVIAR $IP_DESTINO:"$2" 

done

