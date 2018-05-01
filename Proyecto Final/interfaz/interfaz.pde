import processing.serial.*;

import cc.arduino.*;
import org.firmata.*;

import javax.swing.*;
import java.awt.*;
import java.io.*;

import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Calendar;
import java.util.ArrayList;

import java.io.IOException;

PImage bckg;
PImage logo;

PImage[] imagenes;
String[] urls = {"lapiz.png", "pluma.png", "pluma_azul.png", "borrador.png", "Splashscreen.png", "Utilex.png"};

PFont font;

Serial myPort;
char[] instructions = {'1','2','3'};
byte coin;


float a;
float x1,x2,x3,x4;
float y1,y2,y3,y4;
float xP, yP;

int saldo = 5;
String val = "";

//Stock
int stockLapiz = 0;
int stockPlumaNegra = 15;
int stockPlumaAzul = 15;
int stockBorradores = 0;

//Reporte
ArrayList lineas = new ArrayList();
String pathSave;

//Fecha
Date ahora = new Date();
SimpleDateFormat sdfFecha = new SimpleDateFormat("dd-MM-yyyy");
String fecha;

//Tiempo
Calendar calTiempo = Calendar.getInstance();
SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
String tiempo;



void setup(){
  imagenes = new PImage[6];
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
  //myPort = new Serial(this, "COM8", 9600);
  //myPort.bufferUntil('\n');
  
}

void draw(){
    if(saldo >= 5)
    {
      background(255, 165, 0);
      image(imagenes[5], 20, 20);
      fill(255,255,255,255-a);
      textFont(font);
      text("Selecciona un producto",430,100);
      text("¡Todo a 5 pesos!", 450, 200);
      fill(255,255,255,a);
      text("Despachando...",490,70);
      image(imagenes[0],40+x1,300+y1);
      image(imagenes[1],350+x2,300+y2);
      image(imagenes[2],660+x3,300+y3);
      image(imagenes[3],970+x4,300+y4);
      if(mousePressed){
        delay(3000);

        //myPort.write('3');
      }
    }
    else
    {
      background(imagenes[4]);
    }
  

  /*
  println("Saldo:"+saldo);
  
  myPort.write(instructions[0]);
  myPort.write(instructions[1]);
  */

}
/*
void serialEvent(Serial s){
  val = s.readStringUntil('\n');
  if(val != null){
    val = trim(val);
    if(val.equals("moneda")){
      saldo = 5;
      println("Saldo: " + saldo);
    }
    else{
      saldo = 0;
    }
  }
}
*/


void mousePressed() {
  //lapiz
  if ((mouseX >= 10 && mouseX <= 310) && (mouseY >= 115 && mouseY <= 415)){
    if (stockLapiz >= 1) {
      a += 255;
      x1 += 465;
       y1 -= 100;
      y2 = y3 = y4 = -615;
      
      fecha = sdfFecha.format(ahora);
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Lapiz" + "," + "$5");

    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Lapices");
    }
    
  }
  //Pluma Negra
  else if((mouseX >= 320 && mouseX <= 620) && (mouseY >= 115 && mouseY <= 415)){ 
    if (stockPlumaNegra >= 1) {
      a += 255;
      x2 += 155;
      y1 = y3 = y4 = -615;
      
      fecha = sdfFecha.format(ahora);
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Pluma Negra" + "," + "$5");
      
    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Plumas Negras");
    }
   
  }
  //Pluma Azul
  else if((mouseX >= 630 && mouseX <= 930) && (mouseY >= 115 && mouseY <= 415)){
    if (stockPlumaAzul >= 1) {
      a += 255;
      x3 -= 155;
      y1 = y2 = y4 = -615; 
      
      fecha = sdfFecha.format(ahora);
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Pluma Azul" + "," + "$5");
      
    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Plumas Azules");
    }
         
  }
  //Borradores
  else if((mouseX >= 940 && mouseX <= 1240) && (mouseY >= 115 && mouseY <= 415)){
    if (stockBorradores >= 1) {
      a += 255;
      x4 -= 465;
      y4 -= 100;
      y1 = y2 = y3 = -615;  
    
      fecha = sdfFecha.format(ahora);
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Borrador" + "," + "$5");
      
    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Borradores");
    }
        
  }
  else if ((mouseX >= 950 && mouseX <= 1250) && (mouseY >= 500 && mouseY <= 700)) {
    JFileChooser fc = new JFileChooser();
    try {
      fc.showSaveDialog(fc);
      pathSave = fc.getSelectedFile().getPath();
      creaReporte(pathSave);
    } catch (NullPointerException ex) {
      
    } catch (IOException ex) {
      
    }
  }
  
  redraw();
}


  

void creaReporte(String pathSave) throws IOException {
  PrintWriter pw = new PrintWriter(new FileWriter(pathSave + ".csv"));
  pw.println("Fecha, Hora, Articulo, Costo");
  for (int i = 0; i < lineas.size(); i++) {
    if (lineas.get(i) != "") {
      pw.println(lineas.get(i));
    }
  }
  JOptionPane.showMessageDialog(null, "El reporte se ha creado con éxito");
  pw.close();
}
