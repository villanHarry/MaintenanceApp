import '../Constants/AppImports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final _controllerLoading = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  @override
  void initState() {
    _controllerLoading.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerLoading.reset();
        _controllerLoading.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: notificationAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 0.02.sh,
          ),
          FutureBuilder(
              future: AuthAPI.notificationList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NotificationDatum>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return NotificationCard(
                            title: snapshot.data![index].title,
                            des: snapshot.data![index].des,
                            time: snapshot.data![index].updatedAt,
                          );
                        }),
                  );
                } else {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.transparent,
                        width: 1.sw,
                        height: .8.sh,
                      ),
                      Lottie.asset(AppAssets.loader,
                          fit: BoxFit.fill,
                          frameRate: FrameRate(60),
                          width: .8.sw,
                          controller: _controllerLoading,
                          onLoaded: (composition) {
                        _controllerLoading.forward();
                      }),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }

  AppBar notificationAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA),
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 22.0, top: 5.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF616161),
          ),
          onPressed: () {
            AppNavigation.pop(context);
          },
        ),
      ),
      title: Text("Notifications",
          style: TextStyle(
              color: const Color(0xFF616161),
              fontSize: 17.sp,
              fontWeight: FontWeight.w400)),
    );
  }

  @override
  void dispose() {
    _controllerLoading.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
