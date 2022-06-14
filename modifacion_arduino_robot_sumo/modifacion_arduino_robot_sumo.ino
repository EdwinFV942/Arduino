#include <SoftwareSerial.h>

SoftwareSerial miBT(0, 1);   //Crea conexion al bluetooth - PIN 2 a TX y PIN 3 a RX
char DATO = 0;


//Motores Traseros

//PINES DEL  MODULO A
int ENAt = 2;
int IN1t = 3;
int IN2t = 4;

//PINES DEL  MODULO B

int ENBt = 5;
int IN3t = 6;
int IN4t = 7;

//Motores Delanteros

//PINES DEL  MODULO A
int ENA = 8;
int IN1 = 9;
int IN2 = 10;

//PINES DEL  MODULO B

int ENB = 11;
int IN3 = 12;
int IN4 = 13;


void setup() {
  Serial.begin(9600);
  miBT.begin(9600);

  //MOTORES DERECHOS DELANTEROS DEFINICION EN PINMODE
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);
  //MOTORES IZQUIERDA DELANTEROS DEFINICION EN PINMODE
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(ENB, OUTPUT);
  //MOTORES DERECHOS TRASEROS DEFINICION EN PINMODE
  pinMode(IN1t, OUTPUT);
  pinMode(IN2t, OUTPUT);
  pinMode(ENAt, OUTPUT);
  //MOTORES IZQUIERDOS TRASEROS DEFINICION EN PINMODE
  pinMode(IN3t, OUTPUT);
  pinMode(IN4t, OUTPUT);
  pinMode(ENBt, OUTPUT);

}

void loop() {
int VELOCIDAD = 100;
  if (miBT.available()) {
    DATO = miBT.read();
    Serial.println(DATO);
    if (DATO == 'w') {   //HACIA ADELANTE
      Serial.print("ROBOT AVANZANDO");
      //MOTOR DERECHO TRASEROS
      digitalWrite(IN1t, LOW);
      digitalWrite(IN2t, !digitalRead(IN2t));
      digitalWrite(ENAt, VELOCIDAD);
      //MOTOR IZQUIERDO TRASEROS
      digitalWrite(IN3t, LOW);
      digitalWrite(IN4t, !digitalRead(IN4t));
      digitalWrite(ENBt, VELOCIDAD);

      //MOTORES DELANTEROS
      digitalWrite(IN1, !digitalRead(IN1));
      digitalWrite(IN2, LOW);
      digitalWrite(ENA, VELOCIDAD);
      //MOTOR IZQUIERDO DELANTERO
      digitalWrite(IN3, !digitalRead(IN3));
      digitalWrite(IN4, LOW);
      digitalWrite(ENB, VELOCIDAD);

    } else if (DATO == 'a') {               //HACIA LA IZQUIERDA
      Serial.print("ROBOT GIRANDO A LA IZQUIERDA");
      //motor a
      digitalWrite(IN1t, LOW);
      digitalWrite(IN2t, LOW);
      digitalWrite(ENAt, LOW);
      //MOTOR IZQUIERDO TRASEROS
      digitalWrite(IN3t, LOW);
      digitalWrite(IN4t, !digitalRead(IN4t));
      digitalWrite(ENBt, 255);
      
      digitalWrite(IN1, LOW);
      digitalWrite(IN2, !digitalRead(IN2));
      digitalWrite(ENA, 255);
      digitalWrite(IN3, LOW);
      digitalWrite(IN4, !digitalRead(IN4));
      digitalWrite(ENB, 255);
     
    } else if (DATO == 'd') {               //HACIA LA DERECHA
      Serial.print("ROBOT GIRANDO A LA DERECHA");
      digitalWrite(IN1t, !digitalRead(IN1t));
      digitalWrite(IN2t, LOW);
      digitalWrite(ENAt, 255);
      //MOTOR IZQUIERDO TRASEROS
      digitalWrite(IN3t, LOW);
      digitalWrite(IN4t, LOW);
      digitalWrite(ENBt, LOW);
      
      digitalWrite(IN1, LOW);
      digitalWrite(IN2, !digitalRead(IN2));
      digitalWrite(ENA, 255);
      digitalWrite(IN3, LOW);
      digitalWrite(IN4, !digitalRead(IN4));
      digitalWrite(ENB, VELOCIDAD);
    } else if (DATO == 's') {                 //HACIA ATRAS
      Serial.print("ROBOT RETROSEDIENDO");
      //MOTOR DERECHO TRASEROS
      digitalWrite(IN1t, !digitalRead(IN1t));
      digitalWrite(IN2t, LOW);
      digitalWrite(ENAt, VELOCIDAD);
      //MOTOR IZQUIERDO TRASEROS
      digitalWrite(IN3t, !digitalRead(IN3t));
      digitalWrite(IN4t, LOW);
      digitalWrite(ENBt, VELOCIDAD);

      //MOTORES DELANTEROS
      //MOTOR DERECHO DELANTERO
      digitalWrite(IN1, LOW);
      digitalWrite(IN2, !digitalRead(IN2));
      digitalWrite(ENA, VELOCIDAD);
      //MOTOR IZQUIERDO DELANTERO
      digitalWrite(IN3, LOW);
      digitalWrite(IN4, !digitalRead(IN4));
      digitalWrite(ENB, VELOCIDAD);
    } else if (DATO == 'N') {                  //Stop - Pare, Carrito detenido
      Serial.print("ROBOT DETENIDO");
      //MOTOR DERECHO TRASEROS
      digitalWrite(IN1t, LOW);
      digitalWrite(IN2t, LOW);
      digitalWrite(ENAt, LOW);
      //MOTOR IZQUIERDO TRASEROS
      digitalWrite(IN3t, LOW);
      digitalWrite(IN4t, LOW);
      digitalWrite(ENBt, LOW);

      //MOTORES DELANTEROS
      //MOTOR DERECHO DELANTERO
      digitalWrite(IN1, LOW);
      digitalWrite(IN2, LOW);
      digitalWrite(ENA, LOW);
      //MOTOR IZQUIERDO DELANTERO
      digitalWrite(IN3, LOW);
      digitalWrite(IN4, LOW);
      digitalWrite(ENB, LOW);
    }
  }
}
