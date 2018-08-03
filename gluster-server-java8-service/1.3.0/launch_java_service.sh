#!/bin/sh

#------------------------------------------------------------
# launch_java_service.sh
#
# Entrypoint para servicios NOVA.
#
# 05/06/2017
#
# Creacion
#
# Argumentos de entrada:
#
# MEMORIA: Memoria en MB reservada para el contenedor
# EJECUTABLE: Nombre del archivo .jar que se ejecutará
# PUNTO_MONTAJE: Punto de montaje del sistema de archivos
# -mem MEMORIA
# -mount bricks:ruta ruta_local
#------------------------------------------------------------

#------------------------------------------------------------
# Trazas
#------------------------------------------------------------
log()
{
  echo "$*"
}

#------------------------------------------------------------
# Validaciones de variables para cualquier desarrollo
# Errores 100-101
#------------------------------------------------------------
validar_variables_entorno()
{
  log ">  Validando variables de entorno ...."

  ERR_CODE=0

  #---- Validaciones comunes

  if [ -z "$MEMORIA" ]
    then
      log ">    No se ha definido la variable MEMORIA"
      return 100
    fi

  if [ -z "$EJECUTABLE" ]
    then
      log ">    No se ha definido la variable EJECUTABLE"
      return 101
    fi

  return $ERR_CODE
}

#------------------------------------------------------------
# Ejecutar java
#------------------------------------------------------------
ejecutar_java()
{
  log "Ejecutando java"
  log ">    MEMORIA       : $MEMORIA"
  log ">    EJECUTABLE       : $EJECUTABLE"
  log ">    JAR_PARAMS       : $JAR_PARAMS"
  java -Xms${MEMORIA}m -Xmx${MEMORIA}m -jar ${EJECUTABLE} ${JAR_PARAMS}
}

#============================================================
# Inicio del Script
#============================================================
# main()
clear

# Comienzo del script
ERR_CODE=0

log
log
log "----------------------------------------------"
log "    Inicio del script: script_nova.sh"
log "----------------------------------------------"
log

# Procesar variables de entrada
while test $# -gt 0; do
  case "$1" in
    -mem)
      shift
      log "Definiendo memoria"
      log ">    MEMORIA       : $1"
      MEMORIA=$1
      shift
      ;;
	-mount)
      shift
      log "Montando sistema de archivos"
      log ">    PUNTO DE MONTAJE       : $1"
      mount_nova_fs.sh $1
	  shift
      ;;
    -jar)
      shift
      log "Definiendo ejecutable"
      log ">    EJECUTABLE       : $1"
	  EJECUTABLE=$1
      shift
      ;;
    -jarparams)
      shift
      log "Definiendo parametros del ejecutable"
      log ">    JAR_PARAMS       : $1"
	  JAR_PARAMS=$1
      shift
      ;;
	*)
      log ">    Variable desconocida: $1"
      shift
      ;;
  esac
done

# Validar los parametros de entrada
validar_variables_entorno
ERR_CODE=$?

# Ejecutar punto de entrada JAVA
if [ "$ERR_CODE" = "0" ]
  then
    ejecutar_java
  fi

exit $ERR_CODE
