public class Settings{
  float anim = height - height/64 - height/18;
  int open = -1;
  float v = width/96;
  int lastseldim = 2;
  float buttonbordersize = width/288;
  TextDisplay resText;
  RectButton resButton1;
  RectButton resButton2;
  RectButton resButton3;
  
  TextDisplay extText;
  RectButton extButton1;
  RectButton extButton2;
  RectButton extButton3;
  
  Settings(){
  }
  
  void Setup(){ //this HAS to run in Main.setup() after the size has been chosen or height and width will not have accurate dimensions
    v = width/96;
    buttonbordersize = width/288;
    anim = height - height/64 - height/18;
    resText = new TextDisplay(width/30,GREEN,new StringBuffer("RESOLUTION")); //res text
    extText = new TextDisplay(width/30,GREEN,new StringBuffer("EXTENSION"));
    
    resButton1 = new RectButton(width/8 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKGREEN,DARKERGREEN,buttonbordersize);
    resButton1.setText(width/50,GREEN,"1440x810");
    resButton2 = new RectButton(width/8 + width/8 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKGREEN,DARKERGREEN,buttonbordersize);
    resButton2.setText(width/50,GREEN,"1280x720");
    resButton3 = new RectButton(width/8 + width/4 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKGREEN,DARKERGREEN,buttonbordersize);
    resButton3.setText(width/50,GREEN,"960x540");
    
    extButton1 = new RectButton(width/8 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKGREEN,DARKERGREEN,buttonbordersize);
    extButton1.setText(width/50,GREEN,".jpg");
    extButton2 = new RectButton(width/8 + width/8 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKGREEN,DARKERGREEN,buttonbordersize);
    extButton2.setText(width/50,GREEN,".png");
    extButton3 = new RectButton(width/8 + width/4 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKGREEN,DARKERGREEN,buttonbordersize);
    extButton3.setText(width/50,GREEN,".tga");
  }
  
  void update(){ //this runs everytime the window gets resized, resizing the dimensions of buttons and text
    v = width/96;
    buttonbordersize = width/288;
    resText.updateDim(width/30);
    extText.updateDim(width/30);
    
    resButton1.updateDim(width/8 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,buttonbordersize,width/50);
    resButton2.updateDim(width/8 + width/8 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,buttonbordersize,width/50);
    resButton3.updateDim(width/8 + width/4 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,buttonbordersize,width/50);
    
    extButton1.updateDim(width/8 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,buttonbordersize,width/50);
    extButton2.updateDim(width/8 + width/8 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,buttonbordersize,width/50);
    extButton3.updateDim(width/8 + width/4 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,buttonbordersize,width/50);
  }
  
  void updateAnim(){ //this runs everytime the window gets resized and the animation isn't moving (open !=0) to fix a small bug with the position of the settings window
    if(open == -1){
      anim = height - height/64 - height/18;
    }
    if(open == 1){
      anim = 0;
    }
  }

  void Page(){
    strokeWeight(width/480);
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
    rect(width/2-width/16,height/64+anim,width/8,height/8,width/64); //frame of the settings screen
    fill(240,235,196);
    rect(width/8-width/20,height/6-height/10+anim,width/2 + width/4 + width/10,height/2 + height/4 + width/8,width/32); //tab to open/close it
    fill(DARK);
    rect(width/8,height/6+anim,width/2 + width/4,height/2 + height/4,width/64); //black screen of the settings screen
    stroke(0);
    strokeWeight(1);
    
        
    resText.displayCentered(width/8,height/6+anim,width/8+width/4,height/6+height/6+anim); //"Resolution" text
    extText.displayCentered(width/8,height/3+anim,width/8+width/4,height/6+height/3+anim); //"Extension" text
    
    //buttons for resolutions and extensions
    resButton1.Page(width/8 + width/4 + width/16,height/6+height/24+(int)anim);
    resButton2.Page(width/8 + width/8 + width/4 + width/16,height/6+height/24+(int)anim);
    resButton3.Page(width/8 + width/4 + width/4 + width/16,height/6+height/24+(int)anim);
    
    extButton1.Page(width/8 + width/4 + width/16,height/3+height/24+(int)anim);
    extButton2.Page(width/8 + width/8 + width/4 + width/16,height/3+height/24+(int)anim);
    extButton3.Page(width/8 + width/4 + width/4 + width/16,height/3+height/24+(int)anim);
  }

  void click(int px,int py){
    Coordinates pc = new Coordinates(px,py);
    if(pc.squareClosedRange(width/2-width/16,height/64+(int)anim,width/2+width/16,height/6-height/10+(int)anim)){
      if(open!=0) open = open*(-1);
      else if(anim == 0){open = -1;}
      else open = 1;
    }
    
    if(resButton1.isClicked(pc)){
      surface.setSize(1440,810);
      surface.setLocation(0,0);
      resButton1.setSelected(true);
      resButton2.setSelected(false);
      resButton3.setSelected(false);
    }
    if(resButton2.isClicked(pc)){
      surface.setSize(1280,720);
      surface.setLocation(0,0);
      resButton1.setSelected(false);
      resButton2.setSelected(true);
      resButton3.setSelected(false);
    }
    if(resButton3.isClicked(pc)){
      surface.setSize(960,540);
      surface.setLocation(0,0);
      resButton1.setSelected(false);
      resButton2.setSelected(false);
      resButton3.setSelected(true);
    }
    
    if(extButton1.isClicked(pc)){
      extension = ".jpg";
      extButton1.setSelected(true);
      extButton2.setSelected(false);
      extButton3.setSelected(false);
    }
    if(extButton2.isClicked(pc)){
      extension = ".png";
      extButton1.setSelected(false);
      extButton2.setSelected(true);
      extButton3.setSelected(false);
    }
    if(extButton3.isClicked(pc)){
      extension = ".tga";
      extButton1.setSelected(false);
      extButton2.setSelected(false);
      extButton3.setSelected(true);
    }
  }
}
