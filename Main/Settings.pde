public class Settings{
  int anim = height - height/64 - height/18;
  int open = -1;
  int v = 15;
  
  Settings(){
  }
  void Setup(){
    anim = height - height/64 - height/18;
  }

  void Page(){
    strokeWeight(5);
    if(open == 1){
      anim = anim-v;
      if(anim <= 0){
        anim = 0;
        open = 0;
      }
    }
    if(open == -1){
      anim = anim + v;
      if(anim >= height - height/64 - height/18){
        anim = height - height/64 - height/18;
        open = 0;
      }
    }
    stroke(0);
    fill(200,195,156);
    rect(width/2-width/16,height/64+anim,width/8,height/8,width/64);
    fill(240,235,196);
    rect(width/8-width/20,height/6-height/10+anim,width/2 + width/4 + width/10,height/2 + height/4 + width/8,width/32);
    fill(0);
    rect(width/8,height/6+anim,width/2 + width/4,height/2 + height/4,width/64);
    stroke(0);
    strokeWeight(1);
  }

  void click(int px,int py){
    Coordinates pc = new Coordinates(px,py);
    if(pc.squareClosedRange(width/2-width/16,height/64+anim,width/2+width/16,height/6-height/10+anim)){
      if(open!=0) open = open*(-1);
      else if(anim == 0){open = -1;}
      else open = 1;
    }
  }
}
