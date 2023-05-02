import 'package:intl/intl.dart';

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
      padding: const EdgeInsets.only(bottom: 20.0, left: 22.5, right: 22.5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: const Color(0xFF616161).withOpacity(0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 7,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: const Color(0xFF616161),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                widget.des,
                style: TextStyle(
                    color: const Color(0xFF949494),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${DateFormat("dd/MM/yyyy").format(widget.time)} at ${TimeOfDay.fromDateTime(widget.time).format(context)}',
                    style: TextStyle(
                        color: const Color(0xFF949494),
                        fontSize: 13.sp,
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
