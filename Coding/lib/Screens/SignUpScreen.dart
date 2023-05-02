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
  String dropDown = "Select a Building";
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
                "SignUp",
                style: TextStyle(
                    color: const Color(0xFF616161),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              height: 0.91.sh,
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
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 0.57.sh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
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
                                      },
                                      child: Container(
                                        width: 0.25.sw,
                                        height: 0.25.sw,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: image.path.isNotEmpty
                                              ? DecorationImage(
                                                  image: FileImage(image),
                                                  fit: BoxFit.cover)
                                              : null,
                                          border: Border.all(
                                            color: const Color(0xFFABAAAC),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: image.path.isEmpty
                                            ? const Icon(
                                                Icons.add,
                                                color: Color(0xFFABAAAC),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      children: [
                                        InputField(
                                          text: "Full Name",
                                          controller: fullname,
                                          hint: "User Name",
                                          fontSize: 15.sp,
                                          borderRadius: .05.sw,
                                          width: .6.sw,
                                        ),
                                        SizedBox(height: 10.h),
                                        Container(
                                          height: .072.sh,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFFAFAFA),
                                              borderRadius:
                                                  BorderRadius.circular(.05.sw),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFABAAAC))),
                                          child: SizedBox(
                                            width: .53.sw,
                                            child: DropdownButton<String>(
                                                value: dropDown,
                                                alignment: Alignment.centerLeft,
                                                iconEnabledColor:
                                                    const Color(0xFF616161),
                                                iconDisabledColor:
                                                    const Color(0xFFABAAAC),
                                                iconSize: 20.r,
                                                isExpanded: true,
                                                icon: const Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: Color(0xFFABAAAC),
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                hint: Text(
                                                  "Select a Building",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFABAAAC),
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                underline: Container(),
                                                style: TextStyle(
                                                  color: dropDown ==
                                                          "Select a Building"
                                                      ? const Color(0xFFABAAAC)
                                                      : const Color(0xFF082D50),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                items: <String>[
                                                  'Select a Building',
                                                  'Pearl Tower - PT1',
                                                  'Pearl Tower - PT2',
                                                  'Reef Tower - RT1',
                                                  'Reef Tower - RT2',
                                                  'Coral Tower South - CTS',
                                                  'Coral Tower North - CTN'
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  if (newValue ==
                                                      "Select a Building") {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFFFAFAFA),
                                                        content: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              "Please Select a Building",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF616161)),
                                                            ),
                                                          ],
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                    );
                                                  }

                                                  setState(() {
                                                    dropDown = newValue!;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                InputField(
                                  text: "Email Address",
                                  controller: email,
                                  hint: "user@gmail.com",
                                  fontSize: 15.sp,
                                  borderRadius: .05.sw,
                                ),
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
                                      fontSize: 15.sp,
                                      borderRadius: .05.sw,
                                    ),
                                    const Spacer(),
                                    InputField(
                                      width: 0.34.sw,
                                      text: "Floor",
                                      maxLength: 2,
                                      inputType: TextInputType.number,
                                      controller: floor,
                                      hint: "00",
                                      fontSize: 15.sp,
                                      borderRadius: .05.sw,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Button(
                    text: "SignUp",
                    fontColor: Colors.white,
                    borderRadius: .05.sw,
                    color: const Color(0xFF0764BB),
                    height: .075.sh,
                    fontSize: 16.sp,
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
                              color: const Color(0xFF616161),
                              fontSize: 15.sp,
                            )),
                        Text("Login",
                            style: TextStyle(
                                color: const Color(0xFF0C58A0),
                                fontSize: 15.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xFF0C58A0))),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
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
