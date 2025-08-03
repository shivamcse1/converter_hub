class ApiConfig {
   
     // All Api Key 
     static const String cohereApiKey = 'frYAZTVzr70MTeVlhnMgZSlVrIiJzqWRffthkMHM';


     // All Base Url
     static const String cohereBaseUrl = "https://api.cohere.ai/v1/";


     /// All Endpoints
     static const String summarize = "summarize";




     // Headers

     static Map<String,String> getHeaders({
      String contentType = "application/json", 
      required String apiKey
      }){
         return {
          "Content-Type" : contentType,      // Data format which you’re sending
          "Authorization" : "Bearer$apiKey",
          "accept" : "application/json"      // what format you want in return 
         };
     }


}