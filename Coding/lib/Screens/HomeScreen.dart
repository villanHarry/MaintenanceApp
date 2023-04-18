import '../Constants/AppImports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController tabController =
      TabController(length: 3, vsync: this);
  final bool admin = false;
  bool onpressed = false;
  List<bool> isSelected = [true, false, false];
  String dropDown = "this week";

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
                            width: 0.25.sw,
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
                    : Column(
                        children: [
                          RequestCard(),
                        ],
                      )
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
          onTap: () {},
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
            width: .8.sw,
            decoration: BoxDecoration(
              color: const Color(0xFF082D50),
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
                          color: Colors.white,
                          size: 25.r,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.05.sh, 0, 0),
                child: Container(
                  width: 0.4.sw,
                  height: 0.4.sw,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                      border: Border.all()),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0.02.sh, 0, 0),
                child: Text(
                  "User Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0.01.sh, 0, 0),
                  child: Text("user@email.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      )))
            ])));
  }
}
