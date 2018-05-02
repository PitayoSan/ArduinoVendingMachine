import processing.serial.*;

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
Calendar calTiempo;
SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
String tiempo;

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
      delay(2000);
      if(producto){
        for (int i = 0; i < productos.length; i ++){
          if (productos[i] == true){
            myPort.write(instructions[i]); 
          }
        }
        myPort.write('1');
        resetear();
        delay(2000);
        producto = !producto;
        for (int i = 0; i < productos.length; i ++){
          productos[i] = false;
        }
      }

    }
    else
    {
      background(imagenes[4]);
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
}



void mouseClicked(){
  //lapiz
  if ((mouseX >= 40 && mouseX <= 240) && (mouseY >= 300 && mouseY <= 500)){
    if (stockLapiz >= 1) {
      a += 255;
      x1 += 465;
      y2 = y3 = y4 = -615;
      producto = productos[2] = true;
      
      fecha = sdfFecha.format(ahora);
      calTiempo = Calendar.getInstance();
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Lapiz" + "," + "$5");

    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Lapices");
    }
  }
  //pluma negra
  else if((mouseX >= 350 && mouseX <= 550) && (mouseY >= 300 && mouseY <= 500)){ 
    if (stockPlumaNegra >= 1) {
      a += 255;
      x2 += 155;
      y1 = y3 = y4 = -615;
      producto = productos[3] = true;
      
      fecha = sdfFecha.format(ahora);
      calTiempo = Calendar.getInstance();
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Pluma Negra" + "," + "$5");
      
    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Plumas Negras");
    }
    
  }
  //pluma azul
  else if((mouseX >= 630 && mouseX <= 930) && (mouseY >= 300 && mouseY <= 500)){
    if (stockPlumaAzul >= 1) {
      a += 255;
      x3 -= 155;
      y1 = y2 = y4 = -615;  
      producto = productos[4] = true;
      
      fecha = sdfFecha.format(ahora);
      calTiempo = Calendar.getInstance();
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Pluma Azul" + "," + "$5");
      
    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Plumas Azules");
    }
  }
  //borrador
  else if((mouseX >= 940 && mouseX <= 1240) && (mouseY >= 300 && mouseY <= 500)){
    if (stockBorradores >= 1) {
      a += 255;
      x4 -= 465;
      y1 = y2 = y3 = -615;
      producto = productos[5] = true;
      
      fecha = sdfFecha.format(ahora);
      calTiempo = Calendar.getInstance();
      tiempo = sdfTime.format(calTiempo.getTime());
      lineas.add(fecha + "," + tiempo + "," + "Borrador" + "," + "$5");
    } else {
      JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Borradores");
    }
  } else if ((mouseX >= 950 && mouseX <= 1250) && (mouseY >= 500 && mouseY <= 700)) {
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
