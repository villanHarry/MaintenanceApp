import 'package:maintenance_app/Constants/AppImports.dart';

class AuthController extends ChangeNotifier {
  // constructor
  AuthController(this.context);

  // variables
  final BuildContext context;

  /*
   * description: Function to login user
   */
  Future<bool> login(BuildContext context, String email, String pass) async {
    return await AuthAPI.login(context, email, pass);
  }

  /*
   * description: Function to signup user
   */
  Future<bool> signup(BuildContext context, String username, String email,
      String pass, File image, String contact, String floor) async {
    return await AuthAPI.signup(context, username, email, pass,
        await AppImageHandler.generate(context, image), contact, floor);
  }
}
