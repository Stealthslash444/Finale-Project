class Money {
  float moneyInit=7000;
  float money=0;
  int x=650, y=760;
  int size=30;
  int expect;
  float moneyRed=323*2;
  int moneyDaily=1000;
  PImage img;


  Money() {
    img=loadImage("img/money-bag.png");
    money=moneyInit;
  }

  void display(int PosX, int PosY) {
    x=PosX;
    y=PosY;
    
    expect=1500*building.building+moneyDaily;
    image(img, x, y, size, size);
    textSize(size/1.5);
    textAlign(LEFT, TOP);
    fill(0);
    text("預算 : "+floor(money)+"(next day + "+expect+")", x+size, y);
  }
}