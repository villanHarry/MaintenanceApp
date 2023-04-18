import '../Constants/AppImports.dart';

class OtpField extends StatefulWidget {
  OtpField({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final width = MediaQuery.of(context).size.width;
  late final height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.14,
      height: width * 0.14,
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        style: const TextStyle(fontSize: 18),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "0",
          fillColor: const Color.fromARGB(255, 250, 250, 250),
          filled: true,
          contentPadding: const EdgeInsets.all(20.0),
          floatingLabelStyle:
              const TextStyle(fontSize: 20, color: Color(0xFF1C1B1F)),
          labelStyle: const TextStyle(color: Color(0xFF1C1B1F)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFF79747E)),
              borderRadius: BorderRadius.circular(width * .01)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Color(0xFF1C1B1F)),
              borderRadius: BorderRadius.circular(width * .01)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFF79747E)),
              borderRadius: BorderRadius.circular(width * .01)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Fields cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
