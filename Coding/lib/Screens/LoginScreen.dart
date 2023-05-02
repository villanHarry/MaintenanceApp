// ignore_for_file: use_build_context_synchronously
import '../Constants/AppImports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final _controllerLoading = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  bool onpressed = false;
  bool loading = false;
  bool animated = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 270), () {});
    _controllerLoading.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerLoading.reset();
        _controllerLoading.forward();
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: WillPopScope(
              onWillPop: () async {
                if (onpressed) {
                  return true;
                } else {
                  onpressed = true;
                  AppNavigation.showSnackBar(
                      context: context, content: "Press again to exit");
                  Future.delayed(const Duration(seconds: 2), () {
                    onpressed = false;
                  });
                }
                return false;
              },
              child: Container(
                height: 1.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(AppAssets.bg2),
                    fit: BoxFit.contain,
                    opacity: 0.5,
                    alignment: Alignment.topCenter,
                    colorFilter: ColorFilter.mode(
                        const Color(0xFF012B85).withOpacity(0.8),
                        BlendMode.color),
                  ),
                ),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Container(
                      height: .7.sh,
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 10,
                                offset: const Offset(0, 8))
                          ]),
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),
                          Text(
                            "Login",
                            style: TextStyle(
                                color: const Color(0xFF616161),
                                fontSize: 20.sp,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 25.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputField(
                                  text: "Email Address",
                                  controller: email,
                                  hint: "user@gmail.com",
                                  fontSize: 15.sp,
                                  borderRadius: .05.sw,
                                ),
                                SizedBox(height: 10.h),
                                InputField(
                                  text: "Password",
                                  controller: password,
                                  hint: '●' * 8,
                                  obscure: true,
                                  fontSize: 15.sp,
                                  borderRadius: .05.sw,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: forgotPasswordFunction,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Forgot Password?",
                                    style: TextStyle(
                                        color: const Color(0xFF616161),
                                        fontSize: 14.sp,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            const Color(0xFF616161))),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Button(
                            text: "Login",
                            borderRadius: .05.sw,
                            color: const Color(0xFF0764BB),
                            fontColor: Colors.white,
                            height: .075.sh,
                            fontSize: 16.sp,
                            onPressed: loginFunction,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: signUpFunction,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ",
                                    style: TextStyle(
                                      color: const Color(0xFF616161),
                                      fontSize: 14.sp,
                                    )),
                                Text("SignUp",
                                    style: TextStyle(
                                        color: const Color(0xFF0C58A0),
                                        fontSize: 14.sp,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            const Color(0xFF0C58A0))),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Visibility(
          visible: loading,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.white,
                width: 1.sw,
                height: 1.sh,
              ),
              Lottie.asset(AppAssets.loader,
                  fit: BoxFit.fill,
                  frameRate: FrameRate(60),
                  width: .8.sw,
                  controller: _controllerLoading,
                  onLoaded: (composition) {}),
            ],
          ),
        )
      ],
    );
  }

  void loginFunction() async {
    if (_formKey.currentState!.validate()) {
      loaderStart();
      final bool internet = await AppNetwork.checkInternet();
      if (internet) {
        final bool value = await context
            .read<AuthController>()
            .login(context, email.text, password.text);
        if (value) {
          loaderStop();
          if (Boxes.getUser().values.first.usertype == "admin") {
            AppNavigation.replace(
                context,
                const HomeScreen(
                  admin: true,
                ));
          } else {
            AppNavigation.replace(context, const HomeScreen());
          }
        } else {
          loaderStop();
        }
      } else {
        loaderStop();
        AppNavigation.showSnackBar(
            context: context, content: "No Internet Connection");
      }
    }
  }

  void signUpFunction() {
    AppNavigation.push(context, const SignUpScreen());
  }

  void forgotPasswordFunction() {
    AppNavigation.push(context, const ForgotPasswordScreen());
  }

  loaderStart() {
    setState(() {
      loading = true;
    });
    _controllerLoading.forward();
  }

  loaderStop() {
    setState(() {
      loading = false;
    });
    _controllerLoading.reset();
    _controllerLoading.stop();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    _controllerLoading.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
