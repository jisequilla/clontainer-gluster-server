#!/bin/sh

#------------------------------------------------------------
# mount_nova_fs.sh
#
# Entrypoint para servicios NOVA.
#
# 05/06/2017
#
# Creacion
#
# Argumentos de entrada:
#
# PUNTO_MONTAJE: Punto de montaje del sistema de archivos
#
#------------------------------------------------------------

#============================================================
# Definicion de variables para la ejecucion del shell
#============================================================
HOST1=$1
HOST2=$2
REMOTE_MOUNT_POINT=$3
LOCAL_MOUNT_POINT=$4

#------------------------------------------------------------
# Trazas
#------------------------------------------------------------
log()
{
  echo "$*"
}

#------------------------------------------------------------
# Validaciones de variables para cualquier desarrollo
# Errores 100-103
#------------------------------------------------------------
validar_variables_entorno()
{
  log ">  Validando variables de entorno ...."

  ERR_CODE=0

  #---- Validaciones comunes

  if [ -z "$HOST1" ]
    then
      log ">    No se ha definido la variable HOST1"
      return 100
    fi

  if [ -z "$HOST2" ]
    then
      log ">    No se ha definido la variable HOST2"
      return 101
    fi

  if [ -z "$REMOTE_MOUNT_POINT" ]
    then
      log ">    No se ha definido la variable REMOTE_MOUNT_POINT"
      return 102
    fi

  if [ -z "$LOCAL_MOUNT_POINT" ]
    then
      log ">    No se ha definido la variable LOCAL_MOUNT_POINT"
      return 103
    fi

  return $ERR_CODE
}

#------------------------------------------------------------
# Ejecutar java
#------------------------------------------------------------
montar()
{
  log "Montando sistema de archivos"
  log ">    PUNTO_MONTAJE LOCAL        : $LOCAL_MOUNT_POINT"
  log ">    HOST1                      : $HOST1"
  log ">    HOST2                      : $HOST2"
  log
  log ">    CREANDO DIRECTORIO LOCAL   : $LOCAL_MOUNT_POINT"
  mkdir -p $LOCAL_MOUNT_POINT
  log ">    COMANDO A EJECUTAR : mount -t glusterfs -o backupvolfile-server=$HOST1 $HOST2:REMOTE_MOUNT_POINT $LOCAL_MOUNT_POINT"
  mount -t glusterfs -o backupvolfile-server=$HOST1 $HOST2:$REMOTE_MOUNT_POINT $LOCAL_MOUNT_POINT
  MOUNT_ERROR=$?
  if [ "$MOUNT_ERROR" != "0" ]
    then
      log ">    SHOWING MOUNT LOG RESULTS, MAX 50 LINES"
      tail -50 /var/log/glusterfs/${LOCAL_MOUNT_POINT}.log
    fi
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
log "    Inicio del script: montar_fs.sh"
log "----------------------------------------------"
log

# Validar los parametros de entrada
validar_variables_entorno
ERR_CODE=$?

# Montar sistema de archivos
if [ "$ERR_CODE" = "0" ]
  then
    montar
  fi

exit $ERR_CODE
