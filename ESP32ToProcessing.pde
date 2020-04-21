/*
Week 11: ESP32 to Processing

By Taylor Malligan
*/

// Importing the serial library to communicate with the Arduino 
import processing.serial.*;

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;      

// Data coming in from the data fields
String [] data;
int switchValue = 0;
int potValue = 1;
//int ldrValue = 0;

// Change to appropriate index in the serial list — YOURS MIGHT BE DIFFERENT
int serialIndex = 0;

// animated star
int minPotValue = 0;
int maxPotValue = 4095;    // will be 1023 on other systems
int minSpeed = 0;
int maxSpeed = 50;
int hMargin = 40;    // margin for edge of screen
int xMin;        // calculate on startup
int xMax; // calc on startup
int yMin;
int yMax;
float imageX;
float imageY;        // calc on startup, use float b/c speed is float      // calc on startup
int direction = -1;    // 1 or -1

//image parameters
PImage yellowstar;
float xImagePos = 0;
float yImagePos = 0;

//text parameters
PFont font;

int minLDRValue = 400;
int maxLDRValue = 1700;
int minAlphaValue = 0;
int maxAlphaValue = 255;

//int col;
int red = int(random(250));
int green = int(random(76));
int blue = int(random(206));


void setup(){
  size(900,800);
 // List all the available serial ports
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  //-- use your port name
  myPort = new Serial (this, Serial.list() [serialIndex],  115200); 

  // load our image, use your own!
  yellowstar = loadImage("yellowstar.jpg");
  imageMode(CORNER);
  xImagePos = 50;
  yImagePos = 50;
  
  font = createFont("Arial", 40);
}

void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    print(inBuffer);
    
    // This removes the end-of-line from the string 
    inBuffer = (trim(inBuffer));
    
    // This function will make an array of TWO items, 1st item = switch value, 2nd item = potValue
    data = split(inBuffer, ',');
   
   // we have TWO items — ERROR-CHECK HERE
   if(data.length >= 2) {
      switchValue = int(data[0]);           // first index = switch value 
      potValue = int(data[1]);               // second index = pot value
 
   }
  }
} 

void draw(){
  checkSerial();
  drawBackground();
  drawStar();
}

//void drawRect(){
//  fill(140, 249, 93); // green rect
//  rect(500,100,200,300);//green rect
//}

void drawBackground(){
  if (switchValue == 1){
    red++;
    green++;
    blue++;
    background(red,green,blue);
  }
  else{
  background(48, 214, 234); //background for the screen
  smooth();
    
}
}

void drawStar(){
  image(yellowstar,imageX, imageY);
  float speed = map(potValue, minPotValue, maxPotValue, minSpeed, maxSpeed);
  
  imageX = imageX + (speed * direction);
  imageY= imageY + (speed * direction);
}
