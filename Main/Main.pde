import java.io.FilenameFilter;

String folderPath;
boolean selectdir = false;
int x = 0;
PImage img;
PImage BioVit;
PImage Scan;
PImage Schermo;
String extension = ".jpg"; //to make it changeable in settings

int uw;
int uh;

private static final int Home = 0; //i define these variables as they were a #define
private static final int About = 1;
private static final int Model = 2;

//boolean sWindow = true;

color DARK = color(0);
color LIGHT = color(240,235,196);

AboutView aboutView = new AboutView();
HomeView homeView = new HomeView();
ModelView modelView = new ModelView();
HeaderView headerView = new HeaderView();
Settings settings = new Settings();

int Page = Home;

void setup(){
  size(1440,810,P2D);
  noSmooth();
  background(0);
  surface.setResizable(false);
  surface.setLocation(50,50);
  img = loadImage("LOGO.png");
  BioVit = loadImage("ScrittaBioVit.png");
  Scan = loadImage("frame.jpg");
  settings.Setup();
}
void draw(){
  pageDraw();
  headerView.page();
  
  settings.Page();
  if(selectdir == true){
    selectdir = false;
    selectFolder("Seleziona una cartella contenente le immagini dell'MRI;","folderSelected");
  }
  /*if(x ==0){
  selectFolder("Seleziona una cartella contenente le immagini dell'MRI;","folderSelected");
    x = 1;
    }*/
  }

  void folderSelected(File selection){
    if(selection == null){
      println("Hai chiuso la finestra o cliccato canc");
    }else{
      folderPath = selection.getAbsolutePath();
      //println(folderPath);
    }
  }

void mouseClicked(){ //function gets called everytime there's a mouse click
  Coordinates c = new Coordinates(mouseX,mouseY);
  if(settings.anim != height - height/64 - height/18){settings.click(mouseX,mouseY);}
  else if(c.squareClosedRange(width/2-width/16,height/64+height - height/64 - height/18,width/2+width/16,height/6-height/10+height - height/64 - height/18)){
    settings.open = +1;
    settings.anim -=1;
  }
  else if(c.squareClosedRange(0,0,width,height/7)){
    headerView.click(mouseX,mouseY);
  }
  else{
  switch(Page){ //through a switch, depending on the value it sends detection to the correct page
      case Home:  //why do it like this? i love programming abominations
        homeView.click(mouseX,mouseY);
        break;
      case About:
        aboutView.click(mouseX,mouseY);
        break;
      case Model:
        modelView.click(mouseX,mouseY);
        break;
      default:
        break;
    }
  }
}

void windowResized(){
  delay(100);
}

void pageDraw(){ //Page is a number, each value corresponds to a page
  switch(Page){ //through a switch, depending on the value it draws the correct page
    case Home:  //why do it like this? i love programming abominations
      homeView.page();
      break;
    case About:
      aboutView.page();
      break;
    case Model:
      modelView.page();
      break;
    default:
      break;
  }
}
