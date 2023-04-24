import 'package:http/http.dart' as http;
import '../../Constants/AppImports.dart';

class AuthAPI extends API {
  // API.url = "https://maintenance-app.herokuapp.com";
  static final String authUrl = '${API.url}/user/api';

  /*
   * description: Function to login user
   */
  static Future<bool> login(
      BuildContext context, String email, String pass) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('$authUrl/login'));
    request.body = json.encode({"email": email, "password": pass});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response res = await http.Response.fromStream(response);
      final model = loginModelFromJson(res.body);
      if (model.message == "Loggedin Successfully") {
        final box = Boxes.getUser();

        final User newUser = User()
          ..accessToken = model.loginData.accessToken
          ..email = model.loginData.loginUser.email
          ..id = model.loginData.loginUser.id
          ..username = model.loginData.loginUser.username
          ..image = model.loginData.loginUser.image
          ..usertype = model.loginData.loginUser.usertype
          ..contactNumber = model.loginData.loginUser.contactNumber
          ..floorNumber = model.loginData.loginUser.floorNumber;

        box.add(newUser);

        return true;
      } else {
        AppNavigation.showSnackBar(context: context, content: model.message);
        return false;
      }
    } else {
      AppNavigation.showSnackBar(
          context: context,
          content:
              'Internal Error ${response.statusCode}: ${response.reasonPhrase}');
      return false;
    }
  }

  /*
   * description: Function to signup user
   */

  static Future<bool> signup(
      BuildContext context,
      String username,
      String email,
      String pass,
      String image,
      String contact,
      String floor) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$authUrl/signup'));
    request.body = json.encode({
      "username": username,
      "email": email,
      "password": pass,
      "image": image,
      "contact": contact,
      "floor": floor
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response res = await http.Response.fromStream(response);
      final model = signUpModelFromJson(res.body);
      if (model.message == "Your Data Saved Successfully") {
        return true;
      } else {
        AppNavigation.showSnackBar(context: context, content: model.message);
        return false;
      }
    } else {
      AppNavigation.showSnackBar(
          context: context,
          content:
              'Internal Error ${response.statusCode}: ${response.reasonPhrase}');
      return false;
    }
  }

  /*
   * description: Function to get user notification list
   */
  static Future<List<NotificationDatum>> notificationList() async {
    var headers = {
      'Authorization': 'Bearer ${Boxes.getUser().values.first.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('${authUrl}/getNotification'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response res = await http.Response.fromStream(response);
      final model = notificationModelFromJson(res.body);
      return model.data;
    } else {
      return [];
    }
  }

  /*
   * description: Function to logout user
   */
  static logout() {
    final box = Boxes.getUser();
    box.clear();
  }
}
