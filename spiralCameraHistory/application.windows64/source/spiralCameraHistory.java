import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class spiralCameraHistory extends PApplet {



int boxSize = 150;
Capture video;

public void setup()
{
  size( 700, 700 );
  background(0,0,0);
  video = new Capture(this, 160, 120);
  video.start(); 
}

public void draw()
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "spiralCameraHistory" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
