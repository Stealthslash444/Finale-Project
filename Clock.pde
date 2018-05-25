//copy pase
class Clock {
  int x=100, y=710;
  int timeMax=60*90;
  int time;
  int timeParty=60*20;


  Clock() {
    time=timeMax;
  }

  void update() {
    if (time>0)    time--;
    else if (gameState==stage1)gameState=DAYOFF;
    else {
      gameState=VOTE;
      prevote();
    }
  }

  void display() {

    textAlign(LEFT, TOP);
    fill(0);
    textSize(size/4);
    if (gameState==stage1)
    text("DAY"+day, x-80, y-10);

    textSize(size/1.5);
    text(nf(floor(time/3600), 2)+":"+nf(floor((time/60)%60), 2), x, y);
  }
}