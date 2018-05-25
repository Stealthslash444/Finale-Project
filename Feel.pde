class Feel {
  int col, row;
  int x, y;
  int mood;
  PImage img;

  Feel(int col, int row) {

    this.col=col;
    this.row=row;
    x=col*size;
    y=row*size;
    mood=floor(random(0, 6));
    img=loadImage("img/feel/"+mood+".png");
  }

  void display() {
    if (facingdoor(col, row)) {
      if (mood<=5&&mood>=3 &&  key==' '&& red.reding==false &&red.isReded[col][row]==false) {
        if (money1.money>=money1.moneyRed) {
          red.reding=true;
          red.col=col;
          red.row=row;
        } else {
          textSize(15);
          textAlign(LEFT, TOP);
          fill(255, 0, 0);
          text("your money is too less to give out red envelope", 300, 750);
        }
      }      
      image(img, x+size/5, y, size/2, size/2);
    }
  }

  boolean facingdoor(int col, int row) {
    if (map1.mapType[col][row]==map1.HOUSE_DOWN && i.col==col && i.row==row+1 && i.direction==i.up) {
      return true;
    } else if (map1.mapType[col][row]==map1.HOUSE_UP && i.col==col && i.row==row-1 && i.direction==i.down) {
      return true;
    } 
    if (map1.mapType[col][row]==map1.HOUSE_LEFT && i.col==col-1 && i.row==row && i.direction==i.right) {
      return true;
    } 
    if (map1.mapType[col][row]==map1.HOUSE_RIGHT && i.col==col+1 && i.row==row && i.direction==i.left) {
      return true;
    } else {
      return false;
    }
  }
}