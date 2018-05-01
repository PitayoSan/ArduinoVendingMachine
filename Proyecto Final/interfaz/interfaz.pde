import processing.serial.*;

import javax.swing.*;
import java.awt.*;


PImage bckg;
PImage logo;

PImage[] imagenes;
String[] urls = {"lapiz.png", "pluma.png", "pluma_azul.png", "borrador.png", "Splashscreen.png", "Utilex.png"};
char[]  instructions = {'1','2','3','4','5','6','7','8'};

PFont font;

Serial myPort;

int a;
int x1,x2,x3,x4;
int y1,y2,y3,y4;

int saldo = 0;
String val = "";

boolean vendido;
boolean producto;
boolean[] productos;


void setup(){
  imagenes = new PImage[6];
  productos = new boolean[6];
  vendido = producto = false;
  for(int i = 0; i < productos.length; i ++){
    productos[i] = false;
  }
  size(1250,700);
  for(int i = 0; i < imagenes.length; i ++){
    imagenes[i] = loadImage(urls[i]);
  }
  for (int i = 0; i < imagenes.length - 2; i ++){
    imagenes[i].resize(200,200);
  }
  imagenes[4].resize(width,height);
  imagenes[5].resize(100,100);
  font = createFont("Quicksand Regular", 36);
  myPort = new Serial(this, "COM8", 9600);
  myPort.bufferUntil('\n');
  
}

void draw(){
    if(saldo >= 5)
    {
      background(255, 165, 0);
      image(imagenes[5], 20, 20);
      fill(255,255,255,255-a);
      textFont(font);
      text("Saldo: $" + saldo + ".00",1000, 50);
      text("Selecciona un producto",430,100);
      text("¡Todo a 5 pesos!", 450, 200);
      fill(255,255,255,a);
      text("Despachando...",490,70);
      image(imagenes[0],40+x1,300+y1);
      image(imagenes[1],350+x2,300+y2);
      image(imagenes[2],660+x3,300+y3);
      image(imagenes[3],970+x4,300+y4);
      delay(1000);
      if(producto){
        for (int i = 0; i < productos.length; i ++){
          if (productos[i] == true){
            
            myPort.write(instructions[i]);
            
          }
          
        }
        delay(1000);
        resetear();
        background(imagenes[4]);
        myPort.write('1');

      }
     
      
    }
    else
    {
      background(imagenes[4]);
      loop();
    }

}


void serialEvent(Serial s){
  val = s.readStringUntil('\n');
  if(val != null){
    val = trim(val);
    if(val.equals("5")){
      saldo = 5;
    }
    else if(val.equals("10")){
      saldo = 10;
    }
    else{
      saldo = 0;
      producto = false;
    }
  }
}



void resetear(){
   a = x1 = x2 = x3 = x4 = y1 = y2 = y3 = y4 = 0;
   myPort.write('8');
   noLoop();
   
}

void mouseClicked(){
  //lapiz
  if ((mouseX >= 40 && mouseX <= 240) && (mouseY >= 300 && mouseY <= 500)){
    a += 255;
    x1 += 465;
    y2 = y3 = y4 = -615;
    producto = productos[2] = true;
  }
  //pluma negra
  else if((mouseX >= 350 && mouseX <= 550) && (mouseY >= 300 && mouseY <= 500)){ 
    a += 255;
    x2 += 155;
    y1 = y3 = y4 = -615;
    producto = productos[3] = true;
    
  }
  //pluma azul
  else if((mouseX >= 630 && mouseX <= 930) && (mouseY >= 115 && mouseY <= 415)){
    a += 255;
    x3 -= 155;
    y1 = y2 = y4 = -615;  
    producto = productos[4] = true;
  }
  //borrador
  else if((mouseX >= 940 && mouseX <= 1240) && (mouseY >= 115 && mouseY <= 415)){
    a += 255;
    x4 -= 465;
    y1 = y2 = y3 = -615;
    producto = productos[5] = true;
  }  
  
}
