public class HttpManager{
  
  String folderPath;
  String fileList[];
  
  void sendFileList(String folderPath,String fileList[]){
    this.folderPath = folderPath;
    this.fileList = fileList;
    
    String jsonbody = filesToJSON(folderPath,fileList).toString();
    
    HttpClient client = HttpClient.newHttpClient();
    HttpRequest request = null;
    //try{
    request = HttpRequest.newBuilder()
      .uri(URI.create("https://echo.free.beeceptor.com"))
      .timeout(Duration.ofMinutes(1))
      .header("Content-Type", "application/json")
      .POST(BodyPublishers.ofString(jsonbody))
      .build();
    //}
    //catch(FileNotFoundException e){
    //}
      
    client.sendAsync(request, HttpResponse.BodyHandlers.ofString())
      .thenApply(HttpResponse::body)
      .thenAccept(System.out::println)
      .join();
  }
  
  
  JsonObject filesToJSON(String folderPath,String fileList[]){
    
    //il file Json sarà formattato così: (meno l'indentazione, che in caso si può implementare dopo)
    /*
    
    {
      "Length":"fileList.length"
      "Filenames":["filename1","filename2",...]
      "jpgFile":["data of filename1","data of filename2",...] <- jpgs encoded in base64
    }
    
    */
    JsonObjectBuilder objectBuilder = Json.createObjectBuilder()
      .add("Length",String.valueOf(fileList.length));
      
    JsonArrayBuilder filenameBuilder = Json.createArrayBuilder();
    
    for(int i=0;i<fileList.length;i++){
        String addzeros = "";
        if(i<1000) addzeros =addzeros.concat("0");
        if(i<100) addzeros =addzeros.concat("0");
        if(i<10) addzeros =addzeros.concat("0");
        addzeros = addzeros.concat(String.valueOf(i));
        addzeros = addzeros.concat(".jpg");
        filenameBuilder.add(addzeros);
      }  
      objectBuilder.add("Filenames", filenameBuilder);
    
    JsonArrayBuilder filedataBuilder = Json.createArrayBuilder();
                
      for(int i=0;i<fileList.length;i++){
        String addzeros = "";
        if(i<1000) addzeros =addzeros.concat("0");
        if(i<100) addzeros =addzeros.concat("0");
        if(i<10) addzeros =addzeros.concat("0");
        File imageFile =  new File(folderPath+File.separator+addzeros+i+".jpg");
        String encodedfile = new String(encodeFileToBase64Binary(imageFile));
        filedataBuilder.add(encodedfile);
      }  
      objectBuilder.add("jpgFile", filedataBuilder);
      
      return objectBuilder.build();
  }
  
  
  //need to take files, get strings in base64, put them into a json and then send them to api
  //also, get back from api a json and parse it for string response
  
  public String encodeFileToBase64Binary(File file){ //this reads a file,encodes the file in base64 and return it as a string
            String encodedfile = null;
            try {
                FileInputStream fileInputStreamReader = new FileInputStream(file);
                byte[] bytes = new byte[(int)file.length()];
                fileInputStreamReader.read(bytes);
                fileInputStreamReader.close();
                encodedfile = Base64.getEncoder().encodeToString(bytes);
                println(encodedfile);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return encodedfile;
        }
}
