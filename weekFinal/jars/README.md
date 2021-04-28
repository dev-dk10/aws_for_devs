# JARs for the final assigment

Set of jars represents distributed calculator application. All jars require java 8 installed. 

* **calc-client-1.0-SNAPSHOT.jar** - client application, should be executed on local machine. Continuously sends HTTP requests to the provided endpoint and prints responses. Command to run client jar:
    ```
    java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient <ELB’s DNS name> 
    
    ```

* **calc-2021-0.0.2-SNAPSHOT.jar** - application which is running on public instances, load balancer routes requests to this application. Performs calculation, writes information in Dynamo DB, sends message to SQS, sends notification via SNS. Produces logs in /logs folder in the same directory were jar is placed. Command to run client jar:
    ```
    java -jar calc-2021-0.0.1-SNAPSHOT.jar
    
    ```

* **persist3-2021-0.0.1-SNAPSHOT.jar** - application which is running on instance in private subnet. Reads messages from the SQS, log them in RDS, sends SNS notifications. Produces logs in /logs folder in the same directory were jar is placed. Requires environment variable RDS_HOST with correct RDS address. Command to run client jar:
    ```
    java -jar persist3-2021-0.0.1-SNAPSHOT.jar
    
    ```