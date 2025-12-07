public class Coordinates{
  int x = 0;
  int y = 0;
  
  Coordinates(int x,int y){ //constructor
    this.x = x;
    this.y = y;
  }
  
  void update(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  boolean squareClosedRange(int ix, int iy,int fx,int fy){ //this uses absolute coordinates
    if(x <fx && y < fy && x>ix && y>iy){
      return true;
    }
    else return false;
  }
  
  boolean squareClosedRangeDim(int ix, int iy,int dimx,int dimy){ //this uses initial coordinates + dimensions of rectangle
    if(x <(ix+dimx) && y < (iy+dimy) && x>ix && y>iy){
      return true;
    }
    else return false;
  }
}
