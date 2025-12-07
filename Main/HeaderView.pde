public class HeaderView{
  Coordinates coordinates = new Coordinates(width,height/7);

  HeaderView(){
  }

  void page(){
    Coordinates mc = new Coordinates(mouseX,mouseY); //track cursor pos to update color of buttons in menu
    coordinates.update(width,height/7); //update bounding coordinates of the menu background 
    
    TextDisplay homeText = new TextDisplay(0,0,width/25,DARK,new StringBuffer("Home")); //homebrewed class makes me able to align
    TextDisplay AIText = new TextDisplay(0,0,width/25,DARK,new StringBuffer("AI")); //manually the text + some properties
    TextDisplay aboutText = new TextDisplay(0,0,width/25,DARK,new StringBuffer("About"));
    
    stroke(0);
    fill(50);
    rect(0,0,this.coordinates.x,this.coordinates.y); //background
    image(img,width/12-height/20,height/14-height/20,height/10,height/10); //logo
    
    image(BioVit,width*2/3,this.coordinates.y/2-width/12,width/3,width/6);
    
    fill(120);
    if(mc.squareClosedRange(width/6,0,width/3,this.coordinates.y) && (settings.anim == height - height/64 - height/18)) fill(180);
    rect(width/6,0,width/6,this.coordinates.y);
    
    fill(120);
    if(mc.squareClosedRange(width/3,0,width/3+width/6,this.coordinates.y) && (settings.anim == height - height/64 - height/18)) fill(180);
    rect(width/3,0,width/6,this.coordinates.y);
    
    fill(120);
    if(mc.squareClosedRange(width/6+width/3,0,width/3+width/3,this.coordinates.y) && (settings.anim == height - height/64 - height/18)) fill(180);
    rect(width/6+width/3,0,width/6,this.coordinates.y);
    
    homeText.displayCentered(width/6,0,width/3,this.coordinates.y);
    AIText.displayCentered(width/3,0,width/3 + width/6,this.coordinates.y);
    aboutText.displayCentered(width/2,0,width/2 + width/6,this.coordinates.y);
    
    //text("Home",width/6+width/12-width/20,height/14+height/85);
    //text("AI",width/3+width/12-width/62,height/14+height/85);
    //text("About",width/3+width/6+width/12-width/20,height/14+height/85);
  }

  void click(int px,int py){
    Coordinates c = new Coordinates(px,py);
    if(c.squareClosedRange(width/12-height/20,height/14-height/20,width/12+height/20,height/14+height/20)){
      Page = 0;
    }
    if(c.squareClosedRange(width/6,0,width/3,this.coordinates.y)){
      Page = 0;
    }
    if(c.squareClosedRange(width/6+width/6,0,width/3 + width/6,this.coordinates.y)){
      Page = 2;
    }
    if(c.squareClosedRange(width/6+width/3,0,width/3 + width/3,this.coordinates.y)){
      Page = 1;
    }
  }

}
