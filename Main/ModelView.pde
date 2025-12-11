public class ModelView{
  
  ImgLoader imgLoader;
  String[] filenames = new String[256];
  PImage[] images = new PImage[256];
  String[] tmpDirfilenames;
  PImage buffer;
  String tmpfp = "random";
  int fileindex = 0;
  String copyText  = "";
  
  TextLoader textLoader;
  String loadedString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed orci sem, lobortis sed commodo id, venenatis vitae massa. Donec odio elit, accumsan eu condimentum a, sodales nec eros. Nulla lectus arcu, tincidunt ut ullamcorper vel, pulvinar ut nisl. Fusce scelerisque nulla fermentum dolor sollicitudin commodo. Donec at volutpat urna. Sed pharetra hendrerit nulla id vulputate. Cras pharetra iaculis diam quis tristique. Sed sollicitudin nisi ipsum, sit amet accumsan libero tempor non. Curabitur vitae viverra lectus. Vivamus sit amet placerat ex. Ut rhoncus elementum nibh eget aliquam. Sed at lacus turpis.\n\nSed non elit at odio tempor accumsan. Sed sed leo tortor. Nunc imperdiet sit amet elit et rutrum. Quisque tortor elit, lacinia nec vestibulum eu, ullamcorper ac diam. Nam feugiat lacus nec nunc iaculis, eu viverra ante euismod. Nam quis molestie risus, vel malesuada ante. Proin ullamcorper, arcu id euismod ullamcorper, magna magna fermentum justo, ut posuere magna purus ut turpis.";
  
  float buttonbordersize;
  
  RectButton plusButton;
  RectButton minusButton;
  RectButton selectFolderButton;
  RectButton copyToClipboardButton;
  RectButton copyToFileButton;
  
  void Setup(){ //called in Main.setup()
    this.imgLoader = new ImgLoader();
    this.textLoader = new TextLoader(DARK,WHITE,DARK);
    this.textLoader.setText(loadedString);
    this.buttonbordersize = width/480;
    plusButton = new RectButton(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    plusButton.setText(width/25,DARK,"+");
    minusButton = new RectButton(width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    minusButton.setText(width/25,DARK,"-");
    selectFolderButton = new RectButton(width/8 + width/16,height/6+min(width*2/3,height*2/3)+height/32,width/16+(height*2/3)-width/8-width/16,height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    selectFolderButton.setText(width/50,DARK,"Select Folder");
    
    copyToClipboardButton = new RectButton((int)(width-((2/5.0)*min(width*2/3,height*2/3))-width/16 - buttonbordersize),height/6+min(width*2/3,height*2/3)+height/32,(int)((2/5.0)*min(width*2/3,height*2/3)),height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    copyToClipboardButton.setText(width/70,DARK,"Copy to Clipboard");
    
    copyToFileButton = new RectButton((int)(width-(min(width*2/3,height*2/3))-width/16 + buttonbordersize),height/6+min(width*2/3,height*2/3)+height/32,(int)((2/5.0)*min(width*2/3,height*2/3)),height/16,DARK,LESSERLIGHT,LIGHTER,LIGHT,buttonbordersize);
    copyToFileButton.setText(width/70,DARK,"Copy as File in Folder");
  }
  
  void update(){ //called by Main.windowResized() anytime the window is resized
    buttonbordersize = width/480;
    plusButton.updateDim(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,buttonbordersize,width/25);
    minusButton.updateDim(width/16,height/6+min(width*2/3,height*2/3)+height/32,height/16,height/16,buttonbordersize,width/25);
    selectFolderButton.updateDim(width/8 + width/16,height/6+min(width*2/3,height*2/3)+height/32,width/16+min(width*2/3,height*2/3)-width/8-width/16,height/16,buttonbordersize,width/50);
    copyToClipboardButton.updateDim((int)(width-((2/5.0)*min(width*2/3,height*2/3))-width/16 - buttonbordersize),height/6+min(width*2/3,height*2/3)+height/32,(int)((2/5.0)*min(width*2/3,height*2/3)),height/16,buttonbordersize,width/70);
    copyToFileButton.updateDim((int)(width-(min(width*2/3,height*2/3))-width/16 + buttonbordersize),height/6+min(width*2/3,height*2/3)+height/32,(int)((2/5.0)*min(width*2/3,height*2/3)),height/16,buttonbordersize,width/70);
  }
  
  void page(){
    background(240,235,196);
    surface.setTitle("BioVit-GPT - Model");
    
    fill(0);
    textSize(width/80);
    strokeWeight(3);
    
    if(filenames.length>0 && filenames[fileindex] != null){ //if there are cached images (loaded after selection) show an image
      square(width/16,height/6,min(width*2/3,height*2/3));
      imgLoader.displayFrame(width/16,height/6,min(width*2/3,height*2/3),min(width*2/3,height*2/3));
      text("Displaying: "+filenames[fileindex],width/16,min(width*2/3,height*2/3) + height/6 + (textAscent())*1.3);
    }
    else{ //else display a black box instead and ask for a folder selection
      fill(0);
      square(width/16,height/6,min(width*2/3,height*2/3));
      text("Select a folder containing files ending in " + extension,width/16,min(width*2/3,height*2/3) + height/6 + (textAscent())*1.3);
    }
    
    text(copyText,width-min(width*2/3,height*2/3)-width/16,min(width*2/3,height*2/3) + height/6 + (textAscent())*1.3);
    
    textLoader.Page(width-min(width*2/3,height*2/3)-width/16,height/6,min(width*2/3,height*2/3),min(width*2/3,height*2/3),width/80);
    
    plusButton.Page(width/16+width/16,height/6+min(width*2/3,height*2/3)+height/32);
    minusButton.Page(width/16,height/6+min(width*2/3,height*2/3)+height/32);
    selectFolderButton.Page(width/8 + width/16,height/6+min(width*2/3,height*2/3)+height/32);
    copyToClipboardButton.Page((int)(width-((2/5.0)*min(width*2/3,height*2/3))-width/16 -buttonbordersize/2),height/6+min(width*2/3,height*2/3)+height/32);
    copyToFileButton.Page((int)(width-(min(width*2/3,height*2/3))-width/16 + buttonbordersize),height/6+min(width*2/3,height*2/3)+height/32);
    
    if(folderPath != tmpfp && folderPath != null){ //if the input folder has changed or set for the first time
      filenames = new String[256]; //it empties the filenames string
      filenames = loadFilenames(folderPath); //and loads the list of files ending in the selected extension in filenames
      fileindex = 0;
      
      for(int i=0;i<filenames.length;i++){ //cache all images in the folder
        images[i] = loadImage(folderPath+File.separator+filenames[i]);
      }
      
      File tmpsave = new File(folderPath+File.separator+"tmpsave");
      if(tmpsave.isDirectory()){ //every time a directory gets opened, we check for a tmpsave dir and we delete it if it exists
        deleteTmpDir(tmpsave.toString());
        println("Deleted "+tmpsave.toString());
      }
      
      
      //after the (if it existed) deletion of tmpsave, we re-create it (this ensures the directory is always containing all the correct files)
      for(int i=0;i<filenames.length;i++){ //save and convert to jpg from either png, jpg or tva
        String addzeros = "";
        if(i<1000) addzeros =addzeros.concat("0");
        if(i<100) addzeros =addzeros.concat("0");
        if(i<10) addzeros =addzeros.concat("0");
        buffer = createImage(images[i].width,images[i].height,RGB);
        buffer = images[i].get();
        buffer.save(folderPath+File.separator+"tmpsave"+File.separator+addzeros+i+".jpg"); //this now saves it as (path of image folder)/saved/i.jpg where i is the ith image in alphabetic order from input folder
      }
      
      tmpDirfilenames = new String[256];
      tmpDirfilenames = tmpsave.list();
      
      loadedString = new String("Files:\n");
      for(int i=0;i<filenames.length;i++){ //this portion of code will be later removed or reworked, for now it lists all the created files in tmpsave inside loadedString
        loadedString = loadedString.concat(tmpDirfilenames[i]+" ");
      }
      textLoader.setText(loadedString); //we have to set the string in the textloader obviously
      
      //to be clear, every directory that gets opened will have afterwards a tmpsave of its own, later when we will have sent the file to the api we will delete it to leave no trace
      if(tmpsave.isDirectory())println("(Re-)Created and populated "+tmpsave.toString());
      
      if(filenames.length>0)
      imgLoader.changeFrame(images[0]); //loads first cached image on the screen if it exists
    }
  }
  
  void deleteTmpDir(String path){ //this deletes a directory and all its contents recursively, be careful calling it!!!!
    File tmpDir = new File(path);
    if(tmpDir.isDirectory()){
      String[] childFiles = tmpDir.list(); //lists all files/directories inside the directory
      if(childFiles == null){ //if there's no files inside we delete it
        tmpDir.delete();
      }
      else{ //if there is, delete recursively contents
        for(String childFilePath : childFiles) deleteTmpDir(path+File.separator+childFilePath); //absolute path of father + separator + name of child
        tmpDir.delete(); //when we have emptied the contents, delete it
      }
    }
    else tmpDir.delete(); //if it's not a file we just delete it
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
    }
    if(plusButton.isClicked(c) && folderPath != null){
      if(fileindex<filenames.length-1)fileindex++; else fileindex = 0;
      if(filenames.length>0)
      imgLoader.changeFrame(images[fileindex]);
    }
    if(copyToClipboardButton.isClicked(c) && loadedString != null){
      StringSelection data = new StringSelection(loadedString);
      Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
      clipboard.setContents(data, data);
      copyText = "Saved to clipboard";
    }
    if(copyToFileButton.isClicked(c) && loadedString != null && folderPath != null){
      outputToFile = createWriter(folderPath+File.separator+"Biovit "+String.valueOf(hour())+"-"+String.valueOf(minute())+"-"+String.valueOf(second())+" "+String.valueOf(day())+"-"+String.valueOf(month())+"-"+String.valueOf(year())+".txt");
      outputToFile.println(loadedString);
      outputToFile.flush();
      outputToFile.close();
      copyText = "Saved as " +folderPath+File.separator+"Biovit "+String.valueOf(hour())+"-"+String.valueOf(minute())+"-"+String.valueOf(second())+" "+String.valueOf(day())+"-"+String.valueOf(month())+"-"+String.valueOf(year())+".txt";
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
