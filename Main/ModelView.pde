public class ModelView{
  
  ImgLoader imgLoader;
  String[] filenames = new String[256];
  PImage[] images = new PImage[256];
  String tmpfp = "random";
  int fileindex = 0;
  
  TextLoader textLoader;
  String loadedString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed orci sem, lobortis sed commodo id, venenatis vitae massa. Donec odio elit, accumsan eu condimentum a, sodales nec eros. Nulla lectus arcu, tincidunt ut ullamcorper vel, pulvinar ut nisl. Fusce scelerisque nulla fermentum dolor sollicitudin commodo. Donec at volutpat urna. Sed pharetra hendrerit nulla id vulputate. Cras pharetra iaculis diam quis tristique. Sed sollicitudin nisi ipsum, sit amet accumsan libero tempor non. Curabitur vitae viverra lectus. Vivamus sit amet placerat ex. Ut rhoncus elementum nibh eget aliquam. Sed at lacus turpis.\n\nSed non elit at odio tempor accumsan. Sed sed leo tortor. Nunc imperdiet sit amet elit et rutrum. Quisque tortor elit, lacinia nec vestibulum eu, ullamcorper ac diam. Nam feugiat lacus nec nunc iaculis, eu viverra ante euismod. Nam quis molestie risus, vel malesuada ante. Proin ullamcorper, arcu id euismod ullamcorper, magna magna fermentum justo, ut posuere magna purus ut turpis.";
  
  float buttonbordersize;
  
  RectButton plusButton;
  RectButton minusButton;
  RectButton selectFolderButton;
  
  void Setup(){ //called in Main.setup()
    this.imgLoader = new ImgLoader();
    this.textLoader = new TextLoader(LESSERLIGHT,WHITE,DARK);
    this.textLoader.setText(loadedString);
    this.buttonbordersize = width/288;
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
      imgLoader.displayFrame(width/16,height/6,min(width*2/3,height*2/3),min(width*2/3,height*2/3));
      text("Displaying: "+filenames[fileindex],width/16,min(width*2/3,height*2/3) + height/6 + (textAscent())*1.5);
    }
    else{ //else display a black box instead and ask for a folder selection
      fill(0);
      square(width/16,height/6,min(width*2/3,height*2/3));
      text("Select a folder containing files ending in " + extension,width/16,min(width*2/3,height*2/3) + height/6 + (textAscent())*1.5);
    }
    
    textLoader.Page(width-min(width*2/3,height*2/3)-width/16,height/6,min(width*2/3,height*2/3),min(width*2/3,height*2/3),width/80);
    
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
