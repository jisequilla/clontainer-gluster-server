node {
 	// Clean workspace before doing anything
    deleteDir()

    try {
		environment {
			GS_VERSION = "1.2.0"
			GLUSTER_SERVER = "gluster-server"
			GLUSTER_SERVER_JAVA = "${GLUSTER_SERVER}-java8"
			GLUSTER_SERVER_JAVA_SERVICE = "${GLUSTER_SERVER_JAVA}-service"
			GLUSTER_SERVER_PATH="${GLUSTER_SERVER}/${GS_VERSION}/"
			GLUSTER_SERVER_8_PATH="${GLUSTER_SERVER_JAVA}/${GS_VERSION}"
			GLUSTER_SERVER_8_S_BASE="${GLUSTER_SERVER_JAVA_SERVICE}"
			GLUSTER_SERVER_8_S_LAYER_1="1.3.0"
			GLUSTER_SERVER_8_S_LAYER_2="1.4.0"
		}
		stages{
			stage ('Build') {
				steps{
					echo 'Building  ${GLUSTER_SERVER}'
					sh "cd ${GLUSTER_SERVER_PATH}"
					sh "docker build -t ${GLUSTER_SERVER}:${GS_VERSION} ."
					sh "cd ../../"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER_8_PATH}'
					sh "cd ${GLUSTER_SERVER_8_PATH}"
					sh "docker build -t ${GLUSTER_SERVER_JAVA}:${GS_VERSION} ."
					sh "cd ../../"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER_8_S_BASE}/${GLUSTER_SERVER_8_S_LAYER_1}'
					sh "cd ${GLUSTER_SERVER_8_S_BASE}/${GLUSTER_SERVER_8_S_LAYER_1}"
					sh "docker build -t ${GLUSTER_SERVER_JAVA_SERVICE}:${GLUSTER_SERVER_8_S_LAYER_1} ."
					sh "cd ../../"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER_8_S_BASE}/${GLUSTER_SERVER_8_S_LAYER_2}'
					sh "cd ${GLUSTER_SERVER_8_S_BASE}/${GLUSTER_SERVER_8_S_LAYER_2}"
					sh "docker build -t ${GLUSTER_SERVER_JAVA_SERVICE}:${GLUSTER_SERVER_8_S_LAYER_2} ."
					sh "cd ../../"
				}
			
			}
			stage ('Deploy') {
			    steps{
					echo "Generating artifacts"
					sh "mkdir target"
					sh "cd target"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER}'
					sh "docker save -o ${GLUSTER_SERVER}-${GS_VERSION}.tar ${GLUSTER_SERVER}:${GS_VERSION}"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER_JAVA}'
					sh "docker save -o ${GLUSTER_SERVER_JAVA}-${GS_VERSION}.tar ${GLUSTER_SERVER_JAVA}:${GS_VERSION}"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER_8_S_BASE}/${GLUSTER_SERVER_8_S_LAYER_1}'
					sh "docker save ${GLUSTER_SERVER_JAVA_SERVICE}-${GLUSTER_SERVER_8_S_LAYER_1}.tar -o ${GLUSTER_SERVER_JAVA_SERVICE}:${GLUSTER_SERVER_8_S_LAYER_1}"
				}
				steps{
					echo 'Building  ${GLUSTER_SERVER_8_S_BASE}/${GLUSTER_SERVER_8_S_LAYER_2}'
					sh "docker save -o ${GLUSTER_SERVER_JAVA_SERVICE}-${GLUSTER_SERVER_8_S_LAYER_2}.tar ${GLUSTER_SERVER_JAVA_SERVICE}:${GLUSTER_SERVER_8_S_LAYER_2}"
				}
			}	
		}	
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}