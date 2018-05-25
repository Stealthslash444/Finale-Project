class Build { //<>// //<>//
  int col, row;
  int x, y;
  int state=0;
  int dayStartBuild=1;
  int dayStartBang=1;
  boolean isbuild=false;
  boolean space=false;
  boolean isbang=false;
  Build(int col, int row) {

    this.col=col;
    this.row=row;
    x=col*size;
    y=row*size;
  }


  void display() {
    if (gameState==stage1) {
      if (keyy&&space&&isbuild) {
        isbuild=false;
        isbang=true;

        dayStartBang=day;
      } else
        if (keyy&&space&&!isbang) {
          if ((building.building==0&&money1.money>=2520)|(building.building>0&&money1.money>=5522)) {

            state=1;
            isbuild=true;
            dayStartBuild=day;
            money1.money-= (building.building==0) ? 2520 : 5520 ;
          } else {
          }
        }

      //

      if (facingbuild(col, row)) {
        if (key==' ') {
          if (state==0&&!isbuild) {
            textSize(25);
            textAlign(LEFT, TOP);
            fill(0);
            if (building.building==0) {
              if (money1.money>=2520) {
                text("確定要包工程收回扣嗎?(2520$)", 300, 710); 
                image(confirm, 300, 725, size, size-5);
                image(cancel, 450, 725, 100, 100-5);
              } else {                
                textSize(15);
                textAlign(LEFT, TOP);
                fill(255, 0, 0);
                text("You do not have enough money for Construction.", 300, 750);
              }
            }

            if (building.building>0) {
              if (money1.money>=5522) {
                text("確定要包工程收回扣嗎?(5522$)", 300, 710);
                image(confirm, 300, 725, size, size-5);
                image(cancel, 450, 725, 100, 100-5);
              } else {
                textSize(15);
                textAlign(LEFT, TOP);
                fill(255, 0, 0);
                text("You do not have enough money for Construction.", 300, 750);
              }
            }


            space=true;
          } else if (isbuild&&state>0) {
            textSize(25);
            textAlign(LEFT, TOP);
            fill(0);
            space=true;
            text("確定要拆除建設嗎?", 300, 710);
            image(confirm, 300, 725, size, size-5);
            image(cancel, 450, 725, 100, 100-5);
          }
        } else {
          space=false;
        }
      }

      image(map1.buildImg[state], x, y, size, size);
    }
  }

  boolean facingbuild(int col, int row) {
    if ( i.col==col && i.row==row+1 && i.direction==i.up) {
      return true;
    } else if (i.col==col && i.row==row-1 && i.direction==i.down) {
      return true;
    } 
    if ( i.col==col-1 && i.row==row && i.direction==i.right) {
      return true;
    } 
    if (i.col==col+1 && i.row==row && i.direction==i.left) {
      return true;
    } else {
      return false;
    }
  }

  void stateUpdate() {

    if (isbuild&& !isbang) { //<>//
      state=day-dayStartBuild+2;
    } else if (isbang&&!isbuild) {
      state=dayStartBang-dayStartBuild-(day-dayStartBang);
      state=max(state, 0);
    } else {
      state=0;
    }
    if (state>=5)state=4;
    if (state==0) isbang=false;
  }
}