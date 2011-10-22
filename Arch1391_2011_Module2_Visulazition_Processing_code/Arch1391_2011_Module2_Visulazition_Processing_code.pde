
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

Shabi shabi;

void setup() {
  size(1500,500,P3D);
  noStroke();
  smooth();
  fill(2);
  shabi = new Shabi(color(255,0,0),0,100,2); 
  
  // code for setting up arduino
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(0, Arduino.INPUT);

 
}

void draw() {
  background(255);
  shabi.drive();
  shabi.display();
  
  
  
}

// Even though there are multiple objects, we still only need one class. 
// No matter how many cookies we make, only one cookie cutter is needed.
class Shabi { 
  color c;
  float xpos;
  float ypos;
  float xspeed;
 

  // The Constructor is defined with arguments.
  Shabi(color C, float Xpos, float Ypos, float Xspeed){ 
    c = C;
    xpos = Xpos;
    ypos = Ypos;
    xspeed = 2;
   
  }

  void display() {
    stroke(0);
    fill(2);
    ellipseMode(CENTER);
    int value = arduino.analogRead(0);
    ellipse(xpos,ypos, value,value);
  }

  void drive() {
    xpos = xpos + xspeed;
    if (xpos > width) {
      xpos = 0;
    }
  }
}

