public class ImgLoader{
  StringBuffer name;
  PImage img;
  
  ImgLoader(){
  }
  
  void displayFrame(float x,float y,float dmx,float dmy){ //displays the image centered inside the rect starting at x,y and of dims dmx dimy
    float scale; //this in fact is not really thought for a rectangle area but for a square one, it mantains the proportions of the image instead of distorting
    if(img == null) img = Scan; //if the image is null it loads a default one to prevent errors
    if(img.height<img.width){
      scale = img.width/dmx;
      y += (dmy - (img.height/scale))/2;
      dmy = (img.height/scale);
    }
    if(img.width<img.height){
      scale = img.height/dmy;
      x += (dmx - (img.width/scale))/2;
      dmx = (img.width/scale);
    }
    image(img,x,y,dmx,dmy);
  }
  
  void changeFrame(PImage img){ //changes the current image by taking as input an image
    this.img = img;
  }
  
  void changeFrameNoCache(String name){ //changes the current image by loading one from a path (either absolute or name of a file inside the data folder)
    img = loadImage(name);
  }
}
