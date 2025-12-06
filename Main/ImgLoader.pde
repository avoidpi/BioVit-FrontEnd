public class ImgLoader{
  StringBuffer name;
  PImage img;
  
  ImgLoader(){
  }
  
  void displayFrame(float x,float y,float dmx,float dmy){
    float scale;
    if(img == null) img = Scan;
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
  
  void changeFrame(PImage img){
    this.img = img;
  }
  
  void changeFrameNoCache(String name){
    img = loadImage(name);
  }
}
