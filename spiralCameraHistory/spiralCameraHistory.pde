
import processing.video.*;
int boxSize = 150;
Capture video;

Drifter x1Drifter = new Drifter();
Drifter y1Drifter = new Drifter();
Drifter x2Drifter = new Drifter();
Drifter y2Drifter = new Drifter();

boolean sketchFullScreen()
{
  return true;  
}

void setup()
{
  size( displayWidth, displayHeight );
  background(0,0,0);
  video = new Capture(this, 160, 120);
  video.start(); 
}

void draw()
{
/*    noFill();
    stroke(255);
    
    bezier( 0,                  0, 
            mouseX / 3 + x1Drifter.spot(),     mouseY / 3 + y1Drifter.spot(), 
            mouseX * 2 / 3 + x2Drifter.spot(), mouseY * 2 / 3 + y2Drifter.spot(), 
            mouseX,                            mouseY);
*/

  if( video.available() )
  {
    background(0,0,0);
    video.read();
    video.loadPixels();
 
    int steps = 20;
    int maxbright = 200;
    for( int i = 0; i < steps; i++ )
    {      
      float cornerX = bezierPoint( 0, 
          mouseX / 3 + x1Drifter.drift(), mouseX * 2 / 3 + x2Drifter.drift(), mouseX, i / float(steps) );
      float cornerY = bezierPoint( 0, 
          mouseY / 3 + y1Drifter.drift(), mouseY * 2 / 3 + y2Drifter.drift(), mouseY, i / float(steps) );      
      
      int rgbGray = maxbright - maxbright * i / steps;
      fill( rgbGray, rgbGray, rgbGray, rgbGray );
      image( video, cornerX, cornerY, boxSize, boxSize );
      rect( cornerX, cornerY, boxSize, boxSize);
    }
  }  
}

class Drifter
{
  int driftAmplitude = 1;
  
  int tipPoint = 200;
  int maxDrift = 250;
  
  boolean isTrendingUp = false;
  float lastDrift = 0.0;
  
  float drift()
  {
    float newDrift = lastDrift + driftAmplitude * centralRand();
    lastDrift = newDrift;
    return newDrift;
  }
    
  float spot()
  {
    return lastDrift; 
  }
  
  float centralRand()
  {
    if( lastDrift > tipPoint ) {isTrendingUp = false; } 
    if( lastDrift < -tipPoint ) {isTrendingUp = true; }
    
    if( isTrendingUp )
    {
      return random( -0.5, 1.0 );
    }
    else
    {
      return random( -1.0, 0.5 );
    }
  }
  
}

