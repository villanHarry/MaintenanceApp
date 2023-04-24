import '../Constants/AppImports.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatefulWidget {
  RequestCard(
      {Key? key,
      this.status = "Pending",
      this.admin = false,
      this.isExpanded = false,
      this.category = 'Construction works',
      this.image = "",
      this.username = "",
      this.contactNumber = 0,
      this.floorNumber = 0,
      this.message =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      DateTime? date})
      : date = date ?? DateTime.now();
  String status;
  final bool admin;
  final bool isExpanded;
  final String message;
  final String category;
  final DateTime date;
  final String image;
  final String username;
  final int contactNumber;
  final int floorNumber;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactorAnimation;
  late bool _isExpanded = widget.isExpanded;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightFactorAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        padding: EdgeInsets.all(20.r),
        width: 1.sw,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(bottom: widget.admin && _isExpanded ? 10 : 0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        widget.admin
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 35.r,
                                  width: 35.r,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF082D50),
                                      shape: BoxShape.circle),
                                ),
                              )
                            : const SizedBox.shrink(),
                        widget.admin
                            ? Text(
                                _isExpanded
                                    ? "${widget.username.split(' ')[0]} : Request"
                                    : "${widget.username.split(' ')[0]}: ${DateFormat("dd/MM/yyyy").format(widget.date).toString()}",
                                style: TextStyle(
                                  color: const Color(0xFF082D50),
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Text(
                                _isExpanded
                                    ? "${widget.category.split(' ')[0]} Request"
                                    : "Request: ${DateFormat("dd/MM/yyyy").format(widget.date).toString()}",
                                style: TextStyle(
                                  color: const Color(0xFF082D50),
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: const Color(0xFF082D50),
                      size: 25.r,
                    )
                  ],
                ),
              ),
            ),
            AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: SizedBox(
                  height: _isExpanded ? null : 0,
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey.shade500,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: .015.sw,
                      ),
                      SizedBox(
                        width: 1.sw,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: "Category: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(text: widget.category)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: .015.sw,
                      ),
                      SizedBox(
                        width: 1.sw,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: "Message: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(text: widget.message)
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.admin,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 0.02.sh,
                            ),
                            SizedBox(
                              width: 1.sw,
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: const Color(0xFF082D50),
                                      fontSize: 14.sp,
                                      wordSpacing: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Contact No: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: widget.contactNumber.toString())
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.01.sh,
                            ),
                            SizedBox(
                              width: 1.sw,
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: const Color(0xFF082D50),
                                      fontSize: 14.sp,
                                      wordSpacing: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Floor No: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: widget.floorNumber.toString())
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat("dd/MM/yyyy")
                                .format(widget.date)
                                .toString(),
                            style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          widget.admin
                              ? SizedBox(
                                  width: 0.25.sw,
                                  child: DropdownButton<String>(
                                      value: widget.status,
                                      alignment: Alignment.centerLeft,
                                      iconEnabledColor: Colors.black,
                                      iconDisabledColor: Colors.grey,
                                      iconSize: 20.r,
                                      isExpanded: true,
                                      icon: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                      hint: Text(
                                        widget.status,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: const Color(0xFF082D50),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      underline: Container(),
                                      style: TextStyle(
                                        color: const Color(0xFF082D50),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      items: <String>[
                                        'Pending',
                                        'Processing',
                                        'Completed'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          widget.status = newValue!;
                                        });
                                      }),
                                )
                              : Text(
                                  widget.status,
                                  style: TextStyle(
                                    color: const Color(0xFF082D50),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
