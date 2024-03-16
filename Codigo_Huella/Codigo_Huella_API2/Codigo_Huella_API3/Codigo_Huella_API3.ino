#include <Adafruit_Fingerprint.h>
#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include <Base64.h>


#define fingerRx D1  // RX del sensor conectado al pin 2 del Arduino
#define fingerTx D2  // TX del sensor conectado al pin 3 del Arduino

SoftwareSerial fingerSerial(fingerRx, fingerTx); // Inicializa SoftwareSerial

Adafruit_Fingerprint finger(&fingerSerial); // Inicializa el sensor de huellas

const char* ssid = "IZZI-42AA";
const char* password = "nxqa29ba";
const char* apiUrl = "http://192.168.1.14:3000/api/peticiones/alumnos/huella";
const char* method = "POST";

uint8_t id;
uint8_t templateSize;
uint8_t templateBuffer[256];

void setup() {
  Serial.begin(9600);
  fingerSerial.begin(9600); // Inicia la comunicación serial con el sensor de huellas

  delay(100);

  if (finger.verifyPassword() == false) {
    Serial.println("Fallo al iniciar el sensor de huella dactilar");
    while (1); // Detiene el programa aquí
  }

  Serial.println("Sensor de huella dactilar inicializado");
  Serial.println(F("Leyendo parámetros del sensor"));
  finger.getParameters();
  Serial.print(F("Estado: 0x")); Serial.println(finger.status_reg, HEX);
  Serial.print(F("ID de sistema: 0x")); Serial.println(finger.system_id, HEX);
  Serial.print(F("Capacidad: ")); Serial.println(finger.capacity);
  Serial.print(F("Nivel de seguridad: ")); Serial.println(finger.security_level);
  Serial.print(F("Dirección del dispositivo: ")); Serial.println(finger.device_addr, HEX);
  Serial.print(F("Longitud del paquete: ")); Serial.println(finger.packet_len);
  Serial.print(F("Velocidad de baudios: ")); Serial.println(finger.baud_rate);

  // Conectar a WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Conectando a WiFi...");
  }
  Serial.println("Conectado a la red WiFi");
}

uint8_t readnumber(void) {
  uint8_t num = 0;

  while (num == 0) {
    while (!Serial.available());
    num = Serial.parseInt();
  }
  return num;
}

void loop() {
  Serial.println("Listo para enrolar una huella dactilar!");
  Serial.println("Por favor, escriba el número de ID (de 1 a 127) que desea guardar para esta huella...");
  id = readnumber();
  if (id == 0) {
    return;
  }
  Serial.print("Enrolando ID #");
  Serial.println(id);

  while (!getFingerprintEnroll());
}

uint8_t getFingerprintEnroll() {
  int p = -1;
  Serial.print("Waiting for valid finger to enroll as #"); Serial.println(id);
  while (p != FINGERPRINT_OK) {
    p = finger.getImage();
    switch (p) {
      case FINGERPRINT_OK:
        Serial.println("Image taken");
        break;
      case FINGERPRINT_NOFINGER:
        Serial.print(".");
        break;
      case FINGERPRINT_PACKETRECIEVEERR:
        Serial.println("Communication error");
        break;
      case FINGERPRINT_IMAGEFAIL:
        Serial.println("Imaging error");
        break;
      default:
        Serial.println("Unknown error");
        break;
    }
  }

  p = finger.image2Tz(1);
  switch (p) {
    case FINGERPRINT_OK:
      Serial.println("Image converted");
      break;
    case FINGERPRINT_IMAGEMESS:
      Serial.println("Image too messy");
      return p;
    case FINGERPRINT_PACKETRECIEVEERR:
      Serial.println("Communication error");
      return p;
    case FINGERPRINT_FEATUREFAIL:
    case FINGERPRINT_INVALIDIMAGE:
      Serial.println("Could not find fingerprint features");
      return p;
    default:
      Serial.println("Unknown error");
      return p;
  }

  Serial.println("Remove finger");
  delay(2000);
  p = 0;
  while (p != FINGERPRINT_NOFINGER) {
    p = finger.getImage();
  }
  Serial.print("ID "); Serial.println(id);
  p = -1;
  Serial.println("Place same finger again");
  while (p != FINGERPRINT_OK) {
    p = finger.getImage();
    switch (p) {
      case FINGERPRINT_OK:
        Serial.println("Image taken");
        break;
      case FINGERPRINT_NOFINGER:
        Serial.print(".");
        break;
      case FINGERPRINT_PACKETRECIEVEERR:
        Serial.println("Communication error");
        break;
      case FINGERPRINT_IMAGEFAIL:
        Serial.println("Imaging error");
        break;
      default:
        Serial.println("Unknown error");
        break;
    }
  }

  p = finger.image2Tz(2);
  switch (p) {
    case FINGERPRINT_OK:
      Serial.println("Image converted");
      break;
    case FINGERPRINT_IMAGEMESS:
      Serial.println("Image too messy");
      return p;
    case FINGERPRINT_PACKETRECIEVEERR:
      Serial.println("Communication error");
      return p;
    case FINGERPRINT_FEATUREFAIL:
    case FINGERPRINT_INVALIDIMAGE:
      Serial.println("Could not find fingerprint features");
      return p;
    default:
      Serial.println("Unknown error");
      return p;
  }

  p = finger.createModel();
  if (p == FINGERPRINT_OK) {
    Serial.println("Prints matched!");
  } else if (p == FINGERPRINT_PACKETRECIEVEERR) {
    Serial.println("Communication error");
    return p;
  } else if (p == FINGERPRINT_ENROLLMISMATCH) {
    Serial.println("Fingerprints did not match");
    return p;
  } else {
    Serial.println("Unknown error");
    return p;
  }

  p = finger.storeModel(id);
  if (p == FINGERPRINT_OK) {
    Serial.println("Stored!");
  } else if (p == FINGERPRINT_PACKETRECIEVEERR) {
    Serial.println("Communication error");
    return p;
  } else if (p == FINGERPRINT_BADLOCATION) {
    Serial.println("Could not store in that location");
    return p;
  } else if (p == FINGERPRINT_FLASHERR) {
    Serial.println("Error writing to flash");
    return p;
  } else {
    Serial.println("Unknown error");
    return p;
  }

  // Envía la huella y la ID a la API
  WiFiClient client;
  HTTPClient http;

  Serial.print("[HTTP] Conectando a ");
  Serial.println(apiUrl);

  if (http.begin(client, apiUrl)) {
    http.addHeader("Content-Type", "application/json");

    // Crear un JSON con la ID y la huella
    StaticJsonDocument<256> doc;
    doc["idHuella"] = id;
    doc["huella"] = base64::encode(templateBuffer, templateSize); // Encode the fingerprint template to base64
    String json;
    serializeJson(doc, json);

    int httpCode = http.POST(json);

    if (httpCode > 0) {
      Serial.printf("[HTTP] Código de estado de la respuesta: %d\n", httpCode);
      String payload = http.getString();
      Serial.println("[HTTP] Respuesta del servidor: " + payload);
      if (httpCode == HTTP_CODE_OK) {
        String payload = http.getString();
        Serial.println("[HTTP] Respuesta del servidor: " + payload);
      }
    } else {
      Serial.printf("[HTTP] Fallo en la solicitud: %s\n", http.errorToString(httpCode).c_str());
    }

    http.end();
  } else {
    Serial.printf("[HTTP] Falló al conectarse a %s\n", apiUrl);
  }

  return true;
}
