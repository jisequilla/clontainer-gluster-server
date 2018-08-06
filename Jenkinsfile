node {
 	// Clean workspace before doing anything
    deleteDir()

    try {

		stage ('Build') {
			
				echo 'Building  gluster-server'
				sh "cd gluster-server"
				sh "docker build -t gluster-server:1.2.0 ."
				sh "cd ../../"
			
			
				echo 'Building  gluster-server-java8'
				sh "cd gluster-server-java8"
				sh "docker build -t gluster-server-java8:1.2.0 ."
				sh "cd ../../"
			
				echo 'Building  gluster-server-java8-service/1.3.0'
				sh "cd gluster-server-java8-service/1.3.0"
				sh "docker build -t gluster-server-java8-service:1.3.0 ."
				sh "cd ../../"
			
				echo 'Building  gluster-server-java8-service/1.4.0'
				sh "cd gluster-server-java8-service/1.4.0"
				sh "docker build -t gluster-server-java8-service:1.4.0 ."
				sh "cd ../../"
			
		
		}
			
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}