public class AboutView {
  AboutView() { //constructor
  }

  void page() {
    background(240,235,196);
    fill(100);
    square(10, 10, 10);
    surface.setTitle("BioVit-GPT - About");
  }
  
  void click(int px,int py){
    Coordinates c = new Coordinates(px,py);
  }
}
