class Building {
  int buildingInit=0;
  int building=0;
  int x=650, y=710;
  int size=30;
  PImage img;


  Building() {
    img=loadImage("img/crane.png");
    building=buildingInit;
  }

  void display() {
    building=0;
    for(int i=0 ;i<build.length;i++){
      if(build[i].isbuild)building++;
    }    
    image(img, x, y, size, size);
    textSize(size/1.5);
    textAlign(LEFT, TOP);
    fill(0);
    text("包工程 : "+building, x+size, y);
  }
}