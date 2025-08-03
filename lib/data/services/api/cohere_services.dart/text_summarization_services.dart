import 'package:converter_hub/core/network/api_client.dart';
import 'package:converter_hub/core/network/api_config.dart';

class TextSummarizationServices {
  
  Future<void> summarizeText() async {
    final headers = ApiConfig.getHeaders(apiKey: ApiConfig.cohereApiKey);
    final summarizeText = ApiClient.postData(
      baseUrl: ApiConfig.cohereBaseUrl,
      endPoint: ApiConfig.summarize,
      body: {},
      headers: headers,
    );
  }
}
