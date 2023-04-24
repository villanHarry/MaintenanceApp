// ignore_for_file: use_build_context_synchronously

import '../Constants/AppImports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final contact = TextEditingController();
  final floor = TextEditingController();
  final pass = TextEditingController();
  final confPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final _controllerLoading = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  bool loading = false;
  File image = File("");

  @override
  void initState() {
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
            body: Container(
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              AppImageHandler.getImage(
                                      context, ImageSource.gallery)
                                  .then((value) {
                                if (value.path.isNotEmpty) {
                                  setState(() {
                                    image = value;
                                  });
                                }
                              });
                              print("object");
                            },
                            child: Container(
                              width: 0.4.sw,
                              height: 0.4.sw,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                  border: Border.all(),
                                  image: image.path.isNotEmpty
                                      ? DecorationImage(
                                          image: FileImage(image),
                                          fit: BoxFit.cover)
                                      : null),
                              child: image.path.isEmpty
                                  ? const Icon(Icons.add)
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputField(
                                    text: "Full Name",
                                    controller: fullname,
                                    hint: "User Name",
                                    fontSize: 18.sp),
                                SizedBox(height: 10.h),
                                InputField(
                                    text: "Email Address",
                                    controller: email,
                                    hint: "user@gmail.com",
                                    fontSize: 18.sp),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InputField(
                                        width: 0.53.sw,
                                        text: "Contact #",
                                        inputType: TextInputType.number,
                                        maxLength: 11,
                                        controller: contact,
                                        hint: "00",
                                        fontSize: 18.sp),
                                    const Spacer(),
                                    InputField(
                                        width: 0.34.sw,
                                        text: "Floor",
                                        maxLength: 2,
                                        inputType: TextInputType.number,
                                        controller: floor,
                                        hint: "00",
                                        fontSize: 18.sp),
                                  ],
                                ),
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
                        ],
                      ),
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
                    height: 0.02.sh,
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

  void loginFunction() {
    AppNavigation.pop(context);
  }

  bool checkfields() {
    bool value = true;
    if (image.path.isEmpty) {
      value = false;
    }
    if (pass.text != confPass.text) {
      value = false;
    }
    return value;
  }

  void signUpFunction() async {
    if (_formKey.currentState!.validate()) {
      if (checkfields()) {
        loaderStart();
        final bool internet = await AppNetwork.checkInternet();
        if (internet) {
          final bool value = await context.read<AuthController>().signup(
              context,
              fullname.text,
              email.text,
              pass.text,
              image,
              contact.text,
              floor.text);
          if (value) {
            loaderStop();
            AppNavigation.replace(
                context, EmailConfirmation(email: email.text));
          } else {
            loaderStop();
          }
        } else {
          loaderStop();
          AppNavigation.showSnackBar(
              context: context, content: "No Internet Connection");
        }
      } else {
        String error = "";
        if (image.path.isEmpty) {
          error += "Please Select Profile Picture";
        }
        if (pass.text != confPass.text) {
          error += "\n& Password and Confirm Password does not match";
        }
        AppNavigation.showSnackBar(context: context, content: error);
      }
    }
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
    fullname.dispose();
    email.dispose();
    contact.dispose();
    floor.dispose();
    pass.dispose();
    confPass.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
