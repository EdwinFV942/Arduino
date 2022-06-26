
// ======> Librerias <======
#include <SPI.h>   //Importamos librería comunicación SPI
#include <Ethernet.h>    //Importamos librería Ethernet
//#include <Wire.h>  // Importamos librería para detectición del luxometro (Comunicación I2C) 

// ======> Configuración básica del arduino <====== 
//String numSerieArduino= "qwerty1234";    // Numero de indentificación del Arduino  *Consulta en el sistema el numero de serie del mismo. 
//String numSeriePir="1234567890";   // Numero de indentificación del módulo PIR  *Consulta en el sistema el numero de serie del mismo. 
//String numSerieRelay="0987654321";    // Numero de indentificación del módulo RELAY  *Consulta en el sistema el numero de serie del mismo. 
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };    //Ponemos la dirección MAC de la Ethernet Shield que está con una etiqueta debajo la placa
IPAddress ip( 192, 168, 214, 5);   //Asingamos la IP al Arduino
int luxometro = 0x23; // i2c, Dirección del Luxómetro.
int ciclos=0; // Numero de ciclos que da todo el software para determinar el tiempo en el que el Luxometro realizará un escaneo.  
int countoff38=0;
int countoff39=0;
int contAct=0;
// ======> Configuración de variables y valores para la programación del Arduino <======
IPAddress web_server(192, 168, 214, 20);  //Asignamos la IP del servidor de base de datos
EthernetServer server(80); //Creamos un servidor Web con el puerto 80 que es el puerto HTTP por defecto
byte buff[2]; // matriz que guarda en buffer los datos recopilados del luxómetro para determinar el calculo. 
String estado="OFF";   //Estado inicial de la iluminaria "OFF"
int web1[2]={0,0};  //Variable creada para determinar si el relay esta siendo controlado remotamente
int web2[2]={0,0};  //Variable creada para determinar si el relay esta siendo controlado remotamente
// ======> Pines Relay <======
byte pinRelay22=22;  //Pin del Relay
byte pinRelay23=23;
// ======> Pines PIR <======
byte pinPir38=38;   //Pin del PIR 360°
byte pinPir39=39;   //Pin del PIR 360°
byte pinPir40=40;   //Pin del PIR 90°

// ======> Pines Magnetico <====== 
byte pinMagnt41=41;  //Pin del Sensor Marnetico de la puerta
// ======> Pines Humo <======
byte pinHumo42=42;    // Pin para la detección del presencia de humo


// ======> Configuración de los mudulos y del microcontrolador Arduino <======
void setup()
{
    Serial.begin(9600);
    // ======> Pines Relay <======
    pinMode(pinRelay22, OUTPUT);      // salida de señal al Relay
    pinMode(pinRelay23, OUTPUT);      // salida de señal al Relay
    
    // ======> Pines PRI <====== 
    pinMode(pinPir38, INPUT);       // entrada de señal del PIR  360°
    pinMode(pinPir39, INPUT);       // entrada de señal del PIR  360°
    pinMode(pinPir40, INPUT);       // entrada de señal del PIR 90° 
    
    // ======> Pines Magnetico <====== 
    pinMode(pinMagnt41,INPUT);  //Pin del Sensor Marnetico de la puerta
   
    // ======> Pines Humo <======
    pinMode(pinHumo42, INPUT);    // Pin para la detección del presencia de humo
  
  // Inicializamos la comunicación Ethernet y el servidor
  Ethernet.begin(mac, ip);
  server.begin();
  Serial.print("El arduino esta funcionando.");
  Serial.println(Ethernet.localIP());
//  Wire.begin();
  //Luxometro_Init(luxometro);
  
}

