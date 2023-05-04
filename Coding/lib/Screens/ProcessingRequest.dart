import '../Constants/AppImports.dart';

class ProcessingRequests extends StatefulWidget {
  const ProcessingRequests({Key? key}) : super(key: key);

  @override
  State<ProcessingRequests> createState() => _ProcessingRequestsState();
}

class _ProcessingRequestsState extends State<ProcessingRequests>
    with SingleTickerProviderStateMixin {
  final admin = true;

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
    // TODO: implement initState
    super.initState();
  }

  Future<bool> getRequests() async {
    context.read<RequestController>().setProcessingRequests(
        await RequestAPI.adminRequestList(AppConstant.statusList[1]));
    return true;
  }

  @override
  void dispose() {
    _controllerLoading.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getRequests(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (context
                    .read<RequestController>()
                    .getProcessingRequests
                    .isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "No Requests Found",
                        style: TextStyle(
                          color: const Color(0xFF616161),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: context
                            .watch<RequestController>()
                            .getProcessingRequests
                            .length,
                        itemBuilder: (context, index) {
                          return RequestCard(
                            admin: admin,
                            message: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .msg,
                            date: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .createdAt,
                            status: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .status,
                            category: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .category,
                            id: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .id,
                            image: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .user
                                .image,
                            username: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .user
                                .username,
                            floorNumber: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .user
                                .floorNumber,
                            contactNumber: context
                                .read<RequestController>()
                                .getProcessingRequests[index]
                                .user
                                .contactNumber,
                          );
                        }),
                  );
                }
              } else {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: 1.sw,
                      height: .65.sh,
                    ),
                    Lottie.asset(AppAssets.loader,
                        fit: BoxFit.fill,
                        frameRate: FrameRate(60),
                        width: .4.sw,
                        controller: _controllerLoading,
                        onLoaded: (composition) {
                      _controllerLoading.forward();
                    }),
                  ],
                );
              }
            }),
      ],
    );
  }
}
