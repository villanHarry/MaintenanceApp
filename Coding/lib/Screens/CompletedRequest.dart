import '../Constants/AppImports.dart';

class CompletedRequests extends StatefulWidget {
  const CompletedRequests({Key? key}) : super(key: key);

  @override
  State<CompletedRequests> createState() => _CompletedRequestsState();
}

class _CompletedRequestsState extends State<CompletedRequests> {
  final admin = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequestCard(),
      ],
    );
  }
}