void loop()
{
  // ======> Inicio del código del Luxometro <======
//   float valf=0;
// if(Luxometro_Read(luxometro)==2 and ciclos==6000){
    
 //   valf=((buff[0]<<8)|buff[1])/1.2;
    
 //   if(valf<0)Serial.print("> 65535");
  //  else Serial.print((int)valf,DEC); 
    
 //   Serial.println(" lx"); 
 //   ciclos=0;
  //}
 //ciclos=ciclos+1;
  // ======>fin del código del Luxometro <======

 // ======> Inicio del código para sensor de humo  <======
     
    // if(digitalRead(pinShumo)==HIGH ){    // si se separan el sensor magnetico
       // digitalWrite(pinAhumo, LOW);   // se apaga la luz
        // }
        // else{
          // digitalWrite(pinAhumo, HIGH);   // se enciende la luz
          // }
   // ======> Fin del código para sensor de humo <======

countoff38= SensorMagnetico( pinMagnt41, pinRelay22, pinPir38,countoff38, web1[0] );
countoff39= SensorMagnetico( pinMagnt41, pinRelay23, pinPir39,countoff39, web2[0] );


countoff38=SensorMagnetico( pinMagnt41, pinRelay22, pinPir40,countoff38,web1[0] );
countoff39=SensorMagnetico( pinMagnt41, pinRelay23, pinPir40,countoff39,web2[0] );

// PIR 360° induvidual ZONA 1 
  countoff38= Movimiento(pinPir38, pinRelay22, countoff38, web1[0]);
// PIR 360° induvidual ZONA 2
  countoff39= Movimiento(pinPir39, pinRelay23, countoff39, web2[0]);

  // PIR 90° ZONA 1 y ZONA 2
  countoff38= Movimiento(pinPir40, pinRelay22, countoff38, web1[0]);
  countoff39= Movimiento(pinPir40, pinRelay23, countoff39, web2[0]);  
   
  // ======> Inicio del código para control WEB <======
    EthernetClient client = server.available(); //Creamos un cliente Web
     if(client) {
    boolean currentLineIsBlank = true; //Una petición HTTP acaba con una línea en blanco
    String cadena=""; //Creamos una cadena de caracteres vacía
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();//Leemos la petición HTTP carácter por carácter
        // Serial.write(c);  //Visualizamos la petición HTTP por el Monitor Serial
        cadena.concat(c);//Unimos el String 'cadena' con la petición HTTP (c). De esta manera convertimos la petición HTTP a un String


  *web1=controlWeb(client,pinPir38,pinRelay22,web1[0],web1[1],"1", cadena);
  *web2=controlWeb(client,pinPir39,pinRelay23,web2[0],web2[1],"2", cadena);
  //Cuando reciba una línea en blanco, quiere decir que la petición HTTP ha acabado y el servidor Web está listo para enviar una respuesta
        if (c == '\n' && currentLineIsBlank) {

            // Enviamos al cliente una respuesta HTTP
            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: text/html");
            client.println();
            //Página web en formato HTML
            client.println("<html  lang=es>");
            client.println("<head>  <meta charset='utf-8'>");
            //client.println("<META HTTP-EQUIV='REFRESH' CONTENT=\"3;URL='"); client.print(ip); client.println("'\"> ");
            client.print("<link href=\"http://"); client.print(web_server); client.println("/bower_components/bootstrap/dist/css/bootstrap.min.css\" rel=\"stylesheet\">");
            client.print("<link href=\"http://"); client.print(web_server); client.println("/bower_components/font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">");
          //client.println("<link href=\"http://192.168.0.100/bower_components/font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\" type=\"text/css\">");
            client.println("</head>");
            client.println("<body><div class=\"alert alert-warning\"align=\"center\"><b>");
            client.print(estado);
            //client.print("--->");
            //client.print(contAct);
            client.println("</b></div>");
            client.println("</body>");
            client.println("</html>");
            break;
        }
        if (c == '\n') {
          currentLineIsBlank = true;
        }
        else if (c != '\r') {
          currentLineIsBlank = false;
        }
      
 //Dar tiempo al navegador para recibir los datos
         }
            }
            //Dar tiempo al navegador para recibir los datos
            delay(1);
            client.stop();// Cierra la conexión
          }
