
```bash
#mvn archetype:generate -DgroupId=com.dreamlab -DartifactId=my-java-web-service -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

mvn archetype:generate -DgroupId=com.dreamlab.web -DartifactId=java-web-project -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
mvn clean package

mvn dependency:tree
mvn jetty:run

mvn exec:java -Dexec.mainClass="com.example.Main"
```
