class Party {

  PImage img[]=new PImage[12];
  int state=0;
  int high=1;

  Party() {
    for (int i=0; i<img.length; i++) {
      img[i]=loadImage("img/gameState/party/party"+i+".jpg");
    }
  }
  
  void display(){
  state+=1;
  if(floor(random(5))==1)
  popularity1.popularity+=(high/3);
  high=floor(map(in.mix.level(),0,1,1,12));
  state%=high;
  image(img[state],0,0,width,height);
  }
}