// ======> Fin del código para control WEB <======

}
 // ***********************************************************************************************************
   // ======> Inicio del código para sensor de magnetico de Puerta  <======
 int SensorMagnetico(byte pinMagnt, byte pinRelay, byte pinPir, int countoff, int web ){    
    if(digitalRead(pinMagnt)==LOW && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==LOW && web==0 ){    // si se separan el sensor magnetico
        digitalWrite(pinRelay, HIGH);   // se enciende la luz
     countoff=0;
     }
     if(digitalRead(pinMagnt)==LOW && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==HIGH && web==0 ){    // si se separan el sensor magnetico
        digitalWrite(pinRelay, HIGH);   // se enciende la luz
     countoff=0;
     }
     // if(digitalRead(pinMagnt)==HIGH && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==LOW  ){    // si se apaga el censor de movimiento PIR
     //   digitalWrite(pinRelay, LOW);    // se apaga la Luz
     //  }
      return countoff;
 }
   // ======> Fin del código para sensor de magnetico de Puerta  <======
//*****************************************************************************************************************

  // ======> Inicio del código para sensor de movimiento PIR  <======
     int Movimiento(byte pinPir, byte pinRelay, int countoff, int web){
    if(digitalRead(pinPir)==LOW && web==0){    // si se activa el sensor de movimeto PIR
        digitalWrite(pinRelay, HIGH);   // enciede el Relay
        countoff=0;
     }
     if(digitalRead(pinPir)==HIGH && web==0){    // si se apaga el sensor de movimiento PIR
      
      if(digitalRead(pinPir)==HIGH && countoff==3000){
       digitalWrite(pinRelay, LOW);    // apaga el Relay
      countoff=0;
      }
      countoff=countoff+1;
      Serial.println(countoff);
       }
      return countoff;
     }     
   // ======> Fin del código para sensor de movimento.  <======

 //*****************************************************************************************************************
