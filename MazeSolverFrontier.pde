//Change this variable to see different search styles.
static final int MODE = Frontier.STACK;


/////////////DO NOT EDIT BELOW THIS LINE////////////////////

Maze maze;
int DELAY;
int ROWS;
int COLS;
double DENSITY;
int SQUARESIZE;
int END_ROW = -1;
int END_COL = -1;



void setup() {
  size(800, 800);
  if(MODE == Frontier.QUEUE){
   DELAY = 10; 
  }else{
   DELAY= 1; 
  }
  ROWS = 50;
  COLS = 50;
  noStroke();
  DENSITY = .70;
  maze = new Maze(ROWS, COLS, MODE);
  SQUARESIZE = width/COLS;
  drawSquares(maze);
}



/**Reset the maze with a mouse click.
*/
void mouseClicked() {
  maze = new Maze(ROWS, COLS, MODE );
  drawSquares(maze);
}


void draw() {
  if (!maze.done() && frameCount % DELAY == 0) { //<>//
    maze.tick();
    drawSquares(maze);
  }

  if (maze.done()) {
    //println(END_ROW);
    maze.map[END_ROW][END_COL]=maze.getTicks();
    traceBack(maze, END_ROW, END_COL);
    drawSquares(maze);

    fill(200,200,200,150);
    rect(20,height-80,450,40);
    fill(0);
    textSize(20);
    text(
      "Simulation of "+COLS+" by "+ROWS+" board lasted "+maze.getTicks()+" ticks", 
      20, height - 50);
  }
}

/**Paints the final path after finding a solution.
*/
void traceBack(Maze m, int r, int c) {
  if (r >= 0 && r < ROWS && c >= 0 && c < COLS) {

    int dist = m.map[r][c];
    if (dist > 0) {
      m.map[r][c]= m.PATH;
      int up = nextValue(m, r-1, c, dist-1);
      int down = nextValue(m, r+1, c, dist-1);
      int left = nextValue(m, r, c - 1, dist-1);
      int right = nextValue(m, r, c + 1, dist-1);
      int min = Math.min(up,Math.min(down,Math.min(left,right)));
      if ( up == min ) {
        traceBack(m, r-1, c);
      } else if ( down == min ) {
        traceBack(m, r+1, c);
      } else if ( left == min ) {
        traceBack(m, r, c-1);
      } else if ( right == min ) {
        traceBack(m, r, c+1);
      }
    }
  }
}


/**Used by trackBack to find the minimum next square.
*/
int nextValue(Maze m, int r, int c, int dist) {
  try {
    int value = m.map[r][c];
    if(value >= 0){
     return value; 
    }
  }
  catch ( ArrayIndexOutOfBoundsException e) {

  }
  return Integer.MAX_VALUE;
}


void drawSquares(Maze maze) {
  int[][]map = maze.map;
  for (int r = 0; r < map.length; r++) {
    for (int c = 0; c < map[r].length; c++) {
      if (map[r][c] == maze.WALL) {
        fill(0, 0, 0);
      } else  if (map[r][c] == maze.SPACE) {
        fill(255, 255, 255);
      } else if (map[r][c]  == maze.START) {
        fill(0, 255, 255);
      } else if (map[r][c]  == maze.PATH) {
        fill(0, 0, 255);
      } else if (map[r][c]  == maze.PENDING) {
        fill(155, 155, 0);
      } else {
        fill(255, 255, 0);
      }
      //end by position not value
      if (r == END_ROW && c == END_COL) {
        fill(255, 0, 0);
      }
      rect(c*SQUARESIZE, r*SQUARESIZE, SQUARESIZE, SQUARESIZE);
      fill(0);
      textSize(10);
      text(""+map[r][c], c*SQUARESIZE+5, r*SQUARESIZE+SQUARESIZE/2);

    }
  }
} //<>//
