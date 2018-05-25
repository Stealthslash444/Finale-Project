import ddf.minim.*; //<>// //<>//
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioSample beseen;
AudioSample freddy;
AudioSample bgm1;
AudioSample nervous;
AudioSample police;
AudioInput in;
AudioSample sad;
AudioSample coin;
AudioSample victory;
AudioSample mission;
boolean keyy=false;

PFont myFont;
int size= 100;
int ROW=7, COL=11;
final int RESIDENTS=1000;
final int village=11;
int gameState=0;

final int start=0;
final int stage1=1;
final int DAYOFF=2;
final int VOTE=4;
final int GETCAUGHT=5;
final int CAUGHTNFAIL=6;
final int LOSE =7;
final int TUTORIAL=8;
final int RIOT=9;
final int WIN=10;
final int DAYSTART=11;
final int PARTY=12;


int counter=0;
int drawCounter=60;
int myVotes;
int hisVotes;

int numbercounter=0;
int textCounter=0;
int caughtCounter=0;
int moveCounter=0;
boolean charged =false;
boolean clicked=false;
//for Police

boolean action;
//for DAYSTART

PFont fontForCaught;
PFont fontForUI;

boolean smoke1, smoke2, smoke1Done;

int rollCounter=width;
final int ROLLSPEED=20;

PImage imgStart, badge, vote;
PImage goToJail, riot, lose1, lose0, win;
PImage howToPlay0, howToPlay1, howToPlay2, howToPlay3;
PImage confirm, cancel;
PImage dayPic[];
int day;
final int STARTDAY=7;
final int MAXDAY=14;
float badgeX, badgeY;


//music
boolean isFreddyed=false;
int freddytime=0;
boolean ismission=false;
int missiontime=0;
Police test;
Money money1;
Feel feel[]=new Feel[1];
Build build[]=new Build[1];
I i;
Map map1;
Red red;
Popularity popularity1;
Clock clock;
Number number[]=new Number[6];
Pollution pollution;
Party party;
Building building;
//
int lose;
int debugpress=10;

void setup() {
  size(1100, 800, P2D);
  red=new Red();
  test=new Police();
  i=new I();
  money1=new Money();
  popularity1=new Popularity();
  test.state=test.INIT;
  clock=new Clock();
  pollution= new Pollution();
  building=new Building() ;
  party=new Party();

  fontForCaught=createFont("微軟正黑體", size);
  fontForUI=createFont("SetoFont", size*1.5);

  imgStart=loadImage("img/start.jpg");
  badge=loadImage("img/badge.png");
  vote=loadImage("img/gameState/vote.jpg");

  confirm=loadImage("img/button/confirm.png");
  cancel=loadImage("img/button/cancel.png");

  goToJail=loadImage("img/gameState/goToJail-01.jpg");
  riot=loadImage("img/gameState/riot-01.jpg");
  lose0=loadImage("img/gameState/lose0.jpg");
  lose1=loadImage("img/gameState/lose1.jpg");
  howToPlay0=loadImage("img/gameState/howToPlay/howToPlay0-01.jpg");
  howToPlay1=loadImage("img/gameState/howToPlay/howToPlay1-01.jpg");
  howToPlay2=loadImage("img/gameState/howToPlay/howToPlay2-01.jpg");
  howToPlay3=loadImage("img/gameState/howToPlay/howToPlay3-01.jpg");
  win=loadImage("img/gameState/win-01.jpg");

  dayPic= new PImage [MAXDAY];
  for (int d=0; d<MAXDAY; d++) {
    dayPic[d]=loadImage("img/gameState/calendar/calendar"+(d+1)+"-01.jpg");
  }

  minim=new Minim(this);
  beseen=minim.loadSample("music/beseen.mp3", 128);
  freddy=minim.loadSample("music/freddy.mp3", 128);  
  bgm1=minim.loadSample("music/bgm1.wav", 128);
  nervous=minim.loadSample("music/nervous.mp3", 128);
  police=minim.loadSample("music/police.mp3", 128);
  sad=minim.loadSample("music/sad.mp3", 128);
  coin=minim.loadSample("music/coin.mp3", 128);
  victory=minim.loadSample("music/victory.mp3", 128);
  mission=minim.loadSample("music/mission.mp3", 256);
  mission.setVolume(5);

  badgeX=(float)31/88*width;
  badgeY=(float)378/560*height;
  for (int i=0; i<COL; i++) {
    for (int j=0; j<ROW; j++) {
      red.isReded[i][j]=false;
    }
  }
  myFont = createFont("微軟正黑體", 100);
  textFont(myFont);
}

