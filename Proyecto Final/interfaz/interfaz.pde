import cc.arduino.*;
import org.firmata.*;
import javax.swing.*;
import java.awt.*;

PImage img1;
PImage img2;
PImage img3;
PImage img4;

int h1;

int saldo;

int[] monedas = {5, 10};

int[] articulosCarrito = new int[4];
//1. Lapiz, 2. Pluma, 3. Borrador, 4. Sacapuntas
int otraCompra = JOptionPane.YES_NO_OPTION;

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
  if (saldo == monedas[0] || saldo == monedas[1]) {
      fill(255,255,255);
      textSize(36+h1);
      text("Selecciona un producto",430,70);
      image(img1,10,115);
      image(img2,320,115);
      image(img3,630,115);
      image(img4,940,115);
  }
  

}

void loop(){
  if (sensorHerradura1 == HIGH) {
    saldo += 5;
  } else if (sensorHerradura2 == HIGH) {
    saldo += 10;
  }
  
  if (saldo == monedas[0] || saldo == monedas[1]) {
    javax.swing.JOptionPane.showMessageDialog(null, "Moneda ingresada. Saldo: " + saldo);
  }
}


void mousePressed(){
  if (saldo == monedas[0] || saldo == monedas[1]) {
    //lapiz
    if ((mouseX >= 10 && mouseX <= 310) && (mouseY >= 115 && mouseY <= 415)){
      img2.filter(BLUR,10);
      img3.filter(BLUR,10);
      img4.filter(BLUR,10);
      
      articulosCarrito[0] ++;
    }
    //pluma
    else if((mouseX >= 320 && mouseX <= 620) && (mouseY >= 115 && mouseY <= 415)){ 
      img1.filter(BLUR,10);
      img3.filter(BLUR,10);
      img4.filter(BLUR,10);
      
      articulosCarrito[1] ++;
    }
    //borrador
    else if((mouseX >= 630 && mouseX <= 930) && (mouseY >= 115 && mouseY <= 415)){
      img1.filter(BLUR,10);
      img2.filter(BLUR,10);
      img4.filter(BLUR,10);
      
      articulosCarrito[2] ++;
    }
    //sacapuntas
    else if((mouseX >= 940 && mouseX <= 1240) && (mouseY >= 115 && mouseY <= 415)){
      img1.filter(BLUR,10);
      img2.filter(BLUR,10);
      img3.filter(BLUR,10);
      
      articulosCarrito[3] ++;
    }
    
    redraw();
    saldo -= 5;
      
    JOptionPane.showConfirmDialog(null, "Desea realizar otra compra?", "Carrito", otraCompra);
    if (otraCompra == JOptionPane.NO_OPTION) {
      if (saldo == monedas[0]) {
        //Ingresar movimiento del servo del cambio aqui
      } else if (saldo == monedas[1]) {
        //Ingresar movimiento del servo del cambio aqui
      }
      saldo = 0;
    }    
    
    
    delay(2000);
    exit();
  }
}
