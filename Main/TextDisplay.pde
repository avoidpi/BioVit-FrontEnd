public class TextDisplay{ //i created this class to more reliably center text, plus saving color and fontsize with no room for error
  float x;
  float y;
  float tsize;
  StringBuffer Body;
  color c;
  TextDisplay(float tsize, color c, StringBuffer Body){ //the constructor initializes size,color and text body of the class
    this.tsize = tsize;
    this.Body = Body;
    this.c = c;
  }
  
  void updateDim(int tsize){ //to call when screen dimension change, as all my text dimensions are based on screen width
    this.tsize = tsize;
  }
  
  void displayCentered(float ix,float iy,float fx,float fy){ //display the text at the center of a rectangle based on coordinates of top left and bottom right corners
    textSize(tsize); //set text size
    fill(c); //set color
    float tWidth = textWidth(Body.toString()); //this function returns the expected width of the text
    float tHeight = textAscent(); //this function returns the height of the font above the baseline
    x = ix + ((fx - ix)/2) - (tWidth/2);
    y = iy + ((fy - iy)/2) + (tHeight/2);
    text(Body.toString(),x,y);
  }
  
  void displayCenteredDim(float ix,float iy,float dimx,float dimy){ //same function but with initial coords and dimension of rectangle (as with rect() function, to make it easier to use)
    textSize(tsize);
    fill(c);
    float tWidth = textWidth(Body.toString());
    float tHeight = textAscent();
    x = ix + ((dimx)/2) - (tWidth/2);
    y = iy + ((dimy)/2) + (tHeight/2);
    text(Body.toString(),x,y);
  }
}
