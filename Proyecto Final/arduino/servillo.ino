#include <Servo.h>

char val;

Servo servoMotor1;      //monedas de 5
Servo servoMotor2;      //monedas de 10
Servo servoMotor3;      //pluma negra
Servo servoMotor4;      //pluma azul
int pinsensor1 = 7;     //sensor monedas de 5
int pinsensor2 = 8;     //sensor monedas de 10

boolean valorSensor1, valorSensor2;

void setup() {
  Serial.begin(9600);
  pinMode(pinsensor1, INPUT);
  pinMode(pinsensor2, INPUT);
  servoMotor1.attach(9);
  servoMotor2.attach(10);
  servoMotor3.attach(12);
  servoMotor4.attach(13);

}

void loop() {
  valorSensor1 = digitalRead(pinsensor1);
  valorSensor2 = digitalRead(pinsensor2);
  if (valorSensor1 == 0 || valorSensor2 == 0) {
    Serial.println("moneda");
    if (Serial.available() > 0){
      val = Serial.read();
      if (val == '1'){
        servoMotor3.write(0);
        delay(500);
        servoMotor3.write(180);
        delay(500);  
      }
      delay(100);
      if (val == '2'){
        servoMotor4.write(0);
        delay(500);
        servoMotor4.write(180);
        delay(500);   
      }
      delay(100);
      /*
       * if() servo para cambio y el if (valorsensor1)
       */
      if(val == '3'){
        if (valorSensor1 == 0){
            servoMotor1.write(45);
            delay(500);
            servoMotor1.write(140);
            delay(500);
             
        }   
      }
    } 
  }
  else {
    Serial.println("no moneda");
  }
  
}
 










