// ignore_for_file: use_build_context_synchronously

import '../Constants/AppImports.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, this.changePass = false})
      : super(key: key);

  final bool changePass;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final pass = TextEditingController();
  final confPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final _controllerLoading = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  bool loading = false;

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
              backgroundColor: const Color(0xFFFAFAFA),
              elevation: 0,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF616161),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                widget.changePass ? "Change Password" : "Reset Password",
                style: TextStyle(
                    color: const Color(0xFF616161),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                image: DecorationImage(
                  image: AssetImage(AppAssets.bg),
                  fit: BoxFit.contain,
                  opacity: 0.5,
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
                          text: "Password",
                          controller: pass,
                          hint: '●' * 8,
                          obscure: true,
                          fontSize: 15.sp,
                          borderRadius: .05.sw,
                        ),
                        SizedBox(height: 10.h),
                        InputField(
                          text: "Confirm Password",
                          controller: confPass,
                          hint: '●' * 8,
                          obscure: true,
                          fontSize: 15.sp,
                          borderRadius: .05.sw,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Button(
                    text: widget.changePass ? "Change" : "Reset",
                    borderRadius: .05.sw,
                    color: const Color(0xFF0764BB),
                    height: .075.sh,
                    fontSize: 16.sp,
                    fontColor: Colors.white,
                    onPressed: buttonFunction,
                  ),
                  const Spacer(
                    flex: 3,
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

  bool checkfields() {
    bool value = true;

    if (pass.text != confPass.text) {
      value = false;
    }
    return value;
  }

  void buttonFunction() {
    if (_formKey.currentState!.validate()) {
      if (checkfields()) {
        if (widget.changePass) {
          changePassFunction();
        } else {
          resetFunction();
        }
      } else {
        String error = "";

        if (pass.text != confPass.text) {
          error += "Password and Confirm Password does not match";
        }
        AppNavigation.showSnackBar(context: context, content: error);
      }
    }
  }

  void resetFunction() async {
    loaderStart();
    final bool internet = await AppNetwork.checkInternet();
    if (internet) {
      final bool value =
          await context.read<AuthController>().resetPass(context, pass.text);
      if (value) {
        loaderStop();
        AppNavigation.popAll(context, const LoginScreen());
        AppNavigation.showSnackBar(
            context: context, content: "Password Reset Successfully");
      } else {
        loaderStop();
      }
    } else {
      loaderStop();
      AppNavigation.showSnackBar(
          context: context, content: "No Internet Connection");
    }
  }

  void changePassFunction() async {
    loaderStart();
    final bool internet = await AppNetwork.checkInternet();
    if (internet) {
      final bool value =
          await context.read<AuthController>().changePass(context, pass.text);

      if (value) {
        loaderStop();
        AppNavigation.pop(context);
        AppNavigation.showSnackBar(
            context: context, content: "Password Changed Successfully");
      } else {
        loaderStop();
      }
    } else {
      loaderStop();
      AppNavigation.showSnackBar(
          context: context, content: "No Internet Connection");
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
    pass.dispose();
    confPass.dispose();
    _controllerLoading.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
