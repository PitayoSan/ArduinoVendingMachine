import processing.serial.*;
import javax.swing.JOptionPane;
import javax.swing.JFrame;

Serial myPort;


PImage img1;
PImage img2;
PImage img3;
PImage img4;

char obj;

float a;
float x1,x2,x3,x4;
float y1,y2,y3,y4;

double saldo = 5.00;




void setup(){
  size(1250,600);
  
  //println(Arduino.list());
  //arduino = new Arduino(this, Arduino.list()[0], 57600);
  //arduino.pinMode(2, 5);
  //JOptionPane.showMessageDialog(null,"Saldo: " + saldo);
  img1 = loadImage("LapizChido.jpg");
  img2 = loadImage("PlumaChida.jpg");
  img3 = loadImage("BorradorChido.jpg");
  img4 = loadImage("sacapuntasChido.jpg");
  
  myPort = new Serial(this, "COM3", 9600);
}

void draw(){
  background(0);
  fill(255,255,255,255-a);
  textSize(36);
  text("Selecciona un producto",430,70);
  fill(255,255,255,a);
  text("Despachando...",490,70);
  image(img1,10+x1,115+y1);
  image(img2,320+x2,115+y2);
  image(img3,630+x3,115+y3);
  image(img4,940+x4,115+y4);
  myPort.write('1');

  
  
}



void mousePressed(){
  //lapiz
  if ((mouseX >= 10 && mouseX <= 310) && (mouseY >= 115 && mouseY <= 415)){
    if (saldo >= 5.00){
      saldo -= 5;
      a += 255;
      x1 += 465;
      y2 = y3 = y4 = -415;
      //codigo arduino
      redraw();
      //JOptionPane.showMessageDialog(null,"ProductoVendido");
      //codigo para cambio $$
      //exit()
      
    }
    else{
      JOptionPane.showMessageDialog(null, "No hay suficiente saldo");
      exit();
    }
    
  }
  //pluma
  else if((mouseX >= 320 && mouseX <= 620) && (mouseY >= 115 && mouseY <= 415)){ 
    if (saldo >= 5.00){
      saldo -= 5;
      a += 255;
      x2 += 155;
      y1 = y3 = y4 = -415;
      redraw();
      //codigo arduino
      //JOptionPane.showMessageDialog(null,"ProductoVendido");
      //codigo para cambio $$
      //exit()
      
    }
    else{
      JOptionPane.showMessageDialog(null, "No hay suficiente saldo");
      exit();
    }
  }
  //borrador
  else if((mouseX >= 630 && mouseX <= 930) && (mouseY >= 115 && mouseY <= 415)){
    if (saldo >= 5.00){
      saldo -= 5;
      a += 255;
      x3 -= 155;
      y1 = y2 = y4 = -415;
      redraw();
      //codigo arduino
      //JOptionPane.showMessageDialog(null,"ProductoVendido");
      //codigo para cambio $$
      //exit()
      
    }
    else{
      JOptionPane.showMessageDialog(null, "No hay suficiente saldo");
      exit();
    }
  }
  //sacapuntas
  else if((mouseX >= 940 && mouseX <= 1240) && (mouseY >= 115 && mouseY <= 415)){
     if (saldo >= 5.00){
      saldo -= 5;
      a += 255;
      x4 -= 465;
      y1 = y2 = y3 = -415;
      redraw();
      //codigo arduino
      //JOptionPane.showMessageDialog(null,"ProductoVendido");
      //codigo para cambio $$
      //exit()
      
    }
    else{
      JOptionPane.showMessageDialog(null, "No hay suficiente saldo");
      exit();
    }
  }
  
}
