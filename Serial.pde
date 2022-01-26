/*
Serial.print() code meaning for Processing:
 0 - TV clap off
 1 - TV clap on
 2 - Timer TV off
 3 - Timer TV on
 4 - Button pressed, listening off
 5 - Button pressed, listening on
 */
void serialGet() {
  if (port.available()>0) { // when there is incoming serial data
    currentbyte = (char)port.read();
    if (currentbyte != ',') { // Add currentbyte to value until the delimitting comma is received.
      value += currentbyte;
    } else {
      //println(value);
      switch(int(value)) {
      case 0:
        log = log + hour() + ":" + minute() + ":" + second() + " - Clapped, TV off\n";
        break;
      case 1:
        log = log + hour() + ":" + minute() + ":" + second() + " - Clapped, TV on\n";
        break;
      case 2:
        log = log + hour() + ":" + minute() + ":" + second() + " - Timer is up, TV switched off\n";
        break;
      case 3:
        log = log + hour() + ":" + minute() + ":" + second() + " - Timer is up, TV switched on\n";
        break;
      case 4:
        switchstate = 0;
        break;
      case 5:
        switchstate = 1;
        break;
      }
      //print(value);
      value = "";
    }
  }
}
