import java.util.*;
public class Maze {
  private int[][]map;
  private int ticks;
  private static final int SPACE = -1;
  private static final int WALL = -2;
  private static final int START = 0;
  private static final int END = -3;
  private static final int PATH = -4;
  private static final int PENDING = -5;
  private Frontier frontier;

  //COMPLETE THE STACK/HEAP version of tick.
  
  /**Tick will process 1 or all nodes from the frontier, and for each: spread to neighboring nodes.
  */
  public void tick() {
    if (!done()) {
      if (MODE==Frontier.QUEUE) {
        int size = frontier.size();
        while (frontier.size() > 0 && size > 0) {
          Location place = frontier.remove();
          int r = place.row;
          int c = place.col;
          spread(r, c, ticks);
          size-=1;
        }
        
      } else if ((MODE==Frontier.STACK || MODE==Frontier.HEAP) && frontier.size() > 0) {
        /*Stack/Heap version only processes ONE node per tick. This is easier than the QUEUE version*/
        if (frontier.size()>0){
          Location place=frontier.remove();
          int r=place.row;
          int c=place.col;
          spread(r,c,ticks);
 
        }
        
      }
      ticks++;
    }
  }


  public boolean done() {
    return frontier.size() == 0;
  }

  //checks for the END location
  public boolean checkEnd(int row, int col) {
    try {
      if (map[row][col]==END) {
        frontier.clear();
        return true;
      }
    }
    catch(ArrayIndexOutOfBoundsException e) {
    };
    return false;
  }

  public int distToGoal(int row, int col) {
    return Math.abs(row - END_ROW) + Math.abs(col - END_COL);
  }

  public void spread(int row, int col, int ticks) {
    map[row][col]=ticks;
    fill(100, 100, 100);
    rect(col*SQUARESIZE, row*SQUARESIZE, SQUARESIZE, SQUARESIZE);
    if (
      checkEnd(row+1, col)||
      checkEnd(row-1, col)||
      checkEnd(row, col+1)||
      checkEnd(row, col-1)) {
      println("DONE!");
    } else {


      if (row > 0) {
        if (map[row-1][col]==SPACE) {
          float d = distToGoal(row-1, col);
          frontier.add(new Location(row-1, col, d));
          map[row-1][col]=PENDING;
        }
      }
      if (row < map.length-1) {
        if (map[row+1][col]==SPACE) {
          float d = distToGoal(row+1, col);
          frontier.add(new Location(row+1, col, d));
          map[row+1][col]=PENDING;
        }
      }
      if (col > 0) {
        if (map[row][col-1]==SPACE) {
          float d = distToGoal(row, col-1);
          frontier.add(new Location(row, col-1, d));
          map[row][col-1]=PENDING;
        }
      }
      if (col < map[0].length-1) {
        if (map[row][col+1]==SPACE) {
          float d = distToGoal(row, col+1);
          frontier.add(new Location(row, col+1, d));
          map[row][col+1]=PENDING;
        }
      }
    }
  }



  public Maze(int rows, int cols, int mode) {
    frontier = new Frontier(mode);
    map = new int[rows][cols];
    for (int i=0;i<map.length;i++){
      for (int j=0;j<map[0].length;j++){
        map[i][j]=WALL;
      }
    }
    carve(map,1,1);
    start();
    end();
  }

  public void start() {
    for (int i = map.length/2 ; i >= 0  ; i--) {
      if (map[i][1]==SPACE) {
        map[i][1]=START;

        frontier.add(new Location(i, 1));
        return;
      }
    }
  }
  public void end() {
    for (int i = map.length/2 ; i >= 0  ; i--) {
      if (map[i][COLS-2]==SPACE) {
        map[i][COLS-2]=END;
        END_ROW=i;
        END_COL=COLS-2;
        return;
      }
    }
  }

  public int getTicks() {
    return ticks;
  }
  public  boolean canCarve(int[][] maze,int row, int col){
    if (row <=0 || col<=0 ||row >= maze.length-1 ||col>=maze[0].length-1){
      return false;
    }
    if (maze[row][col]==SPACE){
      return false;
    }
    int count=0;
    int up=maze[row-1][col];
    int down=maze[row+1][col];
    int right=maze[row][col+1];
    int left=maze[row][col-1];
    if (up==SPACE){
      count++;
    }
    if (down==SPACE){
      count++;
    }
    if (right==SPACE){
      count++;
    }
    if (left==SPACE){
      count++;
    }
    if (count<2 && maze[row][col]==WALL){
      return true;
    }
    return false;

  }
  public void carve(int[][] maze, int row, int col){
    if (canCarve(maze,row,col)){
      maze[row][col]=SPACE;
      ArrayList<String> directions= new ArrayList<String>(4);
      directions.add ("up");
      directions.add("right");
      directions.add("down");
      directions.add("left");
      String direction="";
      while(directions.size()>0){
        int index= (int)(Math.random()*directions.size());
        direction=directions.get(index);
        directions.remove(direction);
        if (direction.equals("up")){
          carve(maze,row-1,col);
        }
        if (direction.equals("down")){
          carve(maze,row+1,col);
        }
        if (direction.equals("right")){
          carve(maze,row,col+1);
        }
        if (direction.equals("left")){
          carve(maze,row,col-1);
        }
      }
  }
  // add S and E
}
}
