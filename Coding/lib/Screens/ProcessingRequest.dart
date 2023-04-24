import '../Constants/AppImports.dart';

class ProcessingRequests extends StatefulWidget {
  const ProcessingRequests({Key? key}) : super(key: key);

  @override
  State<ProcessingRequests> createState() => _ProcessingRequestsState();
}

class _ProcessingRequestsState extends State<ProcessingRequests> {
  final admin = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequestCard(
          admin: admin,
        ),
      ],
    );
  }
}
