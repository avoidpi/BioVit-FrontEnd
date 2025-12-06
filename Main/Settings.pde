public class Settings{


void Page(){
  stroke(0);
  fill(240,235,196);
  rect(width/2-width/16,height/64,width/8,height/8,width/64);
  rect(width/8-width/20,height/6-height/10,width/2 + width/4 + width/10,height/2 + height/4 + width/8,width/32);
  fill(0);
  rect(width/8,height/6,width/2 + width/4,height/2 + height/4,width/64);
  stroke(0);
}

  void click(int px,int py){
    Coordinates pc = new Coordinates(px,py);
    if(pc.squareClosedRange(width/2-width/16,height/64,width/2+width/16,height/6-height/10))sWindow = false;
  }
}
