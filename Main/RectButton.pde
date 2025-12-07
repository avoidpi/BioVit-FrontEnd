public class RectButton{
  int ix;
  int iy;
  int dimx;
  int dimy;
  String text = null;
  int textDim;
  color borderColor;
  color innerColor;
  color hoverColor;
  color selectedColor;
  color textColor;
  float borderSize;
  boolean selected = false;
  TextDisplay textDisplay = null;
  
  RectButton(int ix,int iy,int dimx,int dimy,color borderColor,color innerColor,color hoverColor,color selectedColor, float borderSize){
    this.ix = ix;
    this.iy = iy;
    this.dimx = dimx;
    this.dimy = dimy;
    this.borderColor = borderColor;
    this.innerColor = innerColor;
    this.hoverColor = hoverColor;
    this.selectedColor = selectedColor; 
    this.borderSize = borderSize;
  }
  
  void updateDim(int ix,int iy,int dimx,int dimy,float borderSize){
    this.ix = ix;
    this.iy = iy;
    this.dimx = dimx;
    this.dimy = dimy;
    this.borderSize = borderSize;
  }
  
  void updateDim(int ix,int iy,int dimx,int dimy,float borderSize,int textDim){
    this.ix = ix;
    this.iy = iy;
    this.dimx = dimx;
    this.dimy = dimy;
    this.textDim = textDim;
    this.borderSize = borderSize;
    if(textDisplay != null) textDisplay.updateDim(textDim);
  }
  
  void setText(int textDim,color textColor,String text){
    this.textDim = textDim;
    this.textColor = textColor;
    this.text = text;
    textDisplay = new TextDisplay(textDim,textColor,new StringBuffer(text));
  }
  
  void setSelected(boolean s){
    selected = s;
  }
  
  void Page(int bx,int by){
    this.ix = bx;
    this.iy = by;
    Coordinates mc = new Coordinates(mouseX,mouseY); //track cursor pos to update color of buttons in menu
    stroke(borderColor);
    strokeWeight(borderSize);
    fill(innerColor);
    if(selected)fill(selectedColor);
    if(mc.squareClosedRangeDim(ix,iy,dimx,dimy))fill(hoverColor);
    rect(ix,iy,dimx,dimy);
    stroke(0);
    strokeWeight(1);
    if(text != null){
      textDisplay.displayCenteredDim(ix,iy,dimx,dimy);
    }
  }
  
  boolean isClicked(Coordinates mc){
    if(mc.squareClosedRangeDim(ix,iy,dimx,dimy))return true;
    return false;
  }
}
