public class HeaderView{
  Coordinates coordinates = new Coordinates(width,height/7);
  
  float buttonbordersize = width/480;
  RectButton homeButton;
  RectButton modelButton;
  RectButton aboutButton;

  HeaderView(){
  }
  
  void Setup(){
    buttonbordersize = width/480;
    coordinates.update(width,height/7); //update bounding coordinates of the menu background 
    homeButton = new RectButton(width/6,0,width/6,this.coordinates.y,DARK,LESSERLIGHT,LESSLIGHT,LIGHT,buttonbordersize);
    homeButton.setText(width/25,DARK,"Home");
    homeButton.setSelected(true); //as the application starts in the home page, highlight to say it's selected
    modelButton = new RectButton(width/3,0,width/6,this.coordinates.y,DARK,LESSERLIGHT,LESSLIGHT,LIGHT,buttonbordersize);
    modelButton.setText(width/25,DARK,"AI");
    aboutButton = new RectButton(width/6+width/3,0,width/6,this.coordinates.y,DARK,LESSERLIGHT,LESSLIGHT,LIGHT,buttonbordersize);
    aboutButton.setText(width/25,DARK,"About");
  }
  
  void update(){
    coordinates.update(width,height/7); //update bounding coordinates of the menu background 
    buttonbordersize = width/480;
    homeButton.updateDim(width/6,0,width/6,this.coordinates.y,buttonbordersize,width/25);
    modelButton.updateDim(width/3,0,width/6,this.coordinates.y,buttonbordersize,width/25);
    aboutButton.updateDim(width/6+width/3,0,width/6,this.coordinates.y,buttonbordersize,width/25);
  }

  void page(){
    stroke(DARK);
    strokeWeight(buttonbordersize);
    fill(DARKGREY);
    rect(0,0,width,this.coordinates.y); //background
    image(img,width/12-height/20,this.coordinates.y/2-height/20,height/10,height/10); //computer logo
    
    image(BioVit,width*2/3,this.coordinates.y/2-width/12,width/3,width/6); //biovit text
    
    homeButton.Page(width/6,0);
    modelButton.Page(width/3,0);
    aboutButton.Page(width/6+width/3,0);
    strokeWeight(1);
  }

  void click(int px,int py){ //asks buttons if they have been clicked, if yes modifies their status and changes page accordingly
    Coordinates c = new Coordinates(px,py);
    if(c.squareClosedRange(width/12-height/20,this.coordinates.y/2-height/20,width/12+height/20,this.coordinates.y/2+height/20)){ //logo if clicked redirects to home page
      Page = 0;
      homeButton.setSelected(true);
      modelButton.setSelected(false);
      aboutButton.setSelected(false);
    }
    if(homeButton.isClicked(c)){
      Page = 0;
      homeButton.setSelected(true);
      modelButton.setSelected(false);
      aboutButton.setSelected(false);
    }
    if(modelButton.isClicked(c)){
      Page = 2;
      homeButton.setSelected(false);
      modelButton.setSelected(true);
      aboutButton.setSelected(false);
    }
    if(aboutButton.isClicked(c)){
      Page = 1;
      homeButton.setSelected(false);
      modelButton.setSelected(false);
      aboutButton.setSelected(true);
    }
  }

}
