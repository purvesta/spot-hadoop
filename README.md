# Apache Spot Single Hadoop Instance Docker Image
Apache Hadoop with all the necessary services installed for Apache Spot

## Building image locally
Build the image:
```
$ make build
```
## Running the built container
Run the image:
```   
$ make start
```
You can then access the hadoop instance on port 8088

## Test Hadoop installation
Run sample MapReduce job to test installation:
```
# Exec into the container
$ docker exec -it hadoop bash

# Once shell has started run hadoop "pi" example job
$ hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar pi 10 100
```
