import 'package:maintenance_app/Services/APIs/AuthAPI.dart';

import '../Constants/AppImports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.admin = false}) : super(key: key);

  final bool admin;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController tabController =
      TabController(length: 3, vsync: this);
  late final bool admin = widget.admin;
  final currentUser = Boxes.getUser().values.first;
  late final _controllerLoading = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  bool onpressed = false;
  List<bool> isSelected = [true, false, false];
  String dropDown = "this week";
  List<UserRequestDatum> requestList = [];

  Future<bool> getRequests() async {
    context
        .read<RequestController>()
        .setRequestList(await RequestAPI.userRequestList());
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (admin) {
      tabController.addListener(() {
        setState(() {
          tabSelection(tabController.index);
        });
      });
    }
    _controllerLoading.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerLoading.reset();
        _controllerLoading.forward();
      }
    });
  }

  tabSelection(int value) {
    for (var i = 0; i < isSelected.length; i++) {
      setState(() {
        isSelected[i] = false;
      });
    }
    setState(() {
      isSelected[value] = true;
      tabController.index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: true,
        backgroundColor: const Color(0xFFEEEFF1),
        floatingActionButton: admin
            ? null
            : FloatingActionButton(
                backgroundColor: const Color(0xFF082D50),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    barrierColor: const Color(0xBB082D50),
                    context: context,
                    builder: (BuildContext context) {
                      return RequestPopup();
                    },
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 20.r,
                ),
              ),
        drawer: homeDrawer(),
        appBar: homeAppBar(),
        body: WillPopScope(
          onWillPop: () async {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.openEndDrawer();
            } else {
              if (onpressed) {
                return true;
              } else {
                onpressed = true;
                AppNavigation.showSnackBar(
                    context: context, content: "Press again to exit");
                Future.delayed(const Duration(seconds: 2), () {
                  onpressed = false;
                });
              }
            }
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.5),
            child: Column(
              children: [
                SizedBox(
                  height: 0.02.sh,
                ),
                Visibility(
                  visible: admin,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                tabSelection(0);
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.r),
                                decoration: BoxDecoration(
                                  color: isSelected[0]
                                      ? const Color(0xFF082D50)
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10.r)),
                                ),
                                child: Text(
                                  "Pending",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !isSelected[0]
                                        ? const Color(0xFF082D50)
                                        : Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                tabSelection(1);
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.r),
                                decoration: BoxDecoration(
                                    color: isSelected[1]
                                        ? const Color(0xFF082D50)
                                        : Colors.grey.shade300,
                                    border: Border.symmetric(
                                        vertical: BorderSide(
                                            color: const Color(0xFF082D50),
                                            width: 0.2.w))),
                                child: Text(
                                  "Processing",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !isSelected[1]
                                        ? const Color(0xFF082D50)
                                        : Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                tabSelection(2);
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.r),
                                decoration: BoxDecoration(
                                  color: isSelected[2]
                                      ? const Color(0xFF082D50)
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10.r)),
                                ),
                                child: Text(
                                  "Completed",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !isSelected[2]
                                        ? const Color(0xFF082D50)
                                        : Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.filter_alt_rounded,
                                color: const Color(0xFF082D50),
                                size: 20.r,
                              ),
                              Text(
                                "Filter",
                                style: TextStyle(
                                  color: const Color(0xFF082D50),
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 0.3.sw,
                            child: DropdownButton<String>(
                                value: dropDown,
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
                                  "this week",
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
                                  'this week',
                                  'this month',
                                  'this year'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropDown = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade500,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                    ],
                  ),
                ),
                admin == true
                    ? Expanded(
                        child: TabBarView(
                            controller: tabController,
                            children: const [
                              PendingRequests(),
                              ProcessingRequests(),
                              CompletedRequests(),
                            ]),
                      )
                    : FutureBuilder(
                        future: getRequests(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: context
                                      .watch<RequestController>()
                                      .getRequestList
                                      .length,
                                  itemBuilder: (context, index) {
                                    return RequestCard(
                                      message: context
                                          .read<RequestController>()
                                          .getRequestList[index]
                                          .msg,
                                      date: context
                                          .read<RequestController>()
                                          .getRequestList[index]
                                          .createdAt,
                                      status: context
                                          .read<RequestController>()
                                          .getRequestList[index]
                                          .status,
                                      category: context
                                          .read<RequestController>()
                                          .getRequestList[index]
                                          .category,
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
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFEEEFF1),
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 22.0, top: 5.0),
        child: IconButton(
          icon: Icon(
            Icons.menu,
            color: const Color(0xFF082D50),
            size: 30.r,
          ),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      title: Text(
        "Help Desk",
        style: TextStyle(
            color: const Color(0xFF082D50),
            fontSize: 20.sp,
            fontWeight: FontWeight.w400),
      ),
      actions: [
        InkWell(
          onTap: () {
            AppNavigation.push(context, const NotificationScreen());
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0.02.sw, 0.05.sw, 0),
            child: Icon(
              Icons.notifications_sharp,
              color: const Color(0xFF082D50),
              size: 28.r,
            ),
          ),
        ),
      ],
    );
  }

  Padding homeDrawer() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0.01.sw, 0, 0),
        child: Container(
            height: 1.sh,
            width: .85.sw,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEFF1),
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(20.r),
              ),
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.05.sw, vertical: 0.02.sw),
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: () =>
                            scaffoldKey.currentState!.closeDrawer(),
                        icon: Icon(
                          Icons.close_rounded,
                          color: const Color(0xFF082D50),
                          size: 25.r,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.05.sh, 0, 0),
                child: CachedNetworkImage(
                  imageUrl: currentUser.image,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 0.4.sw,
                    height: 0.4.sw,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      Container(
                    width: 0.4.sw,
                    height: 0.4.sw,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                      border: Border.all(
                        color: const Color(0xFF082D50),
                      ),
                    ),
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      strokeWidth: 2.5,
                      color: const Color(0xDA082D50),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Color(0xFF082D50),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.02.sh, 0, 0),
                child: Text(
                  currentUser.username,
                  style: TextStyle(
                    color: const Color(0xFF082D50),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.01.sh, 0, 0),
                  child: Text(currentUser.email,
                      style: TextStyle(
                          color: const Color(0xFF082D50),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.01.sh, 0, 0),
                  child: SizedBox(
                    width: 0.52.sw,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: const Color(0xFF082D50),
                            fontSize: 14.5.sp,
                            wordSpacing: 1.5),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Contact No: ',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(
                              text:
                                  '0${currentUser.contactNumber.toString().substring(0, 3)}-${currentUser.contactNumber.toString().substring(4)}')
                        ],
                      ),
                    ),
                  )),
              Visibility(
                visible: !widget.admin,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.01.sh, 0, 0),
                    child: SizedBox(
                      width: 0.52.sw,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 14.5.sp,
                              wordSpacing: 1.5),
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Floor No: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(text: currentUser.floorNumber.toString()),
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.025.sh),
                child: SizedBox(
                  width: 0.65.sw,
                  child: const Divider(
                    color: Color(0xFF082D50),
                    thickness: 1.25,
                  ),
                ),
              ),
              /*Padding(
                  padding: EdgeInsets.fromLTRB(.04.sw, 0.01.sh, 0, 0),
                  child: InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.closeDrawer();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
                          child: Icon(
                            Icons.edit,
                            color: const Color(0xFF082D50),
                            size: 25.r,
                          ),
                        ),
                        SizedBox(
                          width: 0.025.sw,
                        ),
                        Text("Edit Profile",
                            style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  )),*/
              Padding(
                  padding: EdgeInsets.fromLTRB(.04.sw, 0.01.sh, 0, 0),
                  child: InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.closeDrawer();
                      AppNavigation.push(
                          context,
                          const ResetPasswordScreen(
                            changePass: true,
                          ));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
                          child: Icon(
                            Icons.lock,
                            color: const Color(0xFF082D50),
                            size: 25.r,
                          ),
                        ),
                        SizedBox(
                          width: 0.025.sw,
                        ),
                        Text("Change Password",
                            style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(.04.sw, 0.03.sh, 0, 0),
                  child: InkWell(
                    onTap: () {
                      AuthAPI.logout();
                      AppNavigation.popAll(context, const LoginScreen());
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
                          child: Icon(
                            Icons.power_settings_new_rounded,
                            color: const Color(0xFF082D50),
                            size: 25.r,
                          ),
                        ),
                        SizedBox(
                          width: 0.025.sw,
                        ),
                        Text("Logout",
                            style: TextStyle(
                              color: const Color(0xFF082D50),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ))
            ])));
  }

  @override
  void dispose() {
    _controllerLoading.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
