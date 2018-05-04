# Prometheus Amazon ECS discovery

Prometheus has native Amazon EC2 discovery capabilities, but it does
not have the capacity to discover ECS instances that can be scraped
by Prometheus. This docker image uses the excellent Prometheus Amazon ECS 
discovery program which is an Prometheus File Service Discovery
(`file_sd_config`) integration that bridges said gap.

For more information on the actual ECS scraping program, please see 
(https://github.com/teralytics/prometheus-ecs-discovery)[https://github.com/teralytics/prometheus-ecs-discovery]!

## Usage

This image works well for me, but I do have a very specific setup to make
it all work. First of all, the ECS task for this image and for the Prometheus
task share a common file system (EFS to be exact). 

The idea is that Prometheus and this image share a filesystem in such a way
that the file this image creates is seen by Prometheus server.

For this image to work correctly, I have setup a special IAM role this image
runs with. This role has a policy allowing: ```ECS:ListClusters```, 
```ECS:ListTasks```, ```ECS:DescribeTask```, ```EC2:DescribeInstances```, 
```ECS:DescribeContainerInstances```, ```ECS:DescribeTasks```, 
```ECS:DescribeTaskDefinition)```
