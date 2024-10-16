Play the game on [CodinGame](https://www.codingame.com/training/hard/sokoban)

Maven is needed.

Install pddl4j (https://github.com/pellierd/pddl4j) in your local maven repo:
```
mvn install:install-file \
   -Dfile=<path-to-file-pddl4j-4.0.0.jar> \
   -DgroupId=fr.uga \
   -DartifactId=pddl4j \
   -Dversion=4.0.0 \
   -Dpackaging=jar \
   -DgeneratePom=true
 ```  
Work with maven: mvn clean, mvn compile, mvn test, mvn package

Our domain definition file and our java file are in the dictionary solution/

- solution/sokoban.pddl : domain definition
- solution/SokobanSolver.java : Generating the problem file  
                                Using PDDL4J to solve the PDDL problem  
                                Getting solution from the plan found  
                                Editing automatically the Agent class to set the way to move according to the solution  

We put test1 default and if you want to test other tests : 

1. Change in file solution/SokobanSolver.java line 239 : filePath = "../config/test*.json";  

2. Change in file src/main/java/sokoban/SokobanMain.java line 9 : gameRunner.setTestCase("test*.json");

To test our program you can just :  

Open a terminal and in the root dictionary :  

1. run javac -cp "lib/pddl4j-4.0.0.jar:lib/json-20240303.jar" solution/SokobanSolver.java  

2. run java -cp "lib/pddl4j-4.0.0.jar:lib/json-20240303.jar" solution/SokobanSolver.java  

Open another terminal :  

1. At first run with : mvn package

2. And after run : 
```
java --add-opens java.base/java.lang=ALL-UNNAMED \
      -server -Xms2048m -Xmx2048m \
      -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar \
      sokoban.SokobanMain
```

And see planning solutions at http://localhost:8888/test.html