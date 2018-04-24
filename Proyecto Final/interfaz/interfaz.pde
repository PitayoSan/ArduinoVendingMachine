import cc.arduino.*;
import org.firmata.*;

PImage img1;
PImage img2;
PImage img3;
PImage img4;

int h1;

boolean visible1;
boolean visible2;
boolean visible3;
boolean visible4;



void setup(){
  //Arduino ar = new Arduino(this,"COM9",56700);
  background(0);
  h1 = 0;
  size(1250,600);
  img1 = loadImage("LapizChido.jpg");
  img2 = loadImage("PlumaChida.jpg");
  img3 = loadImage("BorradorChido.jpg");
  img4 = loadImage("sacapuntasChido.jpg");
  noLoop();
}

void draw(){
  fill(255,255,255);
  textSize(36+h1);
  text("Selecciona un producto",430,70);
  image(img1,10,115);
  image(img2,320,115);
  image(img3,630,115);
  image(img4,940,115);
}

void loop(){
  
}


void mousePressed(){
  //lapiz
  if ((mouseX >= 10 && mouseX <= 310) && (mouseY >= 115 && mouseY <= 415)){
    img2.filter(BLUR,10);
    img3.filter(BLUR,10);
    img4.filter(BLUR,10);
    
    redraw();
    
  }
  //pluma
  else if((mouseX >= 320 && mouseX <= 620) && (mouseY >= 115 && mouseY <= 415)){ 
  }
  //borrador
  else if((mouseX >= 630 && mouseX <= 930) && (mouseY >= 115 && mouseY <= 415)){
  }
  //sacapuntas
  else if((mouseX >= 940 && mouseX <= 1240) && (mouseY >= 115 && mouseY <= 415)){
  }
  
  delay(2000);
  exit();
}
