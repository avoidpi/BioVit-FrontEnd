public class HttpManager{
  
  String folderPath;
  String fileList[];
  
  void SendFileList(String folderPath,String fileList[]){
    this.folderPath = folderPath;
    this.fileList = fileList;
    
    HttpClient client = HttpClient.newHttpClient();
    HttpRequest request = null;
    try{
    request = HttpRequest.newBuilder()
      .uri(URI.create("http://openjdk.org/"))
      .timeout(Duration.ofMinutes(1))
      .header("Content-Type", "application/json")
      .POST(BodyPublishers.ofFile(Paths.get("file.json")))
      .build();
    }
    catch(FileNotFoundException e){
    }
      
    client.sendAsync(request, HttpResponse.BodyHandlers.ofString())
      .thenApply(HttpResponse::body)
      .thenAccept(System.out::println)
      .join();
  }
  
  //need to take files, get strings in base64, put them into a json and then send them to api
  //also, get back from api a json and parse it for string response
  
  public String encodeFileToBase64Binary(File file){ //this SHOULD read a file,encode the file in base64 and return it as a string
            String encodedfile = null;
            try {
                FileInputStream fileInputStreamReader = new FileInputStream(file);
                byte[] bytes = new byte[(int)file.length()];
                fileInputStreamReader.read(bytes);
                fileInputStreamReader.close();
                encodedfile = Base64.getEncoder().encodeToString(bytes);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            
            return encodedfile;
        }
}
