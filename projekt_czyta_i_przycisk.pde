import processing.video.*;
import qrcodeprocessing.*;
import de.bezier.guido.*;
MyButton button;
PImage bramawejsciowa;
PImage sala25;
PImage sala28;

Capture video;                                 // instance of the video capture library
String statusMsg = "Czekam na obrazek"; 
String dzialaj="Uruchom";// a string to return messages:

// Decoder object from prdecoder library
Decoder decoder;


void setup() {
 size(640, 480);
 Interactive.make( this ); // start GUIDO
 new MyButton(220, 420, 200, 50, dzialaj); // create an instance of your element
 video = new Capture(this, 640, 480);
 bramawejsciowa = loadImage("bramawejsciowa.png");
 sala25 = loadImage("sala25.jpg");
 sala28 = loadImage("sala28.jpg");
 

  // Create a decoder object
  decoder = new Decoder(this);
  
}

// When the decoder object finishes
// this method will be invoked.
void decoderEvent(Decoder decoder) {
 statusMsg = decoder.getDecodedString();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);

  // Display video
  image(video, 0, 0);
  // Display status
  text(statusMsg, 90, height-14);

 // If we are currently decoding
  if (decoder.decoding()) {
    // Display the image being decoded
    PImage show = decoder.getImage();
    image(show, 0, 0, show.width/4, show.height/4); 
    statusMsg = "Przetwarzam";
    for (int i = 0; i < (frameCount/2) % 10; i++) statusMsg += ".";
 }
}

void keyReleased() {
  // Depending on which key is hit, do different things:
  switch (key) {
  case ' ':        
   // Spacebar takes a picture and tests it:
    // copy it to the PImage savedFrame:
   PImage savedFrame = createImage(video.width, video.height, RGB);
   savedFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
    savedFrame.updatePixels();
    // Decode savedFrame
    decoder.decodeImage(savedFrame);
    break;
  case 't':    // t runs a test on a file
    PImage preservedFrame = loadImage("qr.jpg");
    // Decode file
    decoder.decodeImage(preservedFrame);
    break;
 }
}

public class MyButton
{
    float x,y,width,height;
    String dzialaj;
    boolean on;

    MyButton ( float xx, float yy, float ww, float hh, String dzialaj) 
    {
        x = xx; y = yy; width = ww; height = hh; this.dzialaj=dzialaj;


        Interactive.add( this ); // add this to GUIDO manager, important!
    }

    void mousePressed ()
    {
        // called when the button has been pressed

        on = !on;
        video.start();
        
        
    }

    void draw ()
    {
        // called by GUIDO after PApplet.draw() has finished
        fill( on ? 80 : 140);
        rect( x, y, width, height);
        fill( 0 );
        textSize( 15 );
        textAlign( CENTER,CENTER );
         if ( on) text( "zeskanuj swój kod QR", x+width/2, y+height/2);
        else text( dzialaj, x+width/2, y+height/2);

if (statusMsg.equals("bramawejsciowa")) { 
  image(bramawejsciowa, 0, 0);
}
if (statusMsg.equals("sala25")) { 
  image(sala25, 0, 0);
}
if (statusMsg.equals("sala28")) { 
  image(sala28, 0, 0);
}
    }
}