// ======> Arduino web  <======
int controlWeb(EthernetClient client, byte pinPir, byte pinRelay, int web, int pir, String num,String cadena )
{
  String mando="relay"+num+"=";

         //Ya que hemos convertido la petición HTTP a una cadena de caracteres, ahora podremos buscar partes del texto.
         int posicion=cadena.indexOf(mando); //Guardamos la posición de la instancia "relay=" a la variable 'posicion'

         if(cadena.substring(posicion)=="" && digitalRead(pinPir)==LOW && digitalRead(pinRelay)==HIGH  && web==0){
            estado="Luces encendidas.<br>Modo automatico. ";
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==LOW && digitalRead(pinRelay)==LOW && web== 1){
            estado="Luces apagadas.<br>Modo manual. ";
            // estado="OFF <br> Se detecta que hay movimiento, pero la luz está apagada por el sistema";
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==LOW && web== 1){
            estado="Luces apagadas.<br>Modo manual. ";
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==HIGH && web==0){
            estado="Luces encendidas.<br>Modo automatico. ";
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==HIGH  && web==1){
            estado="Luces encendidas.<br>Modo manual. ";
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==LOW  && web==0){
            estado="Luces apagadas.<br>Modo automatico. ";
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==LOW && digitalRead(pinRelay)==HIGH  && web==1){
            estado="Luces encendidas.<br>Modo manual. ";
          }
          if(cadena.substring(posicion)==(mando+"ON") && digitalRead(pinPir)==HIGH )//Si a la posición 'posicion' hay "relay=ON"
          {
            digitalWrite(pinRelay,HIGH);       
            web=1;
            pir=0;
            contAct=1;
          }
          if(cadena.substring(posicion)==(mando+"OFF") && digitalRead(pinPir)==HIGH)//Si a la posición 'posicion' hay "relay=OFF"
          {
            digitalWrite(pinRelay,LOW);
            web=1;
            contAct=2;
          }
          if(cadena.substring(posicion)==(mando+"ON") && digitalRead(pinPir)==LOW)//Si a la posición 'posicion' hay "relay=ON"
          {
            digitalWrite(pinRelay,HIGH);
            web=1;
            pir=0;
            contAct=3;
          }
           if(cadena.substring(posicion)==(mando+"OFF") && digitalRead(pinPir)==LOW)//Si a la posición 'posicion' hay "relay=ON"
          {
            digitalWrite(pinRelay,LOW);
            web=1;
            contAct=7;
          }
          if(cadena.substring(posicion)==(mando+"OFF") && digitalRead(pinPir)==LOW && web==0)//Si a la posición 'posicion' hay "relay=OFF" 
          {
            digitalWrite(pinRelay,LOW);
            web=1;
            pir=1;
            contAct=4;
          }   
          if(cadena.substring(posicion)==(mando+"Automatico"))//Si a la posición 'posicion' hay "relay=ON"
          {
            digitalWrite(pinRelay,LOW);
            web=0;
            pir=0;
            contAct=5;
          }
          if(cadena.substring(posicion)==(mando+"OFF") && digitalRead(pinPir)==LOW && web==0)//Si a la posición 'posicion' hay "relay=OFF" 
          {
            digitalWrite(pinRelay,LOW);
            web=0;
            pir=1;
            contAct=6;
          }
          if(cadena.substring(posicion)=="" && digitalRead(pinPir)==HIGH && digitalRead(pinRelay)==LOW  && pir==1){
           estado="Luces apagadas.<br>Modo manual. 12345 ";
           // estado="OFF <br> El censor de movimiento está desactivado y la luz está apagada por el sistema";
          }       
        
  int array[2]={web,pir};
  return *array;
}
// ======> Fin control web   <======
//**************************************************************************************************************
// ======> Arduino-PHP-MySQL  <======
void PIR_Mysql(int act,IPAddress web_server){
 EthernetClient client;
  if(act==1)
  {
    if (client.connect(web_server, 80)>0) {
              client.print("GET /smyci/microc-db/MicrocBD.php?microC=");
              //client.print(numSerieArduino);
              client.print("&modulo=");
              //client.print(modulo);
              client.print("&actividad=");
              client.print("Encender Luz");
              client.println(" HTTP/1.0");
              client.println("User-Agent: Arduino 1.0");
              client.println();
              Serial.println("Conectado");
              Serial.println(client);
              }
             else{
                 Serial.println("Fallo en la conexion");
              }
     }
     if(act==0)
     {
      if (client.connect(web_server, 80)>0) {
              client.print("GET /smyci/microc-db/MicrocBD.php?microC=");
              //client.print(numSerieArduino);
              client.print("&modulo=");
              //client.print(modulo);
              client.print("&actividad=");
              client.print("Apagar Luz");
              client.println(" HTTP/1.0");
              client.println("User-Agent: Arduino 1.0");
              client.println();
              Serial.println("Conectado");
              }
             else{
                 Serial.println("Fallo en la conexion");
              }
     }
     if (!client.connected()) {
    Serial.println("Disconnected!");
  }
  client.stop();
  client.flush();
  delay(100);
        
  }


  // ======> Código para metricas del Luxómetro <====== 

//void Luxometro_Init(int address){
  
 // Wire.beginTransmission(address);
 // Wire.write(0x10); // 1 [lux] aufloesung
 // Wire.endTransmission();
//}

//byte Luxometro_Read(int address){
  
  //byte i=0;
//  Wire.beginTransmission(address);
  //Wire.requestFrom(address, 2);
  //while(Wire.available()){
   // buff[i] = Wire.read(); 
    //i++;
  //}
  //Wire.endTransmission();  
  //return i;
//}
  
  
