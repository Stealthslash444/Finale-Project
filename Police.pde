class Police { //<>//

  PImage img;
  PImage police[][];
  PImage policeAngry[][];
  int state;
  final int INIT=0;
  final int ANGRY=1;
  int speedY, speedX, w, h;
  int x, y;
  int a[] ={0, 1, 0, 2};
  int s=0;
  int direction;
  final int down=0;
  final int up=1;
  final int left=2;
  final int right=3;



  int policeNumX;
  int policeNumY;
  int row=5, col=10;
  boolean upWalk, downWalk, leftWalk, rightWalk = false;
  String[] turnDirection = new String [1];
  //music
  boolean isbeseen=false;
  Police() {
    police=pimg(police, "");
    policeAngry=pimg(policeAngry, "Angry");
    x=col*size;
    y=row*size;
    w=h=100;
    move(2);
  }

  void update() {
    if (isHit(x, y, w, h, i.x, i.y, w, w)&&charged==false) {

      caughtCounter++;
      nervous.trigger();
      gameState=GETCAUGHT;
    }
    if (x==(col)*size&&y==(row)*size) {
      int checkingNum=checkUp(col, row)+checkRight(col, row)+checkLeft(col, row)+checkDown(col, row);
      if (checkingNum>=2) {
        if (checkingNum>=3&&state==ANGRY) {
          if (x>i.x) {
            direction=left;
          }
          if (x<i.x) {
            direction=right;
          }
          if (y<i.y) {
            direction=down;
          }
          if (y>i.y) {
            direction=up;
          }
        } else {
          takeInvalue(checkingNum);
        }
      }
    }
    if (test.beSeen(test.x, test.y, i.x, i.y)) {
      test.move(4);
      display(test.policeAngry);    
      test.state=test.ANGRY;     
      if (!isbeseen) {
        beseen.trigger();
        isbeseen=true;
      }
    } else {
      test.move(2);
      test.display(test.police);
      isbeseen=false;
      test.state=test.INIT;
    }
  }
  void move(int speed) {  


    initMove(speed);
  }

  void display(PImage state[][]) {

    img=state[direction][a[s/4]];
    image(img, x, y-10, size, size);
    s++;
    s%=16;
    col=(int) x / size ;
    row=(int) y / size ;
  }

  PImage[][] pimg(PImage file[][], String state) {
    file=new PImage[4][3];
    for (int i=0; i<4; i++) {
      for (int j=0; j<3; j++) {
        file[i][j]=loadImage("img/police"+state+"/police"+state+i+j+".png");
      }
    }
    return(file);
  }

  boolean beSeen(float ax, float ay, float bx, float by) {
    if ((ax<bx&&direction==right&& row==i.row) ||(ax>bx&&direction==left&& row==i.row) ||(ay<by&&direction==down&& col==i.col) ||(ay>by&&direction==up&& col==i.col)) {
      return(true);
    } else {
      return(false);
    }
  }



  void initMove (int speed) {
    if (direction==left) {
      x-=speed;
    } else if (direction==right) {
      x+=speed;
    } else if (direction==up) {
      y-=speed;
    } else if (direction==down) {
      y+=speed;
    }
  }

  int  checkUp (int X, int Y) {
    if (Y>0) {

      if (map1.map[X][Y-1]==1) {
        upWalk= true;
        return 1;
      } else {
        upWalk= false;
        return 0;
      }
    } else {
      upWalk= false;
      return 0;
    }
  }
  int  checkRight (int X, int Y) {
    if (X<COL-1) {

      if (map1.map[X+1][Y]==1) {
        rightWalk= true;
        return 1;
      } else {
        rightWalk= false;
        return 0;
      }
    } else { 
      rightWalk= false;
      return 0;
    }
  }
  int  checkDown (int X, int Y) {
    if (Y<ROW-1) {

      if (map1.map[X][Y+1]==1) {
        downWalk= true;
        return 1;
      } else {
        downWalk= false;
        return 0;
      }
    } else { 
      downWalk= false;
      return 0;
    }
  }
  int  checkLeft (int X, int Y) {
    if (X>0) {

      if (map1.map[X-1][Y]==1) {
        leftWalk= true;
        return 1;
      } else {
        leftWalk= false;
        return 0;
      }
    } else { 
      leftWalk= false;
      return 0;
    }
  }

  void takeInvalue(int X) {
    turnDirection= expand(turnDirection, X-1);
    if (direction==down) {
      upWalk=false;
    }
    if (direction==up) {
      downWalk=false;
    }
    if (direction==left) {
      rightWalk=false;
    }
    if (direction==right) {
      leftWalk=false;
    }

    for (int Num=0; Num<X-1; Num++) {
      if (upWalk) {
        turnDirection[Num]= "up";
        upWalk=false;
      } else       if (downWalk) {
        turnDirection[Num]= "down";
        downWalk=false;
      } else       if (leftWalk) {
        turnDirection[Num]= "left";
        leftWalk=false;
      } else       if (rightWalk) {
        turnDirection[Num]= "right";
        rightWalk=false;
      }
    }
    int TurnNum= floor(random(turnDirection.length));
    String finalTurn= turnDirection[TurnNum];
    if (finalTurn=="up") {
      direction=up;
    } else
      if (finalTurn=="right") {
        direction=right;
      } else
        if (finalTurn=="down") { 
          direction=down;
        } else
          if (finalTurn=="left") {
            direction=left;
          }
  }
}