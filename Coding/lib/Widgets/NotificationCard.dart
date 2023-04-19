import '../Constants/AppImports.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Request Accepted",
                style: TextStyle(
                    color: const Color(0xFF082D50),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                "Your request has been accepted by the service provider",
                style: TextStyle(
                    color: const Color(0xFF082D50),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "12:00 PM",
                    style: TextStyle(
                        color: const Color(0xFF082D50),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
