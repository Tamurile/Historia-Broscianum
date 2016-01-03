# Historia-Broscianum
Projekt na KGRz

import processing.video.*;
import qrcodeprocessing.*;

Capture cam; //polecenie przechwytywania kamery
Decoder decoder; //polecenie przechwytywania QR kodu

void setup() {
  size(640, 480);
    
    cam = new Capture(this, 640, 480, 30);
    //Lenovo EasyCamera,size=640x480,fps=30 - to są dane mojej kamery. Użyłem ich powyżej. Możecie swoje zmienić, ale lepiej zostawić tak jak jest
    cam.start();   
    // tutaj kończymy wprowadzanie danych kamery
    
  decoder = new Decoder(this);
    // tutaj uruchamiamy dekoder QR
    
    PImage qrcode = loadImage("qrcode.jpg");
decoder.decodeImage(qrcode);
    // polecenie aby załadować nam obrazek z qr kodem i go zdekodować

  }      

void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  println("Zajebiscie");
}
//zapisany proces dekodowania 


void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  //polecenie dla kamerki żeby wyrzucała nam obraz
}
