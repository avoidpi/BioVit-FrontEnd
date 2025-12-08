public class TextLoader{
  
  String Text = null;
  float textDim;
  
  color textColor;
  color frameColor;
  color bgColor;
  
  
  float ix;
  float iy;
  float dimx;
  float dimy;
  
  TextLoader(int frameColor,int bgColor,int textColor){
    this.frameColor = frameColor;
    this.bgColor = bgColor;
    this.textColor = textColor;
  }
  
  void setText(String Text){
    this.Text = Text;
  }
  
  void Page(float ix,float iy,float dimx,float dimy,float textDim){
    strokeWeight(0);
    fill(frameColor);
    rect(ix,iy,dimx,dimy); //frame
    fill(bgColor);
    if(Text != null) text(Text,ix+(dimx/40),iy+(dimy/40),dimx -(dimx/20),dimy -(dimy/20));
  }


}
