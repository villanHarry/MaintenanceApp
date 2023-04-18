import '../Constants/AppImports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                Icons.arrow_back_ios,
                color: Color(0xFF082D50),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            "Forgot Password",
            style: TextStyle(
                color: const Color(0xFF082D50),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          height: 1.sh,
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                        text: "Email Address",
                        controller: email,
                        hint: "user@gmail.com",
                        fontSize: 18.sp),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Button(
                text: "Send Code",
                borderRadius: .01.sw,
                color: const Color(0xFF082D50),
                fontColor: Colors.white,
                height: .08.sh,
                fontSize: 17.sp,
                onPressed: sendCodeFunction,
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ));
  }

  void sendCodeFunction() {
    //if (_formKey.currentState!.validate()) {}
    AppNavigation.push(context, const VerificationScreen());
  }

  @override
  void dispose() {
    email.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
