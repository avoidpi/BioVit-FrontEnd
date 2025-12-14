public class ImgLoader{
  StringBuffer name;
  PImage img;
  
  ImgLoader(){
  }
  
  void displayFrame(float x,float y,float dmx,float dmy){ //displays the image centered inside the rect starting at x,y and of dims dmx dmy
    float scale; //this is supposed to work no matter the proportion of the rectangle now, it basically resizes based on the side that needs to shrink more to fit
    if(img != null){ //also, only works if an image was set, so we both don't have to handle exceptions and it doesn't break
      if((img.height/dmy)<=(img.width/dmx)){
        scale = img.width/dmx;
        y += (dmy - (img.height/scale))/2;
        dmy = (img.height/scale);
      }
      else{
        scale = img.height/dmy;
        x += (dmx - (img.width/scale))/2;
        dmx = (img.width/scale);
      }
      image(img,x,y,dmx,dmy);
    }
  }
  
  void changeFrame(PImage img){ //changes the current image by taking as input an image
    this.img = img;
  }
  
  void changeFrameNoCache(String path){ //changes the current image by loading one from a path (either absolute or name of a file inside the data folder)
    img = loadImage(path); //this is unused because a cache is better for speed while viewing the images
  }
  
}
