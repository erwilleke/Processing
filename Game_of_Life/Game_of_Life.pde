
// Adjustable constants
int rows = 60;
int columns = 60;

boolean sketchFullScreen() {
  return true;
}

// Global variables
float worldDim = 0;

float cellHeight = 0;
float cellWidth = 0;

// cells[xPosition][yPosition]
boolean cells[][] = new boolean[columns][rows];


void setup()
{
  size(displayWidth, displayHeight);
  frameRate( 15 );

  rectMode( CENTER );
  
  // Give us a square world full diagonal span 
  worldDim = dist( 0, 0, displayWidth, displayHeight );
  
  cellHeight = worldDim / (float) rows;
  cellWidth = worldDim / (float) columns;  
    
  seedWorldCells();
}

float worldAngle = 0;

void draw()
{  
  pushMatrix();
 
  applyCameraSpin();
  drawLivingCells();
  advanceWorldState();

  popMatrix();
}

void applyCameraSpin()
{  
  float xTranslate = (width - worldDim ) / 2;
  float yTranslate = (height - worldDim ) / 2;

  background( 155 );
  translate(xTranslate, yTranslate);
  rotate(worldAngle);  
  translate(-xTranslate, -yTranslate);
  worldAngle += PI / 120;
}

void keyPressed() 
{
  if (key=='r' || key == 'R') 
  {
    seedWorldCells();
  }
  
}

void seedWorldCells()
{
    for( int x = 0; x < cells.length; x++ )
      for( int y = 0; y < cells[x].length; y++ )
      {
         cells[x][y] = random(-1,1) > 0; 
      }
}

void drawLivingCells()
{
    for( int x = 0; x < cells.length; x++ )
      for( int y = 0; y < cells[x].length; y++ )
      {
        if( cells[x][y] == true )
        {
          pushMatrix();
          translate( x * cellWidth, y * cellHeight );
          rotate( random( -PI, PI ) );
          fill( 255);
          rect( 3, 3, cellWidth - 6, cellHeight - 6 );
          popMatrix();
        }
      }  
}

void advanceWorldState()
{
    ArrayList< int[] > kills = new ArrayList< int[] >();
    ArrayList< int[] > births = new ArrayList< int[] >();
  
    for( int x = 0; x < cells.length; x++ )
      for( int y = 0; y < cells[x].length; y++ )
      {
        int livingNeighbors = countNearbyLife( x, y );
        if( (livingNeighbors < 2 || livingNeighbors > 3) && cells[x][y]  ) kills.add( new int[] {x, y} );
        if( livingNeighbors == 3 && !cells[x][y] ) births.add( new int[] {x, y} );
      }
      
    for( int i = 0; i < kills.size();  i++ ) {int[] addy = kills.get(i);  cells[addy[0]][addy[1]] = false; }     
    for( int i = 0; i < births.size(); i++ ) {int[] addy = births.get(i); cells[addy[0]][addy[1]] = true; } 
}

int countNearbyLife( int x, int y )
{
  int lives = 0;
  if( left( x, y ) ) lives++;
  if( right(x, y ) ) lives++;
  if( up(x, y ) ) lives++;
  if( down(x, y ) ) lives++;
  if( upleft(x, y ) ) lives++;
  if( upright(x, y ) ) lives++;
  if( downleft(x, y ) ) lives++;
  if( downright(x, y ) ) lives++;
  return lives;
}

boolean left(int x, int y ){ if( x == 0 ) return false; return cells[x-1][y];}
boolean right(int x, int y ){ if( x == columns - 1 ) return false; return cells[x+1][y];}
boolean up( int x, int y ) { if( y == 0 ) return false; return cells[x][y-1];}
boolean down( int x, int y ){ if( y == rows - 1 ) return false; return cells[x][y+1];}

boolean upleft( int x, int y) { if( x == 0 || y == 0 ) return false; return cells[x-1][y-1];}
boolean upright( int x, int y) {if( x == columns - 1 || y == 0 ) return false; return cells[x+1][y-1];}
boolean downleft( int x, int y) {if( x == 0 || y == rows - 1 ) return false; return cells[x-1][y+1];}
boolean downright( int x, int y) {if( x == columns - 1 || y == rows - 1 ) return false; return cells[x+1][y+1];}


