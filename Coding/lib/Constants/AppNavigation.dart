import '../Constants/AppImports.dart';

class AppNavigation {
  //Push Screen in the Stack
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  //Pop Screen out of the Stack
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  //Replace Screen with the top most Screen of the Stack
  static void replace(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  //Pop all the Screen from the Stack till the lowest most and then reaplace it with the Another Screen
  static void popAll(BuildContext context, Widget screen) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static void showSnackBar(
      {required BuildContext context, required String content}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Padding(
          padding: EdgeInsets.only(
            // top: height * 0.6,
            left: width * 0.015,
            right: width * 0.015,
            bottom: 0,
          ),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: width * 0.025),
              // ignore: sort_child_properties_last
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: SizedBox(
                      width: width * 0.5,
                      child: Text(
                        content,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: const Color(0xFF082D50),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )));
  }
}
