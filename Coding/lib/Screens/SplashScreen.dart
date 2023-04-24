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
            //color: Color.fromARGB(255, 194, 194, 194),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.4, 0.7],
              colors: [
                Colors.white,
                Color(0xFFEEEFF1),
                Color(0xFFC2C2C2),
              ],
            ),
            image: DecorationImage(
              image: AssetImage(AppAssets.bg),
              fit: BoxFit.contain,
              opacity: 0.4,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
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
                        fontSize: 20.sp,
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
              ),
              const Spacer(),
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
