import '../Constants/AppImports.dart';

class RequestPopup extends StatefulWidget {
  @override
  _RequestPopupState createState() => _RequestPopupState();
}

class _RequestPopupState extends State<RequestPopup> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            color: Color(0xFF082D50),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: const Text(
          'Request',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 22.5),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(top: 8),
      actionsPadding: const EdgeInsets.all(0),
      content: Container(
        padding: const EdgeInsets.all(18),
        width: MediaQuery.of(context).size.width / 1.3,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: const Color(0xFFEEEFF1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: _messageController,
                  cursorColor: const Color(0xFF082D50),
                  decoration: const InputDecoration(
                    hintText: 'Message',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                            color: const Color(0xFF082D50),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Cancel',
                                style: TextStyle(color: Colors.white)))))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        String message = _messageController.text.trim();
                        // Do something with the title and message
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                            color: const Color(0xFF082D50),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text('Send',
                                style: TextStyle(color: Colors.white)))))),
          ],
        ),
      ],
    );
  }
}
