# Guide to Micronaut Kubernetes Demo Project [![Twitter](https://img.shields.io/twitter/follow/piotr_minkowski.svg?style=social&logo=twitter&label=Follow%20Me)](https://twitter.com/piotr_minkowski)

[![CircleCI](https://circleci.com/gh/piomin/sample-micronaut-kubernetes.svg?style=svg)](https://circleci.com/gh/piomin/sample-micronaut-kubernetes)

[![SonarCloud](https://sonarcloud.io/images/project_badges/sonarcloud-black.svg)](https://sonarcloud.io/dashboard?id=piomin_sample-micronaut-kubernetes)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=piomin_sample-micronaut-kubernetes&metric=bugs)](https://sonarcloud.io/dashboard?id=piomin_sample-micronaut-kubernetes)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=piomin_sample-micronaut-kubernetes&metric=coverage)](https://sonarcloud.io/dashboard?id=piomin_sample-micronaut-kubernetes)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=piomin_sample-micronaut-kubernetes&metric=ncloc)](https://sonarcloud.io/dashboard?id=piomin_sample-micronaut-kubernetes)

In this project I'm demonstrating you the most interesting features of [Micronaut Kubernetes Project](https://micronaut-projects.github.io/micronaut-kubernetes/snapshot/guide/) for integration between Micronaut and Kubernetes API.

## Getting Started 
Currently you may find here some examples of microservices implementation using different projects from Micronaut. All the examples are divided into the branches and described in a
 separated articles on my blog. Here's a full list of available examples:
1. Using **Micronaut Kubernetes** for integration with Kubernetes discovery, `ConfigMaps` and `Secrets`. A source code is available in
 the branch [master](https://github.com/piomin/sample-micronaut-kubernetes/tree/master). A detailed guide may be find in the following article: [Guide to Micronaut Kubernetes
 ](https://piotrminkowski.com/2020/01/07/guide-to-micronaut-kubernetes/)
 
### Usage
To successfully run example applications you need to have:
1. JDK11+ as a default Java on your machine
2. Maven 3.5+ available under PATH
3. Minikube (I tested on version `1.6.1`)
4. Skaffold available under PATH

## Architecture

Our sample microservices-based system consists of the following modules:
- **employee-service** - a module containing the first of our sample microservices that allows to perform CRUD operation on Mongo repository of employees
- **department-service** - a module containing the second of our sample microservices that allows to perform CRUD operation on Mongo repository of departments. It communicates with employee-service. 
- **organization-service** - a module containing the third of our sample microservices that allows to perform CRUD operation on Mongo repository of organizations. It communicates with both employee-service and organization-service.

The following picture illustrates the architecture described above including Kubernetes objects.

<img src="https://piotrminkowski.files.wordpress.com/2020/01/guide-to-micronaut-kubernetes-architecture.png" title="Architecture1">

## App links
- **[Health Check Endpoints](http://localhost:8090/health)**
## New Features to be added
- **Kafka Integration**
- **Health Checks and K8s probes**

## Useful commands
- zookeeper-server-start /Users/xxx/kafka/zookeeper.properties
- kafka-server-start /Users/xxx/kafka/server.properties
- mvn package -Dpackaging=docker

## Run Standalone Apps
1. `cd employee-service && mvn clean mn:run`  [employees endpoint](http://localhost:8092/employees)
2. `cd department-service && mvn clean mn:run` [departments endpoint](http://localhost:8091/departments)
3. `cd organization-service && mvn clean mn:run`  [organizations endpoint](http://localhost:8090/organizations)

## Build native Docker Images from Intellij
1. From Manven tag navigate to plugins>mn>mn:dockerNative
2. `docker tag organization:latest docker.io/piomin/organization:latest`
3. Load Docker image to k8s cluster `kind load docker-image docker.io/piomin/organization --name local-k8s`
4. `docker exec local-k8s-control-plane crictl images`
4. `cd organization-service\k8s && kubectl create -f deployment.yaml `

## Manual Docker build & K8s Deployment
1. `cd organization-service && sudo docker build -t organization-service:1.0-latest .`
2. `kind load docker-image organization-service:1.0-latest --name local-k8s`
3. `kubectl create -f ./k8s/deployment.yaml`