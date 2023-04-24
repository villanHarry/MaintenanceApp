import '../Constants/AppImports.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({Key? key}) : super(key: key);

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  final admin = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequestCard(admin: admin),
      ],
    );
  }
}
