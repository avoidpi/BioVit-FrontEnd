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
  
  boolean squareClosedRange(int ix, int iy,int fx,int fy){
    if(x <fx && y < fy && x>ix && y>iy){
      return true;
    }
    else return false;
  }
}
