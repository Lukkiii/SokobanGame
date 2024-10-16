Play the game on [CodinGame](https://www.codingame.com/training/hard/sokoban)

You should add dictionary solution/'s classpath into trajet/classes

Our domain definition file and our java file are in the dictionary solution/

- solution/sokoban.pddl : domain definition
- solution/SokobanSolver.java : Generating the problem file  
                                Using PDDL4J to solve the PDDL problem  
                                Getting solution from the plan found  
                                Editing automatically the Agent class to set the way to move according to the solution  

We put test1 default and if you want to test other tests : 

1. Change in file solution/SokobanSolver.java line 239 : filePath = "config/test*.json";  

2. Change in file src/main/java/sokoban/SokobanMain.java line 9 : gameRunner.setTestCase("test*.json");

To test our program you can just :  

Open a terminal and in the root dictionary :  

On MacOS : 

1. At first run : 
```
javac -cp "lib/pddl4j-4.0.0.jar:lib/json-20240303.jar" solution/SokobanSolver.java  
```

2. Then run : 
```
java -cp "lib/pddl4j-4.0.0.jar:lib/json-20240303.jar" solution/SokobanSolver.java  
```

On Windows : 
```
javac -cp "lib/pddl4j-4.0.0.jar;lib/json-20240303.jar" solution/SokobanSolver.java  
```

```
java -cp "lib/pddl4j-4.0.0.jar;lib/json-20240303.jar" solution.SokobanSolver  
```

3. After run with : 
```
mvn package
```

4. And finally run : 
```
java --add-opens java.base/java.lang=ALL-UNNAMED \
      -server -Xms2048m -Xmx2048m \
      -cp target/sokoban-1.0-SNAPSHOT-jar-with-dependencies.jar \
      sokoban.SokobanMain
```

And then you can see planning solutions at http://localhost:8888/test.html