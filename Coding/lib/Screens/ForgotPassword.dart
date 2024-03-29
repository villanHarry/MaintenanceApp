// ignore_for_file: use_build_context_synchronously

import '../Constants/AppImports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final email = TextEditingController();
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

  void sendCodeFunction() async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthController>().setOtpEmail(email.text);
      loaderStart();
      final bool internet = await AppNetwork.checkInternet();
      if (internet) {
        final bool value =
            await context.read<AuthController>().forgotPass(context);
        if (value) {
          loaderStop();
          AppNavigation.push(context, const VerificationScreen());
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
    _controllerLoading.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
