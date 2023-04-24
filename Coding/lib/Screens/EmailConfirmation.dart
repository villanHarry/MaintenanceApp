import '../Constants/AppImports.dart';

class EmailConfirmation extends StatefulWidget {
  const EmailConfirmation({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<EmailConfirmation> createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xFF082D50),
              ),
              onPressed: () {
                AppNavigation.popAll(context, const LoginScreen());
              },
            ),
          ),
          title: Text(
            "Email Confirmation",
            style: TextStyle(
                color: const Color(0xFF082D50),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            AppNavigation.popAll(context, const LoginScreen());
            return false;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            height: 0.91.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.7],
                colors: [
                  Colors.white,
                  Color(0xFFC2C2C2),
                ],
              ),
              image: DecorationImage(
                image: AssetImage(AppAssets.bg),
                fit: BoxFit.contain,
                opacity: 0.2,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(32),
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sign Up Successful",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF082D50),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      SizedBox(
                        width: .8.sw,
                        child: Text(
                          "Please check your email(${widget.email}) for a confirmation link, to activate your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
