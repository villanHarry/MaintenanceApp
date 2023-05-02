// ignore_for_file: use_build_context_synchronously

import '../Constants/AppImports.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final List<OtpField> otp = [
    OtpField(),
    OtpField(),
    OtpField(),
    OtpField(),
    OtpField(),
    OtpField()
  ];
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
                "Verification",
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
                  Text(
                    "Let’s confirm it’s you",
                    style: TextStyle(
                        fontSize: 24.sp, color: const Color(0xFF616161)),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          color: const Color(0xFF949494),
                          letterSpacing: 0.5,
                          height: 1.h,
                          fontSize: 13.sp),
                      children: const <TextSpan>[
                        TextSpan(text: "We sent a 6-digit code on "),
                        TextSpan(
                            text: 'email@example.com',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ", to continue please enter that code.")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: otp,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Button(
                    text: "Verify",
                    borderRadius: .05.sw,
                    color: const Color(0xFF0764BB),
                    height: .075.sh,
                    fontSize: 16.sp,
                    fontColor: Colors.white,
                    onPressed: verifyFunction,
                  ),
                  const Spacer(
                    flex: 5,
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

  void verifyFunction() async {
    if (_formKey.currentState!.validate()) {
      String otpValue = "";
      for (var i = 0; i < otp.length; i++) {
        otpValue += otp[i].controller.text;
      }
      loaderStart();
      final bool internet = await AppNetwork.checkInternet();
      if (internet) {
        final bool value =
            await context.read<AuthController>().otpVerify(context, otpValue);
        if (value) {
          loaderStop();
          AppNavigation.replace(context, const ResetPasswordScreen());
          AppNavigation.showSnackBar(
              context: context, content: "OTP Verified Successfully");
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
    _controllerLoading.dispose();
    for (var element in otp) {
      element.controller.dispose();
    }
    // TODO: implement dispose
    super.dispose();
  }
}
