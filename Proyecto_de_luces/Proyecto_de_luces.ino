int Fotocelda;
int led = 7;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(led, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
 Fotocelda=analogRead(A0);
 Serial.println(Fotocelda);
 if(Fotocelda >= 800){
  digitalWrite(led, HIGH); 
 }else{
  digitalWrite(led, LOW); 
 }
}
