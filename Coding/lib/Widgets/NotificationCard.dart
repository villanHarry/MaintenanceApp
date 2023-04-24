import '../Constants/AppImports.dart';

class NotificationCard extends StatefulWidget {
  NotificationCard(
      {Key? key,
      this.title = "Request Accepted",
      this.des = "Your request has been accepted by the service provider",
      DateTime? time})
      : time = time ?? DateTime.now();

  final String title;
  final String des;
  final DateTime time;

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
                widget.title,
                style: TextStyle(
                    color: const Color(0xFF082D50),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                widget.des,
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
                    TimeOfDay.fromDateTime(widget.time).format(context),
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
