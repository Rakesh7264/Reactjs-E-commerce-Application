pipeline {
    agent any

    triggers {
        githubPush()
    }

    environment {
        DOCKER_USER = "rakesh7264"
        DEV_REPO = "${DOCKER_USER}/dev"
        PROD_REPO = "${DOCKER_USER}/prod"
        IMAGE_NAME = "devops-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Debug') {
            steps {
                sh 'echo "Branch: $BRANCH_NAME"'
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to DEV Repo') {
            when {
                branch 'dev'
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker tag $IMAGE_NAME $DEV_REPO:latest
                    docker push $DEV_REPO:latest
                    '''
                }
            }
        }

        stage('Push to PROD Repo') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker tag $IMAGE_NAME $PROD_REPO:latest
                    docker push $PROD_REPO:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                sh '''
                docker stop devops-app || true
                docker rm devops-app || true
                docker run -d -p 80:80 --name devops-app $PROD_REPO:latest
                '''
            }
        }
    }
}
