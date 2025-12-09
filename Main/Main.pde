import java.io.FilenameFilter;

import java.awt.*;
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;

PrintWriter outputToFile;
String folderPath = null;
boolean selectdir = false;
int x = 0;
PImage img; //cute little computer logo topleft corner
PImage BioVit; //biovit text topright corner
PImage Scan; //placeholder image for imgloader
PImage Schermo; //not used anymore, leaving it in because i might in the future
PImage Options; //gear icon for the settings menu
String extension = ".jpg"; //type of extension chosen, gets changed in the settings menu (def is .jpg)

private static final int Home = 0; //i define these variables as they were a #define
private static final int About = 1;
private static final int Model = 2;

//boolean sWindow = true;

//couple color definitions to have a palette and not go insane
color WHITE = color(255);
color DARK = color(0);
color DARKGREY = color(50);
color LIGHTDARKGREY = color(80);
color LIGHTGREY = color(120);
color LIGHTERGREY = color(180);
color LIGHT = color(240,235,196);
color LESSLIGHT = color(217,215,176);
color LESSERLIGHT = color(180,175,136);
color LIGHTER = color(255,255,216);
color GREEN =  color(50,255,50);
color DARKGREEN = color(50,100,50);
color DARKERGREEN = color(25,75,25);

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
  surface.setResizable(true);
  surface.setLocation(50,50);
  img = loadImage("LOGO.png");
  BioVit = loadImage("ScrittaBioVit.png");
  Scan = loadImage("frame.jpg");
  Options = loadImage("options.png");
  settings.Setup();
  modelView.Setup();
  headerView.Setup();
}
void draw(){
  pageDraw();
  headerView.page();
  
  settings.Page();
  if(selectdir == true){ //selectdir is changed by the Model page (AI) on Select Folder button click
    selectdir = false;
    selectFolder("Seleziona una cartella contenente le immagini dell'MRI;","folderSelected");
  }
}

void folderSelected(File selection){
  if(selection == null){
    println("Hai chiuso la finestra o cliccato canc");
  }else{
    folderPath = selection.getAbsolutePath();
  }
}

void mouseClicked(){ //function gets called everytime there's a mouse click
  Coordinates c = new Coordinates(mouseX,mouseY);
  if(settings.anim != height - height/64 - height/18){settings.click(mouseX,mouseY);} //if the settings menu is open/being animated it sends click data to settings page
  else if(c.squareClosedRange(width/2-width/16,height/64+height - height/64 - height/18 -height/32,width/2+width/16,height/6-height/10+height - height/64 - height/18)){
    settings.open = +1; //else it checks for the settings tab and opens the settings menu
  }
  else if(c.squareClosedRange(0,0,width,headerView.coordinates.y)){ //else if the cursor is inside the header it sends click data to header page
    headerView.click(mouseX,mouseY);
  }
  else{ //else it checks what page is loaded
  switch(Page){ //through a switch, depending on the value it sends detection to the correct page
      case Home:
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

void windowResized(){ //gets called everytime the window gets resized (to notify all pages to update their content accordingly)
  delay(100);
  headerView.update();
  modelView.update();
  settings.update();
  if(settings.anim != 0){
    settings.updateAnim();
  }
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
