import '../../Constants/AppImports.dart';
import 'package:http/http.dart' as http;

class RequestAPI extends API {
  // API.url = "https://maintenance-app.herokuapp.com";
  static final String requestUrl = '${API.url}/mntnc/api';

  /*
   * description: get all maintenance requests of user 
   */
  static Future<List<UserRequestDatum>> userRequestList() async {
    final String accessToken = Boxes.getUser().values.first.accessToken;

    var headers = {'Authorization': 'Bearer ${accessToken}'};
    var request = http.Request('GET', Uri.parse('$requestUrl/GetUser'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response res = await http.Response.fromStream(response);
      final model = userRequestModelFromJson(res.body);

      return model.data;
    } else {
      return [];
    }
  }

  static Future<bool> addRequest(String category, String msg) async {
    final String accessToken = Boxes.getUser().values.first.accessToken;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request('POST', Uri.parse('$requestUrl/add'));
    request.body = json.encode({"msg": msg, "category": category});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response res = await http.Response.fromStream(response);
      final model = signUpModelFromJson(res.body);
      if (model.message == "Your Data Saved Successfully") {
        return true;
      } else {
        return false;
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
