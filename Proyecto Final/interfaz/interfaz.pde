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


PImage[] imagenes;
String[] urls = {"lapiz.png", "pluma.png", "pluma_azul.png", "borrador.png", "rep.png", "Splashscreen.png", "Utilex.png"};
char[]  instructions = {'1','2','3','4','5','6','7'};

PFont font;

Serial myPort;

int a;
int x1,x2,x3,x4,x5;
int y1,y2,y3,y4,y5;

int saldo = 0;
String val = "";

boolean vendido;
boolean producto;
boolean[] productos;

//Stock final
int stockLapiz = 0;
int stockPlumaNegra = 12;
int stockPlumaAzul = 12;
int stockBorradores = 0;

//Reporte
ArrayList lineas;
String pathSave;

//Fecha
Date ahora;
SimpleDateFormat sdfFecha;
String fecha;

//Tiempo
Calendar calTiempo;
SimpleDateFormat sdfTime;
String tiempo;


void setup(){
  imagenes = new PImage[7];
  productos = new boolean[6];
  vendido = producto = false;
  for(int i = 0; i < productos.length; i ++){
    productos[i] = false;
  }
  size(1250,700);
  for(int i = 0; i < imagenes.length; i ++){
    imagenes[i] = loadImage(urls[i]);
  }
  for (int i = 0; i < imagenes.length - 3; i ++){
    imagenes[i].resize(200,200);
  }
  imagenes[4].resize(150,150);
  imagenes[5].resize(width,height);
  imagenes[6].resize(100,100);
  font = createFont("Quicksand Regular", 36);
  myPort = new Serial(this, "COM8", 9600);
  myPort.bufferUntil('\n');
  
  lineas = new ArrayList();
  ahora = new Date();
  sdfFecha = new SimpleDateFormat("dd-MM-yyyy");
  sdfTime  = new SimpleDateFormat("HH:mm:ss");
  
}

void draw(){
    if(saldo >= 5)
    {
      background(255, 165, 0);
      image(imagenes[6], 20, 20);
      fill(255,255,255,255-a);
      textFont(font);
      text("Saldo: $" + saldo + ".00",1000, 50);
      text("Selecciona un producto",410,100);
      text("¡Todo a 5 pesos!", 460, 200);
      textSize(24);
      if(stockLapiz > 0){
        text(stockLapiz + " disponibles", 80, 550);
      }
      else{
        imagenes[0].filter(GRAY);
        text("no disponible", 80, 550);
        
      }
      if(stockPlumaNegra > 0){
        text(stockPlumaNegra + " disponibles", 380, 550);
      }
      else{
        imagenes[1].filter(GRAY);
        text("no disponible", 380, 550);
        
      }
      if(stockPlumaAzul > 0){
        text(stockPlumaAzul + " disponibles", 690, 550);
      }
      else{
        imagenes[2].filter(GRAY);
        text("no disponible", 690, 550);
        
      }
      if(stockBorradores > 0){
        text(stockBorradores + " disponibles", 1050, 550);
      }
      else{
        imagenes[3].filter(GRAY);
        text("no disponible", 1000, 550);
        
      }
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
        if (saldo == 10){
          myPort.write('7');
          myPort.write('2');
        }
        else{
          myPort.write('1');
        }
        resetear();
        producto = !producto;
        for (int i = 0; i < productos.length; i ++){
          productos[i] = false;
        }
      }

    }
    else
    {
      background(imagenes[5]);
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
   a = x1 = x2 = x3 = x4 = x5 = y1 = y2 = y3 = y4 = 0; 
}



void mouseClicked(){
  if(saldo >= 5){
    //lapiz
    if ((mouseX >= 40 && mouseX <= 240) && (mouseY >= 300 && mouseY <= 500)){
      if (stockLapiz >= 1) {
        stockLapiz -= 1;
        a += 255;
        x1 += 465;
        y2 = y3 = y4 = y5 = -615;
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
        stockPlumaNegra -= 1;
        a += 255;
        x2 += 155;
        y1 = y3 = y4 = y5 = -615;
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
        stockPlumaAzul -= 1;
        a += 255;
        x3 -= 155;
        y1 = y2 = y4 = y5 = -615;  
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
        stockBorradores -= 1;
        a += 255;
        x4 -= 465;
        y1 = y2 = y3 = y5 = -615;
        producto = productos[5] = true;
        
        fecha = sdfFecha.format(ahora);
        calTiempo = Calendar.getInstance();
        tiempo = sdfTime.format(calTiempo.getTime());
        lineas.add(fecha + "," + tiempo + "," + "Borrador" + "," + "$5");
      } else {
        JOptionPane.showMessageDialog(null, "Por el momento, no contamos con stock de Borradores");
      }
    } 
    
    redraw();
  }
  if ((mouseX >= 950 && mouseX <= 1250) && (mouseY >= 500 && mouseY <= 700)) {
    int opcion = JOptionPane.showConfirmDialog(null, "¿Generar reporte?","Reporte de compras",JOptionPane.YES_NO_OPTION);
    if(opcion == 0){
      JFileChooser fc = new JFileChooser();
      try {
        fc.showSaveDialog(fc);
        pathSave = fc.getSelectedFile().getPath();
        creaReporte(pathSave);
      } catch (NullPointerException ex) {
        
      } catch (IOException ex) {
        
      }
    }
  }
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
