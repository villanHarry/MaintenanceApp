import '../Constants/AppImports.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: const Color(0xFFEEEFF1),
      appBar: notificationAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.5),
        child: Column(
          children: [
            SizedBox(
              height: 0.02.sh,
            ),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
          ],
        ),
      ),
    );
  }

  AppBar notificationAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFEEEFF1),
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 22.0, top: 5.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xFF082D50),
            size: 30.r,
          ),
          onPressed: () {
            AppNavigation.pop(context);
          },
        ),
      ),
      title: Text(
        "Notifications",
        style: TextStyle(
            color: const Color(0xFF082D50),
            fontSize: 20.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
