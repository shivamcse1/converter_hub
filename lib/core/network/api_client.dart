import 'package:converter_hub/core/app_imports.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  // this method is used for getting data
  static Future<void> getData({
    required String apiUrl,
    Map<String, String>? headers,
  }) async {
    try {
      final Uri urlUri = Uri.parse(apiUrl);
      final response = await http.get(urlUri, headers: headers);
      if (response.statusCode == 200) {
        debugPrint("Data fetched successfully");
      } else {
        debugPrint(response.body);
      }
    } catch (ex) {
      debugPrint("Exception occurred while fetching data $ex");
    }
  }

  // this method is used for uploading data

  static Future<void> postData({
    required String baseUrl,
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final Uri urlUri = Uri.parse("$baseUrl$endPoint");

      final response = await http.post(urlUri, body: body, headers: headers);
      if (response.statusCode == 200) {
        debugPrint("Data Updated successfully");
      } else {
        debugPrint(response.body);
      }
    } catch (ex) {
      debugPrint("Exception occurred while uploading data:$ex");
    }
  }
}
