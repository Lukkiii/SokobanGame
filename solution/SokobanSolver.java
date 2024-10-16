import org.json.JSONObject;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import fr.uga.pddl4j.heuristics.state.StateHeuristic;
import fr.uga.pddl4j.planners.LogLevel;
import fr.uga.pddl4j.planners.statespace.FF;
import fr.uga.pddl4j.planners.statespace.HSP;
import fr.uga.pddl4j.problem.operator.Action;
import fr.uga.pddl4j.plan.Plan;

public class SokobanSolver {
    private static String solutionString;

    public static JSONObject readLevel(String filePath) throws IOException {
        FileReader reader = new FileReader(filePath);
        StringBuilder sb = new StringBuilder();
        int i;
        while ((i = reader.read()) != -1) {
            sb.append((char) i);
        }
        reader.close();
        return new JSONObject(sb.toString());
    }

    // parse the grid from the JSON level
    public static String[][] parseGrid(String sokobanGrid) {
        // Split the input into rows by newline characters
        String[] rows = sokobanGrid.split("\n");

        // Find the maximum row length
        int lengthMax = 0;
        for (String row : rows) {
            lengthMax = Math.max(lengthMax, row.length());
        }

        String[][] grid = new String[rows.length][lengthMax];

        for (int i = 0; i < rows.length; i++) {
            String[] rowArray = rows[i].split("");
            for (int j = 0; j < rowArray.length; j++) {
                grid[i][j] = rowArray[j];
            }
            // If the row is shorter than the max length, pad it with spaces
            for (int j = rowArray.length; j < lengthMax; j++) {
                grid[i][j] = " ";
            }
        }

        return grid;
    }

    // generate PDDL problem based on the Sokoban grid
    public static void generatePDDL(String[][] grid, String outputFileName) throws IOException {
        try (FileWriter writer = new FileWriter(outputFileName)) {
            writer.write("(define (problem sokoban-problem)\n");
            writer.write("(:domain sokoban)\n");
    
            boolean[][] inBounds = identifyPlayableArea(grid);
    
            writer.write("(:objects\n");
            for (int i = 0; i < grid.length; i++) {
                for (int j = 0; j < grid[0].length; j++) {
                    if (inBounds[i][j]) {
                        writer.write("pos" + i + "_" + j + " - position\n");
                    }
                }
            }
            writer.write("player1 - player\n");
    
            int boxCounter = 1;
            for (int i = 0; i < grid.length; i++) {
                for (int j = 0; j < grid[0].length; j++) {
                    if ((grid[i][j].equals("$") || grid[i][j].equals("*")) && inBounds[i][j]) {
                        writer.write("box" + boxCounter + " - box\n");
                        boxCounter++;
                    }
                }
            }
            writer.write(")\n");
    
            writer.write("(:init\n");

            for (int i = 0; i < grid.length; i++) {
                for (int j = 0; j < grid[0].length; j++) {
                    if ((grid[i][j].equals("@") || grid[i][j].equals("+")) && inBounds[i][j]) {
                        writer.write("(player-at player1 pos" + i + "_" + j + ")\n");
                    }
                }
            }

            boxCounter = 1;
            for (int i = 0; i < grid.length; i++) {
                for (int j = 0; j < grid[0].length; j++) {
                    if (inBounds[i][j]) {
                        if (grid[i][j].equals("$") || grid[i][j].equals("*")) {
                            writer.write("(box-at box" + boxCounter + " pos" + i + "_" + j + ")\n");
                            boxCounter++;
                        } else if (grid[i][j].equals(" ") || grid[i][j].equals(".")) {
                            writer.write("(free pos" + i + "_" + j + ")\n");
                        }
                        if (grid[i][j].equals(".") || grid[i][j].equals("*") || grid[i][j].equals("+")) {
                            writer.write("(goal pos" + i + "_" + j + ")\n");
                        }
                    }
                }
            }
    
            for (int i = 0; i < grid.length; i++) {
                for (int j = 0; j < grid[0].length; j++) {
                    if (inBounds[i][j]) {
                        if (!grid[i][j].equals("#")) {
                            if (j < grid[0].length - 1 && !grid[i][j+1].equals("#")) {
                                writer.write("(adjacent pos" + i + "_" + j + " pos" + i + "_" + (j+1) + " right)\n");
                                writer.write("(adjacent pos" + i + "_" + (j+1) + " pos" + i + "_" + j + " left)\n");
                            }
                            if (i < grid.length - 1 && !grid[i+1][j].equals("#")) {
                                writer.write("(adjacent pos" + i + "_" + j + " pos" + (i+1) + "_" + j + " down)\n");
                                writer.write("(adjacent pos" + (i+1) + "_" + j + " pos" + i + "_" + j + " up)\n");
                            }
                        }
                    }
                }
            }
    
            writer.write(")\n");
    
            writer.write("(:goal (and \n");
            for (int boxNum = 1; boxNum < boxCounter; boxNum++) {
                writer.write("(at-goal box" + boxNum + ")\n");
            }
            writer.write("))\n");
    
            writer.write(")\n");
        }
    }

