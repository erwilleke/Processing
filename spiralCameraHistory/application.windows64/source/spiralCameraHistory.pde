
import processing.video.*;
int boxSize = 150;
Capture video;

void setup()
{
  size( 700, 700 );
  background(0,0,0);
  video = new Capture(this, 160, 120);
  video.start(); 
}

void draw()
{
  if( video.available() )
  {
    background(0,0,0);
    video.read();
    video.loadPixels();
 
    int steps = 20;
    int maxbright = 200;
    for( int i = 0; i < steps; i++ )
    {
      int cornerRound = 2 * i;
      int cornerX = mouseX * i / steps;
      int cornerY = mouseY * i / steps;
      
      int rgbGray = maxbright - maxbright * i / steps;
      fill( rgbGray, rgbGray, rgbGray, rgbGray );
      image( video, cornerX, cornerY, boxSize, boxSize );
      rect( cornerX, cornerY, boxSize, boxSize);
 
    }  
  }  
  
}
