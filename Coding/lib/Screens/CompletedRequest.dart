import '../Constants/AppImports.dart';

class CompletedRequests extends StatefulWidget {
  const CompletedRequests({Key? key}) : super(key: key);

  @override
  State<CompletedRequests> createState() => _CompletedRequestsState();
}

class _CompletedRequestsState extends State<CompletedRequests>
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
    context.read<RequestController>().setCompletedRequests(
        await RequestAPI.adminRequestList(AppConstant.statusList[2]));
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
                return Expanded(
                  child: ListView.builder(
                      itemCount: context
                          .watch<RequestController>()
                          .getCompletedRequests
                          .length,
                      itemBuilder: (context, index) {
                        return RequestCard(
                          admin: admin,
                          message: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .msg,
                          date: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .createdAt,
                          status: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .status,
                          category: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .category,
                          id: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .id,
                          image: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .user
                              .image,
                          username: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .user
                              .username,
                          floorNumber: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .user
                              .floorNumber,
                          contactNumber: context
                              .read<RequestController>()
                              .getCompletedRequests[index]
                              .user
                              .contactNumber,
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
                      height: .7.sh,
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
    );
  }
}