    private static boolean[][] identifyPlayableArea(String[][] grid) {
        boolean[][] inBounds = new boolean[grid.length][grid[0].length];

        int startRow = -1;
        int startCol = -1;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j].equals("@") || grid[i][j].equals("+")) {
                    startRow = i;
                    startCol = j;
                    break;
                }
            }
            if (startRow != -1) break;
        }

        floodFill(grid, inBounds, startRow, startCol);
        
        return inBounds;
    }
    
    private static void floodFill(String[][] grid, boolean[][] inBounds, int row, int col) {

        if (row < 0 || row >= grid.length || col < 0 || col >= grid[0].length) return;
        if (grid[row][col].equals("#") || inBounds[row][col]) return;

        inBounds[row][col] = true;
    
        floodFill(grid, inBounds, row + 1, col); // down
        floodFill(grid, inBounds, row - 1, col); // up
        floodFill(grid, inBounds, row, col + 1); // right
        floodFill(grid, inBounds, row, col - 1); // left
    }
    
    

    // Use PDDL4J to solve the PDDL problem
    public static Plan solveWithPDDL4J(String domainFile, String problemFile) throws Exception {

        HSP planner = new HSP();
        planner.setDomain(domainFile);
        planner.setProblem(problemFile);
        planner.setTimeout(1000);
        planner.setLogLevel(LogLevel.INFO);
        planner.setHeuristic(StateHeuristic.Name.MAX);
        planner.setHeuristicWeight(1.5);

        return planner.solve();
    }

    public static void editAgent(String solutionString) {
        // Edit the agent to move according to the solution string
        String filePath = "src/main/java/sokoban/Agent.java";

        try {
            // Read all lines from the file
            List<String> lines = Files.readAllLines(Paths.get(filePath));

            // Iterate through the lines and search for the solution variable
            for (int i = 0; i < lines.size(); i++) {
                String line = lines.get(i);
                if (line.contains("String solution =")) {
                    // Modify the value of the solution variable
                    lines.set(i, "        String solution = \"" + solutionString + "\";");
                }
            }

            // Write the modified lines back to the file
            Files.write(Paths.get(filePath), lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void executePlan(List<Action> list) {
        StringBuilder actions = new StringBuilder();
        
        for (Action action : list) {
            if (action.getName().contains("up")) {
                actions.append("U");
            } else if (action.getName().contains("down")) {
                actions.append("D");
            } else if (action.getName().contains("left")) {
                actions.append("L");
            } else if (action.getName().contains("right")) {
                actions.append("R");
            }
        }

        solutionString = actions.toString();

        System.out.println("Solution: " + actions.toString());
    }

    public static void main(String[] args) {
        try {
            // Load the JSON level
            String filePath = "config/test1.json";
            JSONObject level = readLevel(filePath);

            // Parse the Sokoban grid from "testIn"
            String sokobanGrid = level.getString("testIn");
            String[][] grid = parseGrid(sokobanGrid);

            for (int i = 0; i < grid.length; i++) {
                for (int j = 0; j < grid[0].length; j++) {
                    System.out.print(grid[i][j]);
                }
                System.out.println();
            }

            // Generate the PDDL problem file
            generatePDDL(grid, "sokoban-problem.pddl");

            // Solve the PDDL problem
            Plan solution = solveWithPDDL4J("solution/sokoban.pddl", "solution/sokoban-problem.pddl");

            if (solution != null) {
                System.out.println("Plan found ");
                executePlan(solution.actions());
                editAgent(solutionString);
            } else {
                System.out.println("No solution found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}