# Jenkins
Jenkins is a open source continuous integration server. It builds and tests your software continuously and monitors the execution and status of remote jobs, making it easier for team members and users to regularly obtain the latest stable code and deploy to pre-prod or prod.

### Jenkins Pipeline

Jenkins Pipeline is a set of plugins for Jenkins to define CI/CD flows. Jenkins Pipeline definition can be written into a file named `Jenkinsfile` or put into Jenkins configurations.
There are `two types` of Pipeline definitions. `Declarative` and `scripted`.

## Installing Jenkins with Docker

#### why Jenkins with Docker
To install Jenkins, we used Docker containers. Our master Jenkins server sits inside the container and connects our build machine with SSH. The reason we choose this structure is the portability.

When we use docker container, we give local volume to Jenkins. It is writing all of its data into this folder and it is synced with the folder in our build machine. This ensures that, when we shut the container down, we have all the Jenkins data like settings, project configurations, logs etc. A new Jenkins container can run from that data. Jenkins will validate its data at start. It will notify changes or expired configuration entries. Hence the reason we store data in our build machine.

We can update Jenkins with just a few commands. Stop the container, pull the new image and run a new container from new image. We won’t install java, we won’t install jenkins environmental variables. Our build server is clean just with the docker installation.

This easy setup process makes it possible to, in emergency situations, create a build server inside any machine using macOS too.

### Steps

- [install docker](https://docs.docker.com/desktop/install/mac-install/)
- check if docker installed by running:
	- ***docker --version***
- check if docker can pull image:
	- ***docker run hello-world***
- pull jenkins image:
	- ***docker pull jenkins/jenkins:2.365***
- run jenkins image:
	- ***`docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:2.365`***

> With this command we are running a container with daemon mode. We are assigning a volume to “/var/jenkins_home” folder to sync Jenkins files with our host machine. We are assigning 8080 and 50000 ports of host machine to docker container. Docker will listen to these ports and forward them to container. Lastly, we are giving image tag. This command will produce an image hash like: `4f7957e35aacb8b6468c4fc7fdb2228df3e02133bcc423d7789072cc41f089d2` for successful allocations.

> If you have applications listening to these ports, you have to change ports or close them. Left side of the port assignment is host machine. For example, `80:8080` will forward 80 port of host machine to 8080 port of container. Now when you go to the address `http://localhost:8080` you will see the initial jenkins page like below:

<img src="../staticresources/jenkins_starter.png" alt="jenkins starter page" style="height: 500px; width:500px;"/>

- connect with container:
	- ***docker exec -it image_hash bash***

> “i” means interactive shell. If you don’t specify this, docker will send your command into container and exit when its finished.

> “t” commands docker to create pseudo terminal. Without this it will act like a terminal connection.

> Lastly bash is the program to run. You can specify other programs without -i. We will try this soon.

- get initial admin password:
	- ***cat /var/jenkins_home/secrets/initialAdminPassword***
- Now login to jenkins.
- Install recommended plugins.

> if failed to install or getting error like `This Jenkins instance appears to be offline.` Try this solution.



