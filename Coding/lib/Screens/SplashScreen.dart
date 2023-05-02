import '../Constants/AppImports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (Boxes.getUser().isEmpty) {
          AppNavigation.replace(context, const LoginScreen());
        } else {
          final box = Boxes.getUser().values.first;
          print(box.accessToken);
          if (box.usertype == "admin") {
            AppNavigation.popAll(
                context,
                const HomeScreen(
                  admin: true,
                ));
          } else {
            AppNavigation.popAll(context, const HomeScreen());
          }
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                AppAssets.logo,
                height: 0.2.sh,
                width: 0.2.sh,
              ),
              Text("Welcome to \nGPS Help Desk",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF616161),
                    fontSize: 18.sp,
                  )),
              /*Container(
                padding: EdgeInsets.all(0.08.sh),
                decoration: BoxDecoration(
                    color: const Color(0xFFEEEFF1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 30,
                        spreadRadius: 1,
                        offset: Offset(0, 0.08.sw),
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: const Color(0xFF082D50),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Help Desk',
                      style: TextStyle(
                        color: const Color(0xFF082D50),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),*/
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 5.h),
                decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 10,
                          offset: const Offset(0, 8))
                    ]),
                child: Text("Powered by Nexovia Digital",
                    style: TextStyle(
                      color: const Color(0xFF616161),
                      fontSize: 15.sp,
                    )),
              ),
              SizedBox(
                height: 25.h,
              ),
              LinearProgressIndicator(
                minHeight: 4.h,
                backgroundColor: const Color(0xFFC2C2C2),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF082D50)),
              ),
            ],
          )),
    );
  }
}
