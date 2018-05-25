class Popularity {
  int popularity=0;
  int x=800, y=710;
  int size=30;
  int popularityRed=20;
  int popularityDaily=20;
  int max=999;
  PImage img;
  color c, c1=color(255, 0, 0), c2=color(255, 0, 125), c3=color(255, 0, 255), c4=color(125, 0, 255), c5=color(0, 0, 255);
  String s;
  String s1="  ( too low )";
  String s2="  ( low )";
  String s3="  ( not enough )";
  String s4="  ( close )";
  String s5="  ( high )";

  Popularity() {
    img=loadImage("img/badge.png");
    c=c1;
    s=s1;
  }

  void display() {
    image(img, x, y, size, size);
    textSize(size/1.5);
    textAlign(LEFT, TOP);    
    if (popularity<100) {
      c=c1;
      s=s1;
    } else if (popularity<250) {
      c=c2;
      s=s2;
    } else if (popularity<450) {
      c=c3;
      s=s3;
    } else if (popularity<689) {
      c=c4;
      s=s4;
    } else {
      c=c5;
      s=s5;
    }
    fill(c);
    popularity1.popularity=min(popularity1.popularity, 999);
    text("聲望 : "+popularity+s, x+size, y);
  }


}