#!/bin/sh

#------------------------------------------------------------
# launch_gluster_and_java_service.sh
#
# Entrypoint para servicios NOVA que utilizan GlusterFS.
#
# 28/06/2017

# Argumentos de entrada:
#
# MEMORIA: Memoria en MB reservada para el contenedor
# EJECUTABLE: Nombre del archivo .jar que se ejecutará
# PUNTO_MONTAJE: Punto de montaje del sistema de archivos
# JAR_PARAMS: Parametros de ejecucion
# -mem MEMORIA
# -mount bricks:ruta ruta_local
# -jar EJECUTABLE
# -jarparams JAR_PARAMS
#-------------------------------------------------------------

#------------------------------------------------------------
# Trazas
#------------------------------------------------------------
log()
{
  echo "$*"
}

#============================================================
# Inicio del Script
#============================================================
# main()
clear

log
log
log "-----------------------------------------------------------"
log "    Inicio del script: launch_gluster_and_java_service.sh"
log "-----------------------------------------------------------"
log

log ">		Llamando al script de arranque de Gluster: /usr/sbin/start-gluster-server.sh"
/usr/sbin/start-gluster-server.sh
# Se llama al script de inicio del servicio pasandole los parametros que reciba el propio script 
log ">		Llamando al script de arranque de JAVA Service: /usr/bin/launch_java_service.sh"
/usr/bin/launch_java_service.sh "$@"
