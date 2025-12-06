public class TextDisplay{ //i created this class to more reliably center text, plus saving color and fontsize with no room for error
  float x;
  float y;
  float tsize;
  StringBuffer Body;
  color c;
  TextDisplay(float x,float y, float tsize, color c, StringBuffer Body){
    this.x = x;
    this.y = y;
    this.tsize = tsize;
    this.Body = Body;
    this.c = c;
  }
  
  void displayCentered(float ix,float iy,float fx,float fy){
    textSize(tsize);
    fill(c);
    float tWidth = textWidth(Body.toString());
    float tHeight = textAscent();
    x = ix + ((fx - ix)/2) - (tWidth/2);
    y = iy + ((fy - iy)/2) + (tHeight/2);
    text(Body.toString(),x,y);
  }
}
