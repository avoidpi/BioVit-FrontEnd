public class ModelView{
  
  ImgLoader imgLoader;
  String[] filenames = new String[256];
  PImage[] images = new PImage[256];
  String tmpfp = "random";
  int fileindex = 0;
  
  float buttonbordersize;
  
  RectButton plusButton;
  RectButton minusButton;
  RectButton selectFolderButton;
  
  ModelView(){ //constructor
    this.imgLoader = new ImgLoader();
  };
  
  void Setup(){ //called in Main.setup()
    buttonbordersize = width/288;
    plusButton = new RectButton(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    plusButton.setText(width/25,DARK,"+");
    minusButton = new RectButton(width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    minusButton.setText(width/25,DARK,"-");
    selectFolderButton = new RectButton(width/8 + width/16,height/6+min(width*2/3,height*2/3)+height/32,width/16+(height*2/3)-width/8-width/16,height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    selectFolderButton.setText(width/50,DARK,"Select Folder");
  }
  
  void update(){ //called by Main.windowResized() anytime the window is resized
    buttonbordersize = width/288;
    plusButton.updateDim(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,buttonbordersize,width/25);
    minusButton.updateDim(width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,buttonbordersize,width/25);
    selectFolderButton.updateDim(width/8 + width/16,height/6+min(width*2/3,height*2/3)+height/32,width/16+min(width*2/3,height*2/3)-width/8-width/16,height/16,buttonbordersize,width/50);
    
  }
  
  void page(){
    background(240,235,196);
    surface.setTitle("BioVit-GPT - Model");
    
    fill(0);
    textSize(width/80);
    strokeWeight(3);
    
    if(filenames.length>0 && filenames[fileindex] != null){ //if there are cached images (loaded after selection) show an image
      imgLoader.displayFrame(width/16,height/6,height*2/3,height*2/3);
      text("Displaying: "+filenames[fileindex],width/16,height*2/3 + height/6 + (textAscent())*1.5);
    }
    else{ //else display a black box instead and ask for a folder selection
      fill(0);
      square(width/16,height/6,height*2/3);
      text("Select a folder containing files ending in " + extension,width/16,height*2/3 + height/6 + (textAscent())*1.5);
    }
    
    plusButton.Page(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32);
    minusButton.Page(width/16,height/6+min(width*2/3,height*2/3)+height/32);
    selectFolderButton.Page(width/8 + width/16,height/6+min(width*2/3,height*2/3)+height/32);
    
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
    if(selectFolderButton.isClicked(c)){
      selectdir = true;
    }
    if(minusButton.isClicked(c) && folderPath != null){
      if(fileindex>0)fileindex--; else fileindex = filenames.length-1;
      if(filenames.length>0)
      imgLoader.changeFrame(images[fileindex]);
      //imgLoader.changeFrameNoCache(folderPath+'/'+filenames[fileindex]);
    }
    if(plusButton.isClicked(c) && folderPath != null){
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
