public class HomeView{
  HomeView(){ //constructor
  }
  
  void page(){
    background(240,235,196);
    fill(255);
    //square(10,10,10);
    surface.setTitle("BioVit-GPT - Home");
  }
  
  void click(int px,int py){
    Coordinates c = new Coordinates(px,py);
  }
}
