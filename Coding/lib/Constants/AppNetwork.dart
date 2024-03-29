import '../Constants/AppImports.dart';

class AppNetwork {
  static Future<bool> checkInternet() async {
    late bool internet = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      internet = false;
    }
    return internet;
  }
}
