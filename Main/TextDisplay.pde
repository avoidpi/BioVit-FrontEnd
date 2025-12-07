public class TextDisplay{ //i created this class to more reliably center text, plus saving color and fontsize with no room for error
  float x;
  float y;
  float tsize;
  StringBuffer Body;
  color c;
  TextDisplay(float tsize, color c, StringBuffer Body){
    this.tsize = tsize;
    this.Body = Body;
    this.c = c;
  }
  
  void updateDim(int tsize){
    this.tsize = tsize;
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
  
  void displayCenteredDim(float ix,float iy,float dimx,float dimy){
    textSize(tsize);
    fill(c);
    float tWidth = textWidth(Body.toString());
    float tHeight = textAscent();
    x = ix + ((dimx)/2) - (tWidth/2);
    y = iy + ((dimy)/2) + (tHeight/2);
    text(Body.toString(),x,y);
  }
}
