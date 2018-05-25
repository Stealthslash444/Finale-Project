class Red {
  int col, row;
  int x=300, y=700;
  int percent=0;  
  int counter_max=60*6;
  int counter=counter_max;
  boolean reding=false;  
  boolean isReded[][]=new boolean[COL][ROW];
  PImage img;

  Red() {
    for (int i=0; i<6; i++) {
      img=loadImage("img/red/redEnvelope5.png");
    }
  }

  void display() {
    image(img, x, y, size, size);
    stroke(175);
    strokeWeight(14);
    line(x+size, y+size/2, x+size+(counter_max)/2, y+size/2);
    stroke(124, 36, 36);
    strokeWeight(10);
    line(x+size, y+size/2, x+size+(counter_max-counter)/2, y+size/2);
    if(floor(random(20))==1){
      coin.trigger();
    }
  }
}