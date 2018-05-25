class Map {
  int map[][]=new int [COL][ROW];  
  int mapType[][]=new int [COL][ROW];  
  final int road =1;
  final int house =2;
  final int build0 =3;

  //road
  PImage roadImg[]=new PImage[11];
  final int ROAD_ALL=0;
  final int ROAD_HORIZONTAL=1;
  final int ROAD_STRAIGHT=2;
  final int ROAD_RIGHT_DOWN=3;
  final int ROAD_RIGHT_UP=4;
  final int ROAD_LEFT_UP=5;
  final int ROAD_LEFT_DOWN=6;
  final int ROAD_HORIZONTAL_DOWN=7;
  final int ROAD_STRAIGHT_LEFT=8;
  final int ROAD_HORIZONTAL_UP=9;
  final int ROAD_STRAIGHT_RIGHT=10;

  //house
  PImage houseImg[][]=new PImage[2][4];
  int a[][]=new int[COL][ROW];
  final int HOUSE_DOWN=0;
  final int HOUSE_UP=1;
  final int HOUSE_LEFT=2;
  final int HOUSE_RIGHT=3;

  //build 
  PImage buildImg[]=new PImage[5];

  Map() {
    for (int i=0; i<roadImg.length; i++) {
      roadImg[i]=loadImage("img/road/road"+i+".png");
    }
    for (int i=0; i<buildImg.length; i++) {
      buildImg[i]=loadImage("img/build/build"+i+".png");
    }
    for (int i=0; i<2; i++) {
      for (int j=0; j<4; j++) {
        houseImg[i][j]=loadImage("img/house/house"+i+j+".png");
      }
    }    
    for (int i=0; i<ROW; i++) {
      for (int j=0; j<COL; j++) {
        map[j][i]=0;
      }
    }
    map1Init();
  }

  void display() {
    for (int i=0; i<ROW; i++) {
      for (int j=0; j<COL; j++) {
        if (map[j][i]==road) {
          image(roadImg[mapType[j][i]], j*size, i*size, size, size);
        }
        if (map[j][i]==house) {

          image(houseImg[a[j][i]][mapType[j][i]], j*size, i*size, size, size);
        }
        //**************
        //if (map[j][i]==build0) {
        //  image(buildImg[mapType[j][i]], j*size, i*size, size, size);
        //}
      }
    }
  }

  void map1Init() {



    for (int jj=1; jj<7; jj+=5) {
      for (int ii=1; ii<5; ii+=3) {
        for (int i=0; i<2; i++) {
          for (int j=0; j<4; j++) {
            map[j+jj][i+ii]=house;
            a[j+jj][i+ii]=floor(random(0, 2));
          }
        } 
        mapType[0+jj][0+ii]=mapType[0+jj][1+ii]=HOUSE_LEFT;
        mapType[1+jj][0+ii]=mapType[2+jj][0+ii]=HOUSE_UP;
        mapType[1+jj][1+ii]=mapType[1+jj][2+ii]=HOUSE_DOWN;
        mapType[3+jj][0+ii]=mapType[3+jj][1+ii]=HOUSE_RIGHT;
      }
    }


    map[3][1]=map[1][5]=map[7][5]=map[4][2]=map[8][2]=build0;
    mapType[3][1]=mapType[1][5]=mapType[7][5]=mapType[4][2]=mapType[8][2]=0;

    for (int i=0; i<ROW; i+=3) {
      for (int j=0; j<COL; j++) {
        map[j][i]=road;
        mapType[j][i]=ROAD_STRAIGHT;
      }
    }
    for (int j=0; j<COL; j+=5) {
      for (int i=0; i<ROW; i++) {
        map[j][i]=road;
        mapType[j][i]=ROAD_HORIZONTAL;
      }
    }

    mapType[0][0]=ROAD_LEFT_DOWN;
    mapType[0][ROW-1]=ROAD_LEFT_UP;
    mapType[COL-1][ROW-1]=ROAD_RIGHT_UP;
    mapType[COL-1][0]=ROAD_RIGHT_DOWN;
    mapType[5][0]=ROAD_HORIZONTAL_DOWN;
    mapType[5][ROW-1]=ROAD_HORIZONTAL_UP;
    mapType[5][3]=ROAD_ALL;
    mapType[0][3]=ROAD_STRAIGHT_RIGHT;
    mapType[10][3]=ROAD_STRAIGHT_LEFT;

    feelInit();
    buildInit();
  }
  void feelInit() {
    int feelNum=0;
    for (int i=0; i<COL; i++) {
      for (int j=0; j<ROW; j++) {
        if (map[i][j]==house) {
          feel[feelNum]=new Feel(i, j);
          feelNum++;
          feel = (Feel[]) expand(feel, feelNum+1);
        }
      }
    }    
    feel = (Feel[]) shorten(feel);
  }
  void buildInit() {    
    int buildNum=0;
    for (int i=0; i<COL; i++) {
      for (int j=0; j<ROW; j++) {
        if (map[i][j]==build0) {
          build[buildNum]=new Build(i, j);
          buildNum++;
          build = (Build[]) expand(build, buildNum+1);
        }
      }
    }    
    build = (Build[]) shorten(build);
  }
}