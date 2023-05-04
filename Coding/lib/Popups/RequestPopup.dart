// ignore_for_file: use_build_context_synchronously

import 'package:intl/intl.dart';

import '../Constants/AppImports.dart';

class RequestPopup extends StatefulWidget {
  @override
  _RequestPopupState createState() => _RequestPopupState();
}

class _RequestPopupState extends State<RequestPopup> {
  final _messageController = TextEditingController();
  final _dateController = TextEditingController();
  final _reasonController = TextEditingController();
  String category = "Select a Category";
  String timeSlot = "Select a Time Slot";
  bool onpressed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(.05.sw),
      ),
      title: Container(
        height: .14.sw,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
            color: Color(0xFF0C58A0),
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Row(
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              'Request',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            IconButton(
              onPressed: () {
                if (!onpressed) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(top: 8),
      actionsPadding: const EdgeInsets.all(0),
      content: Container(
        padding: const EdgeInsets.all(18),
        width: .85.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFABAAAC))),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Color(0xFFABAAAC),
                ),
              ),
            ),
            SizedBox(
              height: .03.sh,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: .06.sh,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFABAAAC))),
                  child: SizedBox(
                    width: 1.sw,
                    child: DropdownButton<String>(
                        value: category,
                        alignment: Alignment.centerLeft,
                        iconEnabledColor: const Color(0xFF616161),
                        iconDisabledColor: const Color(0xFFABAAAC),
                        iconSize: 20.r,
                        isExpanded: true,
                        icon: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Color(0xFFABAAAC),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        hint: Text(
                          "Select a Category",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0xFFABAAAC),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        underline: Container(),
                        style: TextStyle(
                          color: category == "Select a Category"
                              ? const Color(0xFFABAAAC)
                              : const Color(0xFF616161),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        items: <String>[
                          'Select a Category',
                          'Construction works',
                          'Doors',
                          'gates',
                          'windows',
                          'and other openings',
                          'Lighting',
                          'Plumbing',
                          'Fire equipment',
                          'Heating and Cooling',
                          'Access Control',
                          'Others'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue == "Select a Category") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFFFAFAFA),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Please select a category",
                                      style:
                                          TextStyle(color: Color(0xFF616161)),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            );
                          }
                          if (newValue == "Others") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFFFAFAFA),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Enter a reason",
                                      style:
                                          TextStyle(color: Color(0xFF616161)),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            );
                          }
                          setState(() {
                            category = newValue!;
                          });
                        }),
                  ),
                ),
                Visibility(
                  visible: onpressed,
                  child: Container(
                    height: .06.sh,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                  ),
                )
              ],
            ),
            Visibility(
                visible: category == "Others" ? true : false,
                child: Column(
                  children: [
                    SizedBox(
                      height: .03.sh,
                    ),
                    Container(
                      height: .06.sh,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(.025.sw),
                          border: Border.all(color: const Color(0xFFABAAAC))),
                      child: TextFormField(
                        enabled: !onpressed,
                        controller: _reasonController,
                        style: TextStyle(
                            fontSize: 14.sp, color: const Color(0xFFABAAAC)),
                        decoration: InputDecoration(
                          hintText: 'Reason',
                          hintStyle: TextStyle(
                              fontSize: 14.sp, color: const Color(0xFFABAAAC)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: .03.sh,
            ),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime(DateTime.now().year),
                  firstDate: DateTime(1980, 1, 1),
                  lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _dateController.text =
                          DateFormat("dd/MM/yyyy").format(value);
                    });
                  }
                });
              },
              child: Container(
                height: .06.sh,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(.025.sw),
                    border: Border.all(color: const Color(0xFFABAAAC))),
                child: TextFormField(
                  enabled: false,
                  controller: _dateController,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Preferred Visit',
                    hintStyle: TextStyle(
                        fontSize: 14.sp, color: const Color(0xFFABAAAC)),
                    border: InputBorder.none,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: .06.sw,
                        ),
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFFABAAAC),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: .03.sh,
            ),
            Container(
              height: .06.sh,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFABAAAC))),
              child: SizedBox(
                width: 1.sw,
                child: DropdownButton<String>(
                    value: timeSlot,
                    alignment: Alignment.centerLeft,
                    iconEnabledColor: const Color(0xFF616161),
                    iconDisabledColor: const Color(0xFFABAAAC),
                    iconSize: 20.r,
                    isExpanded: true,
                    icon: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Color(0xFFABAAAC),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                    hint: Text(
                      "Select a Time Slot",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color(0xFFABAAAC),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    underline: Container(),
                    style: TextStyle(
                      color: timeSlot == "Select a Time Slot"
                          ? const Color(0xFFABAAAC)
                          : const Color(0xFF616161),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    items: <String>[
                      'Select a Time Slot',
                      '9:00 AM to 12:00 PM',
                      '12:00 PM to 3:00 PM',
                      '3:00 PM to 6:00 PM',
                      '6:00 PM to 9:00 PM'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == "Select a Time Slot") {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: const Color(0xFFFAFAFA),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Please select a time slot",
                                  style: TextStyle(color: Color(0xFF616161)),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        );
                      }

                      setState(() {
                        timeSlot = newValue!;
                      });
                    }),
              ),
            ),
            SizedBox(
              height: .03.sh,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFABAAAC))),
              child: TextFormField(
                enabled: !onpressed,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFFABAAAC)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
                onTap: () async {
                  if (!onpressed) {
                    if (fieldsValidate()) {
                      sendingFunction();
                    } else {
                      String content = "";
                      if (category == "Select a Category") {
                        content = "\nPlease select a category";
                      }
                      if (timeSlot == "Select a Time Slot") {
                        content += "\nPlease select a time slot";
                      }
                      if (_dateController.text.isEmpty) {
                        content += "\nPlease select a date";
                      }
                      if (category == "Others") {
                        if (_reasonController.text.isEmpty) {
                          content +=
                              "\nPlease enter a reason or choose other category";
                        }
                      }
                      if (_messageController.text.isEmpty) {
                        content += "\nPlease enter a message";
                      }

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF082D50),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                content,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    height: .06.sh,
                    decoration: BoxDecoration(
                        color: const Color(0xFF0764BB),
                        borderRadius: BorderRadius.circular(.03.sw)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Send${onpressed ? "..." : ""}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp)),
                          AnimatedOpacity(
                            opacity: onpressed ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 1000),
                            child: Visibility(
                              visible: onpressed,
                              child: Row(
                                children: [
                                  SizedBox(width: .05.sw),
                                  SizedBox(
                                      height: .05.sw,
                                      width: .05.sw,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )))),
        SizedBox(
          height: .01.sh,
        ),
      ],
    );
  }

  bool fieldsValidate() {
    bool valid = true;
    if (category == "Select a Category") {
      valid = false;
    }
    if (timeSlot == "Select a Time Slot") {
      valid = false;
    }
    if (_dateController.text.isEmpty) {
      valid = false;
    }
    if (category == "Others") {
      if (_reasonController.text.isEmpty) {
        valid = false;
      }
    }
    if (_messageController.text.isEmpty) {
      valid = false;
    }
    return valid;
  }

  sendingFunction() async {
    setState(() {
      onpressed = true;
    });
    final bool internet = await AppNetwork.checkInternet();

    if (internet) {
      final bool result = await RequestAPI.addRequest(
          category == "Others" ? _reasonController.text : category,
          _messageController.text);
      if (result) {
        AppNavigation.showSnackBar(
            context: context, content: "Your Maintenance Added");
        setState(() {});
        context.read<RequestController>().addRequestList(UserRequestDatum(
            id: "0",
            msg: _messageController.text,
            category: category == "Others" ? _reasonController.text : category,
            status: 'Pending',
            user: "0",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 0));
        AppNavigation.pop(context);
      } else {
        setState(() {
          onpressed = false;
        });
      }
    } else {
      setState(() {
        onpressed = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Check your Internet Connection",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );
    }
  }
}