void draw() {
  if (gameState!=stage1) {
    mission.stop();
    ismission=false;
  }
  switch(gameState) {
  case start:
    image(imgStart, 0, 0, width, height);
    if (isFreddyed==false) {
      freddy.trigger();
      isFreddyed=true;
    }
    if (freddytime>(freddy.length()/1000)*60) {
      freddytime=0;
      isFreddyed=false;
    }
    freddytime++;
    if (dist(mouseX, mouseY, badgeX+size/2, badgeY+size/2)<=size/2) {      
      if (mousePressed) {
        fill(255);
        textSize(size/3);
        textAlign(LEFT, BOTTOM);
        text("loaded", badgeX+310, badgeY+65);
        map1=new Map();
        gameState=TUTORIAL;
        smoke1=false;
        smoke1Done=false;
        smoke2=false;
        day=STARTDAY;

        pollution= new Pollution();
      }
      image(badge, badgeX, badgeY, size, size);
    }
    break;

  case TUTORIAL:
    if (isFreddyed==false) {
      freddy.trigger();
      isFreddyed=true;
    }
    if (freddytime>(freddy.length()/1000)*60) {
      freddytime=0;
      isFreddyed=false;
    }
    freddytime++;
    if (mousePressed&&textCounter<5) {
      if (clicked==false) {
        textCounter++;
        rollCounter=width;
        clicked=true;
      }
    } else {
      if (clicked==true) {
        clicked=false;
      }
    }
    switch(textCounter) {
    case 1:
      image(howToPlay0, 0+rollCounter, 0, width, height);
      if (rollCounter>0) {
        rollCounter-=ROLLSPEED;
        rollCounter= max(rollCounter, 0);
      } else {
        break;
      }
      break;



    case 2:
      image(howToPlay0, 0, 0, width, height);
      image(howToPlay1, 0+rollCounter, 0, width, height);
      if (rollCounter>0) {
        rollCounter-=ROLLSPEED;
        rollCounter= max(rollCounter, 0);
      } else {
        break;
      }
      break;

    case 3:
      image(howToPlay1, 0, 0, width, height);
      image(howToPlay2, 0+rollCounter, 0, width, height);
      if (rollCounter>0) {
        rollCounter-=ROLLSPEED;
        rollCounter= max(rollCounter, 0);
      } else {
        break;
      }
      break;

    case 4:
      image(howToPlay2, 0, 0, width, height);
      image(howToPlay3, 0+rollCounter, 0, width, height);
      if (rollCounter>0) {
        rollCounter-=ROLLSPEED;
        rollCounter= max(rollCounter, 0);
      } else {
        break;
      }
      break;

    case 5:
      image(howToPlay3, 0, 0, width, height);
      fill(0, counter);
      rect(0, 0, width, height);
      if (counter<255)    counter+=2;
      else {
        freddy.stop();
        map1=new Map();
        gameState=DAYSTART;
        textCounter=0;
        action=false;


        break;
      }
    }
    break;

  case DAYSTART:

    image(dayPic[day-1], 0, 0, width, height);

    fill(0, counter);
    rect(0, 0, width, height);
    fill(0);
    textAlign(LEFT, TOP);
    if (day<10) {
      textSize(size);
      text("DAY"+day, 820, 580);
    } else if (day<14) {
      textSize(size*0.8);
      text("DAY"+day, 815, 585);
    } else {
      fill(255, 0, 0);
      textSize(size);
      text("FINAL DAY", 300, 550);
    }

    if (counter>0&&action==false) { 
      counter-=2;
      action=false;
    } else {
      if (mousePressed) {
        action=true;
      }
    }
    if (action) {

      if (counter<255)    counter+=2;

      else { 
        if (day==14) {
          clock.time=clock.timeParty;
          gameState=PARTY;
          in=minim.getLineIn();
        } else {    
          if (getBuildingNum()>=4&&smoke1Done==false) {
            smoke1=true;
          }
          if ( getBuildingNum()>=5&&smoke1Done==true) {
            smoke2=true;
          }
          gameState=stage1;
          mission.trigger();
          ismission=false;
          counter=0;
          action=false;
        }
      }
    }
    break;




  case stage1:
    background(125);
    fill(255);
    strokeWeight(20);
    stroke(255, 209, 93);
    rect(0, 700-20, width, 800-20);
    if (ismission==false) {
      mission.trigger();
      ismission=true;
    }
    if (missiontime>(mission.length()/1000)*60) {
      missiontime=0;
      ismission=false;
    }
    missiontime++;
    //println(ismission, missiontime, (mission.length()/1000)*60);
    map1.display();
    money1.display(650, 760);
    popularity1.display();
    i.display();
    clock.display();
    if (smoke1&&!smoke1Done) {
      fill(0, counter);
      rect(0, 0, width, height);
      building.display();
      for (int i=0; i<build.length; i++) {
        build[i].display();
      }
      if (counter<125)    counter++;
      else {
        fill(255);
        strokeWeight(5);
        rect(100, 150, 900/drawCounter, 300/drawCounter);
        if (drawCounter>1) 
          drawCounter--;
        else { 
          if (mousePressed&&textCounter<4) {
            if (clicked==false) {
              textCounter++;

              clicked=true;
            }
          } else {
            if (clicked==true) {
              clicked=false;
            }
          }
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {
          case 0:
            text("喂，你有沒有看過我們？我們就是住", 125, 200);
            text("這裡的人啦！", 125, 275);
            break;
          case 1:
            text("我警告你喔，不要再亂蓋了！不然下", 125, 200);
            text("次我們就蓋你布袋！", 125, 275);
            break;
          case 2:
            text("你要是敢再給我多蓋，我們就打到你", 125, 200);
            text("媽都認不出來，", 125, 275);
            break;
          case 3:
            text("讓你體驗一下臉被鮮血汙染，會是什", 125, 200);
            text("麼樣的感覺！", 125, 275);

            break;

          case 4:
            smoke1Done=true;
            gameState=DAYOFF;
            textCounter=0;
            counter=0;
            drawCounter=60;
            break;
          }
        }
      }
    } else if (smoke2) {
      fill(0, counter);
      rect(0, 0, width, height);
      building.display();
      for (int i=0; i<build.length; i++) {
        build[i].display();
      }
      if (counter<125)    counter++;
      else {
        fill(255);
        strokeWeight(5);
        rect(100, 150, 900/drawCounter, 300/drawCounter);
        if (drawCounter>1) 
          drawCounter--;
        else { 
          if (mousePressed&&textCounter<4) {
            if (clicked==false) {
              textCounter++;

              clicked=true;
            }
          } else {
            if (clicked==true) {
              clicked=false;
            }
          }
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {

          case 0:
            text("TMD都叫你不要蓋了你還給我蓋？", 125, 200);
            text("真的不把我們放在眼裡是吧？", 125, 275);
            break;
          case 1:
            text("對不起不會再犯了？道歉有用要警察", 125, 200);
            text("幹嘛？", 125, 275);
            break;
          case 2:
            text("布袋都幫你挑好了壯漢也準備好了，", 125, 200);
            text("來吧！就差你沒進布袋了。", 125, 275);
            break;
          case 3:
            text("給錢？你以為我們這麼好收買嗎？兄", 125, 200);
            text("弟們，上啊！", 125, 275);
            break;
          case 4:
            textCounter=0;
            drawCounter=60;
            gameState=RIOT;

            break;
          }
        }
      }
    } else {

      clock.update();
      test.update();
      i.update(); 

      for (int i=0; i<feel.length; i++) {
        feel[i].display();
      }
      for (int i=0; i<build.length; i++) {
        build[i].display();
      }
      pollution.display();
      building.display();

      if (red.reding) {
        if (keyPressed&&key!=' ') {
          red.reding=false;
        }
        if (red.counter>0&&red.reding) {
          red.display();
          red.counter--;
          money1.money-=((float)money1.moneyRed/red.counter_max);
        } else {
          if (red.counter==0)   popularity1.popularity+=popularity1.popularityRed;

          red.counter=red.counter_max;
          red.isReded[red.col][red.row]=true;
          red.reding=false;
        }
      }

      if (keyPressed&&key=='t') {
        gameState=DAYOFF;
      }
      if (keyPressed&&key=='p') {
        clock.time=clock.timeParty;
        gameState=PARTY;
        in=minim.getLineIn();
      }
      if (keyPressed&&key=='a') {
        popularity1.popularity+=10;
      }
      if (keyPressed&&key=='m') {
        money1.money+=100;
      }
    }
    break;

  case DAYOFF:

    map1.display();
    money1.display(650, 760);
    popularity1.display();
    clock.display();
    i.display();
    for (int i=0; i<build.length; i++) {
      build[i].display();
      build[i].stateUpdate();
      println(build[i].state);
    }
    fill(0, counter);
    rect(0, 0, width, height);
    if (counter<255)    counter++;
    else {

      pollution.update(getBuildingNum());
      clock.time=clock.timeMax;
      test=new Police();
      i=new I();
      i.x=0;
      i.y=0;
      map1.feelInit();
      for (int i=0; i<COL; i++) {
        for (int j=0; j<ROW; j++) {
          red.isReded[i][j]=false;
        }
      }
      red.counter=red.counter_max;
      red.isReded[red.col][red.row]=true;
      red.reding=false;
      money1.money+=money1.moneyDaily;      
      money1.money+=1500*building.building;
      gameState=DAYSTART;
      popularity1.popularity+=popularity1.popularityDaily;
      day++;
    }

    break;

  case GETCAUGHT:


    map1.display();
    money1.display(800, 760);
    popularity1.display();
    clock.display();
    i.display();
    test.display(test.policeAngry);




    fill(0, counter);     
    rect(0, 0, width, height-100);
    if (counter<125)    counter++;

    else { 


      fill(255);
      strokeWeight(5);
      rect(100, 150, 900/drawCounter, 300/drawCounter);
      if (drawCounter>1) 
        drawCounter--;
      else {
        if (mousePressed&&textCounter<=3) {
          if (clicked==false) {
            textCounter++;
            clicked=true;
          }
        } else {
          if (clicked==true) {
            clicked=false;
          }
        }
        switch(caughtCounter) {
        case 1:
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {
          case 0:
            text("哎呀，你這個好像不太行喔！根據選罷", 125, 200);
            text("法是要被關的。", 125, 275);
            break;
          case 1:
            text("恩…..你說你要給我紅包？我這樣有點難", 125, 200);
            text("為情耶！", 125, 275);
            break;
          case 2:
            textSize(40);
            text("啊哈哈…….好啦你要給我飯錢也不是不行，我今", 130, 200);
            text("天這頓飯要……. 1000元！", 130, 275);
            money1.display(500, 400);

            break;
          case 3:            
            if (money1.money>=1000&&charged==false) {
              money1.money-=1000;
              charged=true;
            }
            if (charged==true) {
              text("嘿嘿嘿嘿！謝謝你啦，我肚子好飽！下", 125, 200);
              text("一次再見面啊！", 125, 275);
              money1.display(500, 400);
              break;
            } else if (charged==false) {  
              text("霞？你沒有錢？來來來跟我走！身為警", 125, 200);
              text("察怎麼能不把你繩之以法！", 125, 275);
              break;
            }
          case 4:
            if (charged==true) {

              if (moveCounter<180) {
                moveCounter++;
                test.state=test.INIT;
                test.update();
              } else {
                map1.feelInit();
                for (int i=0; i<COL; i++) {
                  for (int j=0; j<ROW; j++) {
                    red.isReded[i][j]=false;
                    break;
                  }
                }

                gameState=stage1;
                counter=0;
                drawCounter=60;
                textCounter=0;
                moveCounter=0;
                charged=false;
                break;
              }
            } else if (charged==false) { 

              gameState= CAUGHTNFAIL;
              police.trigger();
              break;
            }
          }
          break;

        case 2:
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {
          case 0:
            text("诶？小妹妹？怎麼又見到妳啦？還在做", 125, 200);
            text("這個喔？真的很不上道ㄟ～", 125, 275);
            break;
          case 1:
            text("蝦？飯錢？我今天吃飽了耶！我可能需", 125, 200);
            text("要……酒吧錢！", 125, 275);
            break;
          case 2:
            text("哈哈哈沒有啦貪財貪財，酒吧錢就來個", 125, 200);
            text("3000元吧！", 125, 275);
            money1.display(500, 400);

            break;
          case 3:            
            if (money1.money>=3000&&charged==false) {
              money1.money-=3000;
              charged=true;
            }
            if (charged==true) {
              text("哈哈哈...啊！我酒喝太多了看不清楚前", 125, 200);
              text("面的人是誰？算了應該沒有人…吧？", 125, 275);
              money1.display(500, 400);
              break;
            } else if (charged==false) {  
              text("霞？你沒有錢？來來來跟我走！身為警", 125, 200);
              text("察怎麼能不把你繩之以法！", 125, 275);
              break;
            }
          case 4:
            if (charged==true) {

              if (moveCounter<180) {
                moveCounter++;
                test.state=test.INIT;
                test.update();
              } else {
                map1.feelInit();
                for (int i=0; i<COL; i++) {
                  for (int j=0; j<ROW; j++) {
                    red.isReded[i][j]=false;
                    break;
                  }
                }

                gameState=stage1;
                counter=0;
                drawCounter=60;
                textCounter=0;
                moveCounter=0;
                charged=false;
                break;
              }
            } else if (charged==false) { 
              police.trigger();
              gameState= CAUGHTNFAIL;

              break;
            }
          }
          break;

        case 3:
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {
          case 0:
            text("嘿嘿嘿！小妹妹，我們怎～麼又見面啦？", 105, 200);
            text("這次這個樣子你又要怎麼辦呢？", 125, 275);
            break;
          case 1:
            text("蝦？沒啦沒啦，只是我想到之前你請我", 125, 200);
            text("喝酒，這次想請你幫我補個油錢而已～", 125, 275);
            break;
          case 2:
            text("怎麼樣？不過我的油不是普~通的油，可", 105, 200);
            text("是要5000元喔！怎麼樣？有沒有錢啊？", 125, 275);
            money1.display(500, 400);

            break;
          case 3:            
            if (money1.money>=5000&charged==false) {
              money1.money-=5000;
              charged=true;
            }
            if (charged==true) {
              textSize(42);
              text("嘿嘿嘿！不錯不錯！小妹妹你也是有錢人啊！", 130, 200);
              text("不過自己要小心一點ㄟ，上面有人在問喔～", 130, 275);
              money1.display(500, 400);
              break;
            } else if (charged==false) {  
              text("霞？你沒有錢？來來來跟我走！身為警", 125, 200);
              text("察怎麼能不把你繩之以法！", 125, 275);
              break;
            }

          case 4:

            if (charged==true) {

              if (moveCounter<180) {
                moveCounter++;
                test.state=test.INIT;
                test.update();
              } else {
                map1.feelInit();
                for (int i=0; i<COL; i++) {
                  for (int j=0; j<ROW; j++) {
                    red.isReded[i][j]=false;
                    break;
                  }
                }

                gameState=stage1;
                counter=0;
                drawCounter=60;
                textCounter=0;
                moveCounter=0;
                charged=false;
                break;
              }
            } else if (charged==false) { 
              police.trigger();
              gameState= CAUGHTNFAIL;

              break;
            }
          }
          break;




        case 4:
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {
          case 0:
            text("小妹妹！都警告過你了還要幹這個！你", 125, 200);
            text("這樣我真的不得不抓你了喔！", 125, 275);
            break;
          case 1:
            text("哈哈哈！騙你的啦！如果你有辦法給我", 125, 200);
            text("…嘿嘿嘿~你懂的啦，都這麼多次了！", 125, 275);
            break;
          case 2:
            text("哈哈，真上進！不過這次我還是要多一", 125, 200);
            text("點！我要10000才夠！", 125, 275);
            money1.display(500, 400);

            break;
          case 3:            
            if (money1.money>=10000&&charged==false) {
              money1.money-=10000;
              charged=true;
            }
            if (charged==true) {
              text("哈哈哈～真是乖！好啦我要走了，等等", 125, 200);
              text("好像有一個政治人物要來找我…", 125, 275);
              money1.display(500, 400);
              break;
            } else if (charged==false) {  
              text("霞？你沒有錢？來來來跟我走！身為警", 125, 200);
              text("察怎麼能不把你繩之以法！", 125, 275);
              break;
            }
          case 4:
            if (charged==true) {

              if (moveCounter<180) {
                moveCounter++;
                test.state=test.INIT;
                test.update();
              } else {
                map1.feelInit();
                for (int i=0; i<COL; i++) {
                  for (int j=0; j<ROW; j++) {
                    red.isReded[i][j]=false;
                    break;
                  }
                }

                gameState=stage1;
                counter=0;
                drawCounter=60;
                textCounter=0;
                moveCounter=0;
                charged=false;
                break;
              }
            } else if (charged==false) { 
              police.trigger();
              gameState= CAUGHTNFAIL;

              break;
            }
          }
          break;
        case 5:
          textFont(fontForCaught);
          textSize(size/2);
          fill(0);
          switch(textCounter) {
          case 0:
            text("哎呀！怎麼又是你啊，小妹妹？今天還", 125, 200);
            text("真是走運啊～", 125, 275);
            break;
          case 1:
            text("蝦？有錢拿？當然不是啊！我是終於可", 125, 200);
            text("以升官了！", 125, 275);
            break;
          case 2:
            text("為什麼喔？因為你們的競爭對手說把你", 125, 200);
            text("抓起來，我就可以當警察局長啊～", 125, 275);
            money1.display(500, 400);

            break;
          case 3:            

            text("給我錢？沒有沒有～這次錢也救不了你", 125, 200);
            text("，我總算可以當局長了，哈哈哈哈哈！", 125, 275);

            break;
          case 4:

            police.trigger();
            gameState= CAUGHTNFAIL;

            break;
          }
        }
      }
      break;
    }
    break;



  case CAUGHTNFAIL: 
    image( goToJail, 0, 0, width, height);
    fill(0, counter);
    rect(0, 0, width, height);
    if (counter>0) counter--;
    else if (mousePressed) {
      red=new Red();
      test=new Police();
      i=new I();
      money1=new Money();
      popularity1=new Popularity();
      test.state=test.INIT;
      clock=new Clock();
      counter=0;
      drawCounter=60;
      textCounter=0;
      caughtCounter=0;
      i.x=0;
      i.y=0;
      gameState=start;
      police.stop();
      freddy.trigger();
      break;
    }
    break;

    //
  case VOTE:
    image(vote, 0, 0, width, height);
    if (numbercounter<6)
      runNumber(numbercounter);    
    else {
      for (int j=0; j<=5; j++) {
        number[j].display();
      }
      if (mousePressed) {
        lose=floor(random(0, 2)); 
        if (myVotes>hisVotes) {
          gameState=WIN;
          victory.trigger();
        } else {
          gameState=LOSE;
          sad.trigger();
        }
        bgm1.stop();
      }
    }
    break;

  case LOSE:
    debugpress--;
    if (lose==1)
      image( lose1, 0, 0, width, height);
    if (lose==0)
      image( lose0, 0, 0, width, height);
    if (mousePressed&&debugpress<=0) {
      red=new Red();
      test=new Police();
      i=new I();
      money1=new Money();
      popularity1=new Popularity();
      test.state=test.INIT;
      clock=new Clock();
      counter=0;
      drawCounter=60;
      textCounter=0;
      caughtCounter=0;
      i.x=0;
      i.y=0;
      debugpress=10;
      gameState=start;
      sad.stop();
      numbercounter=0;
      break;
    }
    break;

  case RIOT:
    image( riot, 0, 0, width, height);
    fill(0, counter);
    rect(0, 0, width, height);
    if (counter>0) counter--;
    else if (mousePressed) {
      red=new Red();
      test=new Police();
      i=new I();
      money1=new Money();
      popularity1=new Popularity();
      test.state=test.INIT;
      clock=new Clock();
      counter=0;
      drawCounter=60;
      textCounter=0;
      caughtCounter=0;
      i.x=0;
      i.y=0;
      debugpress=10;
      gameState=start;

      break;
    }
    break;

  case WIN:
    debugpress--;
    image( win, 0, 0, width, height);
    //if (counter>0) counter--;
    //else 
    if (mousePressed&& debugpress<0) {
      red=new Red();
      test=new Police();
      i=new I();
      money1=new Money();
      popularity1=new Popularity();
      test.state=test.INIT;
      clock=new Clock();
      counter=0;
      drawCounter=60;
      textCounter=0;
      caughtCounter=0;
      i.x=0;
      i.y=0;
      gameState=start;
      numbercounter=0;
      break;
    }
    break;

  case PARTY:
    party.display();
    popularity1.display();
    clock.update();
    clock.display();

    break;
  }
}


boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  if ((3*ax/2-3*bx/2<=10&&3*ax/2-3*bx/2>=-10) && (3*ay/2-3*by/2<=10&&3*ay/2-3*by/2>=-10)) {
    return true ;
  } else {
    return false;
  }
}

void runNumber(int i) {
  if (counter>0) {    
    number[i].number++;
    number[i].number%=10;
    counter--;
  } else {
    number[i].number=number[i].finalNumber;
    numbercounter++;
    counter=60*3;
  }
  if (numbercounter<6)
    for (int j=0; j<=numbercounter; j++) {
      number[j].display();
    }
}

int getBuildingNum() {
  int Num=0;
  for (int i=0; i<build.length; i++) {
    if (build[i].isbuild) {
      Num++;
    }
  }
  return Num;
}

//
void prevote() {
  in.close();
  bgm1.trigger();
  float myper=(float)popularity1.popularity/1378;
  float hisper=(float)1-myper;    
  float population=floor(random(999, 1500));
  while (population*myper>=1000|population*hisper>=1000) {
    population=floor(random(999, 1500));
  }
  myVotes=ceil(population*myper);
  hisVotes=ceil(population*hisper);
  counter=60*3;
  number[5]=new Number(130, 500);
  number[4]=new Number(210, 500);
  number[3]=new Number(290, 500);
  number[2]=new Number(700, 500);
  number[1]=new Number(780, 500);
  number[0]=new Number(860, 500);      
  number[2].finalNumber=(floor(hisVotes/100))%10;
  number[1].finalNumber=(floor(hisVotes/10))%10;
  number[0].finalNumber=hisVotes%10;
  number[5].finalNumber=(floor(myVotes/100))%10;
  number[4].finalNumber=(floor(myVotes/10))%10;
  number[3].finalNumber=myVotes%10;
}