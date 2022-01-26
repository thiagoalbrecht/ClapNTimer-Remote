import processing.serial.*; // use serial port libraries

PImage[] switchbtn = new PImage[2];
PImage[] ui = new PImage[3];
int switchstate = 1;
int dialogstate, sleeptime, time, started = 0;
String log = "";
char currentbyte;
String value = "";
Serial port;

void setup() {
  size(900, 600);
  port = new Serial(this, Serial.list()[0], 9600);  // open the port!
  switchbtn[0] = loadImage("images/off-button.png");
  switchbtn[1] = loadImage("images/on-button.png");
  ui[0] = loadImage("images/clock.png");
  ui[1] = loadImage("images/play.png");
  ui[2] = loadImage("images/stop.png");
}
void draw() {
  background(255);
  textAlign(RIGHT);
  color(0);
  textSize(32);
  fill(0);
  text("Listening:", 740, 75);
  textAlign(LEFT);
  textSize(20);
  text(log, 25, 50);
  image(switchbtn[switchstate], 750, 0);
  image(ui[0], 750, 125);
  dialog();
  serialGet();
}

void mouseClicked() {
  if (mouseX > 750 && mouseX < 750+128 && mouseY > 35 && mouseY < 100) {
    switchstate = 1 - switchstate;
    port.write(switchstate);
    //println(switchstate);
  }
  if (mouseX > 750 && mouseX < 750+128 && mouseY > 120 && mouseY < 248) {
    dialogstate = 1 - dialogstate;
  }
  if (mouseX > 690 && mouseX < 690+64 && mouseY > 270 && mouseY < 334) {
    started = 1 - started;
    time = millis();
  }
}

void keyPressed() {
  int keyValue = keyCode-48; // keyCode 48=0, 57=9
  if (dialogstate == 1 && started == 0 && keyValue >= 0 && keyValue <= 9) { 
    if (sleeptime <= 9) sleeptime = sleeptime * 10 + keyValue;
    else sleeptime = keyValue;
  }
}
