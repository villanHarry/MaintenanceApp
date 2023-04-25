import 'package:maintenance_app/Constants/AppImports.dart';

class AuthController extends ChangeNotifier {
  // constructor
  AuthController(this.context);

  // variables
  final BuildContext context;
  String _otpEmail = "";

  // getters
  get getOtpEmail => _otpEmail;

  // setters
  setOtpEmail(String email) {
    _otpEmail = email;
    notifyListeners();
  }

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

  /*
   * description: Function to send user otp to email
   */
  Future<bool> forgotPass(BuildContext context) async {
    return await AuthAPI.forgotPassword(context, _otpEmail);
  }

  /*
   * description: Function to verify user otp
   */
  Future<bool> otpVerify(BuildContext context, String otp) async {
    return await AuthAPI.otpVerification(context, _otpEmail, otp);
  }

  /*
   * description: Function to reset pass
   */
  Future<bool> resetPass(BuildContext context, String pass) async {
    return await AuthAPI.resetPass(context, _otpEmail, pass);
  }

  /*
   * description: Function to reset pass
   */
  Future<bool> changePass(BuildContext context, String pass) async {
    return await AuthAPI.changePass(context, pass);
  }
}
