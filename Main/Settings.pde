public class Settings{
  float anim = height - height/64 - height/18; //variable that offsets the menu to animate it
  int open = -1; //variable that controls the animated movement and direction of it
  float v = width/96; //velocity of the animation (per frame)
  float buttonbordersize = width/288; //colored border of the rectangles that make up the buttons
  
  //text and buttons of the resolution selection part of the settings
  TextDisplay resText;
  RectButton resButton1; //1440 x 810, default setting
  RectButton resButton2; //1280 x 720
  RectButton resButton3; //960 x 540
  
  //text and buttons of the extension selection part of the settings
  TextDisplay extText;
  RectButton extButton1; //.jpg, default setting
  RectButton extButton2; //.png
  RectButton extButton3; //.tga
  
  //not found a reasonable use case for the constructor yet
  Settings(){
  }
  
  void Setup(){ //this HAS to run in Main.setup() after the size has been chosen or height and width will not have accurate dimensions
    v = width/96;
    buttonbordersize = width/288;
    anim = height - height/64 - height/18; //starting position of the settings menu is closed
    resText = new TextDisplay(width/30,GREEN,new StringBuffer("RESOLUTION"));
    extText = new TextDisplay(width/30,GREEN,new StringBuffer("EXTENSION"));
    
    //set initial position, dimension, colors, border and text of the buttons
    resButton1 = new RectButton(width/8 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKERGREEN,DARKGREEN,buttonbordersize,true);
    resButton1.setText(width/50,GREEN,"1440x810");
    resButton2 = new RectButton(width/8 + width/8 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKERGREEN,DARKGREEN,buttonbordersize,true);
    resButton2.setText(width/50,GREEN,"1280x720");
    resButton3 = new RectButton(width/8 + width/4 + width/4 + width/16,height/6+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKERGREEN,DARKGREEN,buttonbordersize,true);
    resButton3.setText(width/50,GREEN,"960x540");
    
    extButton1 = new RectButton(width/8 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKERGREEN,DARKGREEN,buttonbordersize,true);
    extButton1.setText(width/50,GREEN,".jpg");
    extButton2 = new RectButton(width/8 + width/8 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKERGREEN,DARKGREEN,buttonbordersize,true);
    extButton2.setText(width/50,GREEN,".png");
    extButton3 = new RectButton(width/8 + width/4 + width/4 + width/16,height/3+height/24+(int)anim,width/10,height/12,GREEN,DARK,DARKERGREEN,DARKGREEN,buttonbordersize,true);
    extButton3.setText(width/50,GREEN,".tga");
    
    resButton1.setSelected(true); //since those are the default settings, we set the variable that show that
    extButton1.setSelected(true);
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
  
  void updateAnim(){ //this runs everytime the window gets resized and the animation is moving (open !=0) to fix a small bug with the position of the settings window
    if(open == -1){ //if it's closing, snap the menu on closed pos
      anim = height - height/64 - height/18; 
    }
    if(open == 1){ //if it's opening, snap it to open pos
      anim = height/32;
    }
  }

  void Page(){
    
    //animation of the settings screen
    if(open == 1){
      anim = anim-v;
      if(anim <= height/32){
        anim = height/32;
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
    
    if(anim >= height - height/64 - height/18){ //fix for a possible edge case
      anim = height - height/64 - height/18; //it shouldn't be possible to resize while the settings are closed but better safe than sorry
    }
    
    //setting screen (minus the buttons and text)
    strokeWeight(width/480);
    stroke(0);
    fill(LESSLIGHT);
    rect(width/2-width/16,height/64+anim - height/32,width/8,height/8,width/64); //tab to open/close
    fill(LIGHT);
    rect(width/8-width/20,height/6-height/10+anim,width/2 + width/4 + width/10,height/2 + height/4 + width/8,width/32); //frame of the settings screen
    fill(DARK);
    rect(width/8,height/6+anim,width/2 + width/4,height/2 + height/4,width/64); //black screen of the settings screen
    stroke(0);
    strokeWeight(1);
    
    image(Options,width/2-height/40,height/64+(int)anim - height/64,height/20,height/20);
    
        
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
    Coordinates pc = new Coordinates(px,py);//gets mouse pos from onClick() in main
    if(pc.squareClosedRange(width/2-width/16,height/64+(int)anim - height/32,width/2+width/16,height/6-height/10+(int)anim)){
      if(open!=0) open = open*(-1); //tab to open/close, works even if the window is in animation cycle
      else if(anim == height/32){open = -1;}
      else open = 1;
    }
    
    //asks every button instance if the coordinates are inside their boundaries
    //if yes, does its thing ang sets setSelected to display the fact the button was the last selected
    //so for example, if you selected .jpg you know that's how it's currently set
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
