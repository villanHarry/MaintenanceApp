import '../Constants/AppImports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final confPass = TextEditingController();
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
            "SignUp",
            style: TextStyle(
                color: const Color(0xFF082D50),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: SingleChildScrollView(
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
                SizedBox(height: 25.h),
                Container(
                  width: 0.4.sw,
                  height: 0.4.sw,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                      border: Border.all()),
                  child:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                ),
                SizedBox(height: 25.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                          text: "Full Name",
                          controller: email,
                          hint: "User Name",
                          fontSize: 18.sp),
                      SizedBox(height: 10.h),
                      InputField(
                          text: "Email Address",
                          controller: email,
                          hint: "user@gmail.com",
                          fontSize: 18.sp),
                      SizedBox(height: 10.h),
                      InputField(
                          text: "Password",
                          controller: pass,
                          hint: '●' * 8,
                          obscure: true,
                          fontSize: 18.sp),
                      SizedBox(height: 10.h),
                      InputField(
                          text: "Confirm Password",
                          controller: confPass,
                          hint: '●' * 8,
                          obscure: true,
                          fontSize: 18.sp),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Button(
                  text: "SignUp",
                  borderRadius: .01.sw,
                  color: const Color(0xFF082D50),
                  fontColor: Colors.white,
                  height: .08.sh,
                  fontSize: 17.sp,
                  onPressed: signUpFunction,
                ),
                SizedBox(
                  height: 0.1.sh,
                ),
                InkWell(
                  onTap: loginFunction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",
                          style: TextStyle(
                            color: const Color(0xFF082D50),
                            fontSize: 17.sp,
                          )),
                      Text("Login",
                          style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 17.sp,
                              decoration: TextDecoration.underline,
                              decorationColor: const Color(0xFF082D50))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void loginFunction() {
    AppNavigation.pop(context);
  }

  void signUpFunction() {
    //if (_formKey.currentState!.validate()) {}
    AppNavigation.popAll(context, const HomeScreen());
  }

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    pass.dispose();
    confPass.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
