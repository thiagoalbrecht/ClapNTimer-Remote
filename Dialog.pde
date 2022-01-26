void dialog() {
  if (dialogstate == 1) {
    fill(225);
    noStroke();
    rectMode(CENTER);
    rect(625, 200, 220, 220, 20);
    textSize(24);
    fill(0);
    textAlign(CENTER);
    text("Turn off in:", 625, 125);
    text("Seconds", 625, 290);
    textSize(84);
    text(sleeptime, 625, 235);
    if (sleeptime > 0) image(ui[started+1], 690, 260);
  }
  if (millis() - time >= 1000 && started == 1 && sleeptime > 0) {
    sleeptime -= 1;
    time = millis();
    if (sleeptime == 0) {
      started = 0;
      port.write(2);
    }
  }
}
