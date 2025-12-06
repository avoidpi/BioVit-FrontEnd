public class ModelView{
  
  ImgLoader imgLoader;
  String[] filenames = new String[256];
  PImage[] images = new PImage[256];
  String tmpfp = "random";
  int fileindex = 0;
  
  ModelView(){ //constructor
    this.imgLoader = new ImgLoader();
  };
  
  void page(){
    background(240,235,196);
    surface.setTitle("BioVit-GPT - Model");
    
    fill(0);
    textSize(width/80);
    
    if(filenames.length>0 && filenames[fileindex] != null){
      imgLoader.displayFrame(width/16,height/6,height*2/3,height*2/3);
      text("Displaying: "+filenames[fileindex],width/16,height*2/3 + height/6 + (textAscent())*1.5);
    }
    else{
      fill(0);
      square(width/16,height/6,height*2/3);
      text("Select a folder containing files ending in " + extension,width/16,height*2/3 + height/6 + (textAscent())*1.5);
    }
    
    
    //minus square
    stroke(255);
    fill(0);
    square(width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16);
    TextDisplay minus = new TextDisplay(0,0,width/25,LIGHT,new StringBuffer("-"));
    fill(255);
    minus.displayCentered(width/16,height/6+(height*2/3)+height/32,width/16+height/16,height/6+(height*2/3)+height/32+height/16);
    stroke(0);
    
     // plus square
    stroke(255);
    fill(0);
    square(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16);
    TextDisplay plus = new TextDisplay(0,0,width/25,LIGHT,new StringBuffer("+"));
    fill(255);
    plus.displayCentered(width/8,height/6+(height*2/3)+height/32,width/8+height/16,height/6+(height*2/3)+height/32+height/16);
    stroke(0);
    
    //select folder button
    
    stroke(255);
    fill(0);
    rect(width/8 + width/16,height/6+(height*2/3)+height/32,width/16+(height*2/3)-width/8-width/16,height/16);
    TextDisplay folderText  = new TextDisplay(0,0,width/50,LIGHT,new StringBuffer("Select Folder"));
    fill(255);
    folderText.displayCentered(width/8+width/16,height/6+(height*2/3)+height/32,width/16+(height*2/3),height/6+(height*2/3)+height/32+height/16);
    
    if(folderPath != tmpfp && folderPath != null){
      filenames = new String[100];
      filenames = loadFilenames(folderPath);
      fileindex = 0;
      
      for(int i=0;i<filenames.length;i++){ //cache all images in the folder
        images[i] = loadImage(folderPath+'/'+filenames[i]);
        //genuinely went insane trying to detect os to use \ and / based on it
        //then discovered windows recognizes / as \ when trying to access directories
      }
      
      if(filenames.length>0)
      imgLoader.changeFrame(images[0]); //cache
      //imgLoader.changeFrameNoCache(folderPath+'/'+filenames[fileindex]);
      //for(int i = 0;i<100;i++){
      //println(filenames[i]);
      //}
    }
  }
  
  void click(int px,int py){
    Coordinates c = new Coordinates(px,py);
    if(c.squareClosedRange(width/8+width/16,height/6+(height*2/3)+height/32,width/16+(height*2/3),height/6+(height*2/3)+height/32+height/16)){
      selectdir = true;
    }
    if(c.squareClosedRange(width/16,height/6+(height*2/3)+height/32,width/16+height/16,height/6+(height*2/3)+height/32+height/16) && folderPath != null){
      if(fileindex>0)fileindex--; else fileindex = filenames.length-1;
      if(filenames.length>0)
      imgLoader.changeFrame(images[fileindex]);
      //imgLoader.changeFrameNoCache(folderPath+'/'+filenames[fileindex]);
    }
    if(c.squareClosedRange(width/8,height/6+(height*2/3)+height/32,width/8+height/16,height/6+(height*2/3)+height/32+height/16) && folderPath != null){
      if(fileindex<filenames.length-1)fileindex++; else fileindex = 0;
      if(filenames.length>0)
      imgLoader.changeFrame(images[fileindex]);
      //imgLoader.changeFrameNoCache(folderPath+'/'+filenames[fileindex]);
    }
  }
  
  String[] loadFilenames(String path){
    File folder = new File(path);
    FilenameFilter filenameFilter = new FilenameFilter(){
      public boolean accept(File dir,String name){
        return name.toLowerCase().endsWith(extension);
      }
    };
    tmpfp = path;
    return folder.list(filenameFilter);
  }
}
