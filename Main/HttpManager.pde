public class HttpManager{
  
  String folderPath;
  String fileList[];
  
  void sendFileList(String folderPath,String fileList[]){
    this.folderPath = folderPath;
    this.fileList = fileList;
    //String jsonbody = filesToJSON(folderPath,fileList).toString();
    String jsonbody = filesToJSONCoupled(folderPath,fileList).toString();
    println("Body size of request: "+jsonbody.getBytes().length);
    try{
    HttpClient client = HttpClient.newHttpClient();
    HttpRequest request = null;
    
    request = HttpRequest.newBuilder()
      .uri(URI.create("https://echo.free.beeceptor.com"))
      .timeout(Duration.ofMinutes(1))
      .header("Content-Type", "application/json")
      .POST(BodyPublishers.ofString(jsonbody)) //sends the json content as a string
      .build();
      
    client.sendAsync(request, HttpResponse.BodyHandlers.ofString())
      .thenApply(HttpResponse::body)
      .thenAccept(this::saveString)
      .join();
    }
    catch(Exception e){
      loadedString = new String("Tried sending data but got:\n"+e.toString()+"\nAre you connected to the internet? If not, servers are down.");
    }
  }
  
  void saveString(String save){
    //loadedString = new String(save);
    loadedString = new String(parseForReport(save,"ModelReport"));
    //String loadedString2 = new String(parseForReport(save,"0000.jpg"));
    //decodeBase64BinaryToFile(loadedString2,folderPath+File.separator+"out.jpg");
    //delay(10000);
    //println(save);
  }

  String parseForReport(String save,String token){ //manual implementation for parsing of the response body because it's faster than trying to understand a java class to do it and implement it
  
    //and to be clear, this works flawlessly
    //we search for Token + : +" and then reset loadedString and put char by char inside until we find a " (token includes its own "")
    String tokenName = new String("\""+token+"\"");
    String parsedResponse = new String("");
    println("Looking for: "+ tokenName);
    boolean Match = false;
    boolean MatchColon = false;
    boolean Start = false;
    boolean End = false;
    char buf[] = new char[tokenName.length()];
    for(int i=0;i<save.length() && !End;i++){ //cycle until either the string ends or we got what we wanted
      char c = save.charAt(i);
      if(Match){ //if at the previous cycle we found a match for tokenName ("ModelReport":") (= we're at the first char of the string we want to read)
        if(c != '\"'){
          if(c == ':') MatchColon = true; //we check for a colon so we're sure the match we found is a token, not a value
          if(!MatchColon && (c == ',' || c == '}') ) Match = false; //if we find a , or } before a colon, we know the match was a value and not a token so we discard the match
          if(Start){parsedResponse = new String(parsedResponse + c);} //adds the char to the string
        }
        else{
          if(Start)End = true; //if the current char is a " and we're reading we're gonna just end the reading
          else if(MatchColon) Start = true; //if the current char is a " and we've not started reading yet, we'll commence
        }
      }
      else{ //if we haven't found a match for tokenName
      
        for(int j=0;j<tokenName.length()-1;j++){ //cycle the chars in a buffer of the same size as tokenName
          buf[j] = buf[j+1];
        }
        buf[tokenName.length()-1] = c;
        
        if(tokenName.equals(new String(buf))) Match = true; //if the char buffer is a match we communicate it through a boolean
      }
    }
    println(parsedResponse);
    if(parsedResponse.equals(new String("")) || End) return parsedResponse; //we save the parsed string only if it's not empty and if we actually found the ending "
    return (new String("Error: did not find the token in response body"));
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
    JsonObjectBuilder objectBuilder = Json.createObjectBuilder() //numero di immagini
      .add("Length",String.valueOf(fileList.length));
      
    objectBuilder.add("ModelReport","This is the report as a String");
      
    JsonArrayBuilder filenameBuilder = Json.createArrayBuilder();
    
    for(int i=0;i<fileList.length;i++){
        filenameBuilder.add(fileList[i]);
      }  
      objectBuilder.add("Filenames", filenameBuilder); //lista di nomi delle immagini
    
    JsonArrayBuilder filedataBuilder = Json.createArrayBuilder();
                
      for(int i=0;i<fileList.length;i++){
        File imageFile =  new File(folderPath+File.separator+fileList[i]);
        String encodedfile = new String(encodeFileToBase64Binary(imageFile));
        filedataBuilder.add(encodedfile);
      }  
      objectBuilder.add("jpgFile", filedataBuilder);
      
      return objectBuilder.build(); //lista di immagini convertite in stringhe Base64
  }
  
  
  JsonObject filesToJSONCoupled(String folderPath,String fileList[]){
    
    //il file Json sarà formattato così: (meno l'indentazione, che in caso si può implementare dopo)
    /*
    
    {
      "Length":"fileList.length"
      "filename1":"data of filename1", <- jpg encoded in base64
      "filename2":"data of filename2",
    }
    
    */
    JsonObjectBuilder objectBuilder = Json.createObjectBuilder() //numero di immagini
      .add("Length",String.valueOf(fileList.length));
      
    objectBuilder.add("ModelReport","this is the body of the object report");
                
    for(int i=0;i<fileList.length;i++){
      File imageFile =  new File(folderPath+File.separator+fileList[i]);
      String encodedfile = new String(encodeFileToBase64Binary(imageFile));
      objectBuilder.add(fileList[i], encodedfile);
    }  
      
    return objectBuilder.build(); //lista di immagini convertite in stringhe Base64
  }
  
  public String encodeFileToBase64Binary(File file){ //this reads a file,encodes the file in base64 and return it as a string
            String encodedfile = null;
            try {
                FileInputStream fileInputStreamReader = new FileInputStream(file);
                byte[] bytes = new byte[(int)file.length()];
                fileInputStreamReader.read(bytes);
                fileInputStreamReader.close();
                encodedfile = Base64.getEncoder().encodeToString(bytes);
                //println(encodedfile);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return encodedfile;
        }
  public void decodeBase64BinaryToFile(String encoded,String absolutePath){
    byte[] bytes = new byte[encoded.getBytes().length];
    bytes = Base64.getDecoder().decode(encoded);
    try (FileOutputStream fos = new FileOutputStream(absolutePath)) {
       fos.write(bytes);
    } catch(Exception e){println(e);}
  }
}
