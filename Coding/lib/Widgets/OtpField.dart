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
        maxLength: 1,
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
          counterText: "",
          border: InputBorder.none,
          hintText: "0",
          fillColor: const Color.fromARGB(255, 250, 250, 250),
          filled: true,
          contentPadding: const EdgeInsets.all(17.0),
          isDense: true,
          floatingLabelStyle:
              const TextStyle(fontSize: 20, color: Color(0xFF0C58A0)),
          hintStyle: const TextStyle(color: Color(0xFFABAAAC)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFFABAAAC)),
              borderRadius: BorderRadius.circular(width * .03)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Color(0xFF0C58A0)),
              borderRadius: BorderRadius.circular(width * .03)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFFABAAAC)),
              borderRadius: BorderRadius.circular(width * .03)),
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
