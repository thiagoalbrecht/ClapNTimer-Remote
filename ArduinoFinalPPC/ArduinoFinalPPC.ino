/*
Serial.print() codes for Processing:
0 - TV clap off
1 - TV clap on
2 - Timer TV off
3 - Timer TV on
4 - Button pressed, listening off
5 - Button pressed, listening on
 
We’re using the IRLib2 library (https://github.com/cyborg5/IRLib2). 
To get the codes for your remote, upload the sketch in examples/rawRecv/.
Press the power button of your remote pointing it to the IR receiver, and
copy the code from the serial monitor and paste it below the “Output from rawRecv.ino here” comment (also rename the array to switchTV).
 
*/

#include <IRLibSendBase.h>
#include <IRLib_HashRaw.h>

IRsendRaw mySender;

int soundSense = 4;
int buzzer = 7;
int LED = 8;
int btn = 12;
int incomingByte;
bool listening = true;
bool state = false;
bool btnpushed = false;

void setup()
{
  pinMode(soundSense, INPUT);
  pinMode(btn, INPUT);
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
  pinMode(buzzer, OUTPUT);
}

// Output from rawRecv.ino here:

#define RAW_DATA_LEN 68

uint16_t switchTV[RAW_DATA_LEN] = {
    8918, 4466, 538, 578, 586, 554, 510, 578,
    562, 582, 534, 578, 534, 606, 482, 630,
    510, 578, 534, 1722, 482, 1746, 538, 1642,
    586, 1666, 558, 1670, 558, 1666, 514, 630,
    510, 1666, 586, 1722, 506, 526, 566, 1690,
    566, 1666, 534, 574, 538, 554, 614, 502,
    558, 578, 510, 578, 590, 1662, 566, 554,
    510, 578, 586, 1642, 590, 1638, 562, 1666,
    614, 1666, 562, 1000};

void loop()
{
  if (Serial.available() > 0)
  {

    // read the oldest byte in the serial buffer:

    incomingByte = Serial.read();

    switch (incomingByte)
    {
    case 0:
      listening = false;
      break;
    case 1:
      listening = true;
      break;
    case 2:
      digitalWrite(buzzer, HIGH);
      delay(100);
      digitalWrite(buzzer, LOW);
      mySender.send(switchTV, RAW_DATA_LEN, 36);
      state = !state;
      digitalWrite(LED, state);
      Serial.print(state + 2);
      Serial.print(",");
      break;

    default:
      break;
    }
  }

  if (digitalRead(soundSense) == LOW && listening)
  {
    digitalWrite(buzzer, HIGH);
    delay(100);
    state = !state;
    digitalWrite(LED, state);
    digitalWrite(buzzer, LOW);
    mySender.send(switchTV, RAW_DATA_LEN, 36);
    Serial.print(state);
    Serial.print(",");
  }

  if (digitalRead(btn) == HIGH && !btnpushed)
  {
    btnpushed = true;
    listening = !listening;
    Serial.print(listening + 4);
    Serial.print(",");
  }

  if (digitalRead(btn) == LOW)
  {
    btnpushed = false;
  }
}
