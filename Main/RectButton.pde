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
  
  RectButton(int ix,int iy,int dimx,int dimy,color borderColor,color innerColor,color hoverColor,color selectedColor, float borderSize){ //constructor
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
  
  void updateDim(int ix,int iy,int dimx,int dimy,float borderSize){ //method to update dimensions in absence of text
    this.ix = ix;
    this.iy = iy;
    this.dimx = dimx;
    this.dimy = dimy;
    this.borderSize = borderSize;
  }
  
  void updateDim(int ix,int iy,int dimx,int dimy,float borderSize,int textDim){ //method to update all dimensions
    this.ix = ix;                                                               //i call it everytime the window dimension changes, because all my dimensions are based on that
    this.iy = iy;
    this.dimx = dimx;
    this.dimy = dimy;
    this.textDim = textDim;
    this.borderSize = borderSize;
    if(textDisplay != null) textDisplay.updateDim(textDim);
  }
  
  void setText(int textDim,color textColor,String text){ //set properties of inside text
    this.textDim = textDim;
    this.textColor = textColor;
    this.text = text;
    textDisplay = new TextDisplay(textDim,textColor,new StringBuffer(text));
  }
  
  void setSelected(boolean s){
    selected = s;
  }
  
  void Page(int bx,int by){
    this.ix = bx; //updates the pos (so everything works when the button is animated)
    this.iy = by;
    Coordinates mc = new Coordinates(mouseX,mouseY); //track cursor pos to update color of buttons in menu
    stroke(borderColor);
    strokeWeight(borderSize);
    fill(innerColor);
    if(selected)fill(selectedColor); //if selected, changes color to show that
    if(mc.squareClosedRangeDim(ix,iy,dimx,dimy))fill(hoverColor); //on hover, changes color
    rect(ix,iy,dimx,dimy);
    stroke(0);
    strokeWeight(1);
    if(text != null){ //tries to display its text only if a body has been set
      textDisplay.displayCenteredDim(ix,iy,dimx,dimy);
    }
  }
  
  boolean isClicked(Coordinates mc){ //returns true if the coordinates are inside its boundaries, to track clicks 
    if(mc.squareClosedRangeDim(ix,iy,dimx,dimy))return true;
    return false;
  }
}
