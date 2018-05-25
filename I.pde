class I {
  PImage img;
  PImage player[][];
  int size=100;
  int a[] ={0, 1, 0, 2};
  int s=0;
  int state;
  int direction;
  final int down=0;
  final int up=1;
  final int left=2;
  final int right=3;
  float x, y;
  boolean leftState = false;
  boolean rightState = false;
  boolean downState = false;
  boolean upState = false;
  boolean isMoving=false;
  int col, row;
  final int MY_RIGHT_OFFSET=96;
  final int MY_LEFT_OFFSET=86;
  final int MY_UP_OFFSET=56;
  int moveTimer;
  int moveDirection;
  int moveDuration =30;

  I() {
    player=new PImage[4][3];
    for (int i=0; i<4; i++) {
      for (int j=0; j<3; j++) {
        player[i][j]=loadImage("img/player/player"+i+j+".png");
      }
    }    
    x=0;
    y=0;
  }

  void display() { 
    if (moveTimer>0) {
      img=player[direction][a[s/4]];
    } else {
      img=player[direction][0];
    }
    image(img, x, y-10, size, size);
    s++;
    s%=16;
  }




  void update() {

    if (moveTimer == 0) {



      if (leftState) {


        // Check left boundary
        if (col > 0) {
          moveDirection = LEFT;

          if (map1.map[col-1][row]==1 ) {


            moveTimer = moveDuration;
          }
        }
      } else if (rightState) {


        // Check right boundary
        if (col < COL-1) {
          moveDirection = RIGHT;


          if (map1.map[col+1][row]==1 ) {

            moveTimer = moveDuration;
          }
        }
      } else if (downState) {



        if (row < ROW - 1) {
          moveDirection = DOWN;


          if (map1.map[col][row+1]==1 ) {

            moveTimer = moveDuration;
          }            


          // Check bottom boundary
        }
      } else if (upState) {
        if (row>0) {
          moveDirection=UP;
          if (map1.map[col][row-1]==1 ) {

            moveTimer= moveDuration;
          }
        }
      } else {
        // Draw image before moyving to prevent offset
        switch(moveDirection) {
        case LEFT:  
          direction = left;  
          break;
        case RIGHT:  
          direction = right;  
          break;
        case DOWN:  
          direction = down;  
          break;
        case UP: 
          direction = up; 
          break;
        }
      }
    }



    // If player is now moving?

    if (moveTimer > 0) {

      moveTimer --;
      switch(moveDirection) {

      case LEFT:
        direction = left;
        if (moveTimer == 0) {
          col--;
          x = size * col;
        } else {
          x = (float(moveTimer) / moveDuration + col -1f) * size;
        }
        break;

      case RIGHT:
        direction = right;
        if (moveTimer == 0) {
          col++;
          x = size * col;
        } else {
          x = (1f - float(moveTimer) / moveDuration + col) * size;
        }
        break;

      case DOWN:
        direction = down;
        if (moveTimer == 0) {
          row++;
          y = size * row;
        } else {
          y = (1f - float(moveTimer) / moveDuration + row) * size;
        }
        break;

      case UP:
        direction = up;
        if (moveTimer==0) {
          row--;
          y=size*row;
        } else {
          y = (float(moveTimer)/moveDuration +row -1) *size;
        }
        break;
      }
    }
  }
}

void keyPressed() {  

  if (key=='y') {
    keyy=true;
  } else {
    keyy=false;
  }

  if (key==CODED) {

    switch(keyCode) {
    case LEFT:

      i.leftState = true;



      break;
    case RIGHT:
      i.rightState = true;


      break;
    case DOWN:
      i.downState = true;


      break;
    case UP:
      i.upState=true;
    }
  }
}

void keyReleased() {
  if (key==CODED) {
    i.isMoving=false;
    switch(keyCode) {
    case LEFT:
      i.leftState = false;
      break;
    case RIGHT:
      i.rightState = false;
      break;
    case DOWN:
      i.downState = false;
      break;
    case UP:
      i.upState=false;
      break;
    }
  }
}