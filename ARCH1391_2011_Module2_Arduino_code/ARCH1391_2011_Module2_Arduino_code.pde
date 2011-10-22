#include <Firmata.h>

int ledPin0 = 11; // choose the pin for the LED  
int ledPin1 = 12;  

int inputPin1 = 2;  // button1  
int inputPin2 = 3;  // button2

int Putbutton = 0; // but the button function
int lightPin = 0; // The photoresistor is to Analog 0   
int lightChange;  // Make photoresistor change light and it works
int lightmapped;  // The photoresistor the light

int APin1 = 0;    // For Grasshopper Read the pin
int APin2 = 0;
int APin3 = 0;
int APin4 = 0;
int APin5 = 0;
int DPin4 = 0;
int DPin7 = 0; 
boolean active = false;

void setup()  {  
  Firmata.setFirmwareVersion(0, 1);
  Firmata.begin(57600);
  pinMode(ledPin0, OUTPUT); // declare LED as output
  pinMode(ledPin1, OUTPUT);
  pinMode(lightPin, INPUT); // make photoresistor as an input      
  pinMode(inputPin1, INPUT); // make button as an input  
  pinMode(inputPin2, INPUT);  
}

void loop(){
  CheckButton(); // Make the botton work with leds 
  lightinput();    // Make the photoresistor work with leds
  
  if (active) { oneAfterAnotherNoLoop();
  }
  
  APin1 = analogRead(1); // For Grasshopper Read the pin
  APin2 = analogRead(2); 
  APin3 = analogRead(3); 
  APin4 = analogRead(4); 
  APin5 = analogRead(5); 
  DPin4 = digitalRead(4);  
  DPin7 = digitalRead(7); 
  
  //Serial.print(lightmapped);
  Firmata.sendAnalog(0, lightmapped);
  delay(50);
}

void lightinput(){
  lightChange = analogRead(lightPin);   //Read the photoresistor
  lightmapped = constrain(lightChange,0,500);  //Read the photoresistor level 
  analogWrite(ledPin0,lightmapped);  
  analogWrite(ledPin1,lightmapped);    
}

void oneAfterAnotherNoLoop(){
  int delayTime = analogRead(lightPin); //Read the lightlevel
  delayTime = map(delayTime, 100, 500, 50,500);
  digitalWrite(ledPin0, HIGH); 
  delay(delayTime);
  CheckButton();
 
  digitalWrite(ledPin1, HIGH); 
  delay(delayTime);
  CheckButton();
  
  digitalWrite(ledPin0, LOW); 
  delay(delayTime);
  CheckButton();
  
  digitalWrite(ledPin1, LOW); 
  delay(delayTime);
  CheckButton(); 
}




void CheckButton(){ 
    if (digitalRead(inputPin1) == LOW) {
    digitalWrite(ledPin0, HIGH); // turn LED ON
    digitalWrite(ledPin1, HIGH);
    active = true; 
  } else
    if (digitalRead(inputPin2) == LOW) {
    digitalWrite(ledPin0, LOW); // turn LED OFF
    digitalWrite(ledPin1, LOW);
    active = false;
  }
}
