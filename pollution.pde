class Pollution {
  int level=0;
  PImage lv[]=new PImage [6];
  float alternative=0;
  float alternateSpeed;
  float Speed=0;


  Pollution() {
    for (int i=0; i<=5; i++) {
      lv[i]=loadImage("img/pollution/pollution"+i+"-01.png");
    }
  }

  void update(int l) {
    level=l;
  }

  void display() {

Speed=    alternateSpeed;
    alternative+=Speed;
    alternateSpeed= (alternateSpeed<0) ? 
      -random(1): random(1);
    if (alternative>=10) {
      alternative=10;
      alternateSpeed*=-1;
    } else if (alternative<=-10) {
      alternative=-10;
      alternateSpeed*=-1;
    }
    tint(180+alternative*2);
    image(lv[level], 0, 0+alternative, width, height);
    tint(255);
  }
}