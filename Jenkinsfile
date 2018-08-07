node {
 	// Clean workspace before doing anything
    //

    try {

		stage ('Checkout'){

			deleteDir()
		
			checkout scm
		
		}
		
		stage ('Build gluster-server') {
		
			echo 'Building  gluster-server'
			sh "docker build -t gluster-server:1.2.0 gluster-server/1.2.0/"
		}
		
		stage ('Build gluster-server-java8'){	
		
			echo 'Building  gluster-server-java8'
			sh "docker build -t gluster-server-java8:1.2.0 gluster-server-java8/1.2.0/"
		}
		
		stage ('Build gluster-server-java8-service'){
	
			echo 'Building  gluster-server-java8-service/1.3.0'
			sh "docker build -t gluster-server-java8-service:1.3.0 gluster-server-java8-service/1.3.0/"
		
			echo 'Building  gluster-server-java8-service/1.4.0'
			sh "docker build -t gluster-server-java8-service:1.4.0 gluster-server-java8-service/1.4.0"
		}
			
    } catch (err) {
        currentBuild.result = 'FAILED'
        throw err
    }
}