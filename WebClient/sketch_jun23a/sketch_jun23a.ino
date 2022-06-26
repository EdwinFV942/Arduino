#include <SPI.h>
#include <Ethernet.h>

int Fotocelda;
int led = 7;

byte mac[] = { 
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,1,177);

EthernetServer server(80);

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  Serial.println("Ethernet WebServer Example");

  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip);

  // Check for Ethernet hardware present
  if (Ethernet.hardwareStatus() == EthernetNoHardware) {
    Serial.println("Ethernet shield was not found.  Sorry, can't run without hardware. :(");
    while (true) {
      delay(1); // do nothing, no point running without Ethernet hardware
    }
  }
  if (Ethernet.linkStatus() == LinkOFF) {
    Serial.println("Ethernet cable is not connected.");
  }

  // start the server
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());
}

void loop() {
  Fotocelda = analogRead(A0);
  Serial.print("Valor de Fotocelda ");
  Serial.print(Fotocelda);
  if (Fotocelda >= 300) {
              digitalWrite(led, HIGH);
            } else {
              digitalWrite(led, LOW);
            }
  if (server.connect(server, 80) > 0) { // Conexion con el servidor(client.connect(server, 80)>0
    cliente.print("GET index.php?pre_php="); // Enviamos los datos por GET
    cliente.print(P, 2);
    cliente.print("&hum_php=");
    cliente.print(hum);
    cliente.println(" HTTP/1.0");
    cliente.println("User-Agent: Arduino 1.0");
    cliente.println();
    Serial.println("Envio con exito (al archivo controller/index y models/herramienta)");
    delay(1000);
  } else {
    Serial.println("Fallo en la conexion");
    delay(2000);
  }
  delay(1);
  // close the connection:
  client.stop();
  Serial.println("client disconnected");
  //delay(5000); // Espero un minuto antes de tomar otra muestra
}
