import '../Constants/AppImports.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<OtpField> otp = [
    OtpField(),
    OtpField(),
    OtpField(),
    OtpField(),
    OtpField(),
    OtpField()
  ];

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
            "Verification",
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
              Text(
                "Let’s confirm it’s you",
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
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
                borderRadius: .01.sw,
                color: const Color(0xFF082D50),
                fontColor: Colors.white,
                height: .08.sh,
                fontSize: 17.sp,
                onPressed: verifyFunction,
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ));
  }

  void verifyFunction() {
    //if (_formKey.currentState!.validate()) {}
    AppNavigation.push(context, const ResetPasswordScreen());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
