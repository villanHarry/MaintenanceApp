import '../Constants/AppImports.dart';

class InputField extends StatefulWidget {
  InputField(
      {Key? key,
      required this.text,
      required this.controller,
      this.obscure = false,
      this.inputType = TextInputType.text,
      this.suffix = const SizedBox(
        width: 0,
        height: 0,
      ),
      this.selectedColor = const Color(0xFF1C1B1F),
      this.hint = "",
      this.onTap = defaultFunction,
      this.enable = true,
      this.fontSize = 18,
      this.width = 0,
      this.maxLength = 0,
      this.shadow = const BoxShadow(color: Colors.transparent)})
      : super(key: key);

  final String text;

  final TextEditingController controller;
  final bool obscure;
  final Color selectedColor;
  final String hint;
  final VoidCallback onTap;
  static defaultFunction() {}
  final bool enable;
  final Widget suffix;
  final double fontSize;
  final BoxShadow shadow;
  final TextInputType inputType;
  final double width;
  final int maxLength;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late final width = MediaQuery.of(context).size.width;
  late final height = MediaQuery.of(context).size.height;
  bool ontap = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width == 0 ? width : widget.width,
      decoration: BoxDecoration(
          boxShadow:
              widget.shadow.color != Colors.transparent ? [widget.shadow] : []),
      child: TextFormField(
        maxLength: widget.maxLength == 0 ? null : widget.maxLength,
        enabled: widget.enable,
        onTap: widget.onTap,
        controller: widget.controller,
        cursorColor: Colors.black,
        keyboardType: widget.inputType,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        style: TextStyle(fontSize: widget.fontSize),
        obscureText: widget.obscure ? ontap : false,
        decoration: InputDecoration(
          suffixIcon: widget.obscure
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                      onTap: () => setState(() {
                            ontap = !ontap;
                          }),
                      child: Icon(
                        ontap ? Icons.panorama_fish_eye : Icons.circle,
                        color: const Color(0xFF1C1B1F),
                      )),
                )
              : widget.suffix,
          border: InputBorder.none,
          labelText: widget.text,
          fillColor: const Color.fromARGB(255, 250, 250, 250),
          filled: true,
          contentPadding: const EdgeInsets.all(20.0),
          counterText: "",
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 18),
          floatingLabelStyle:
              TextStyle(fontSize: 20, color: widget.selectedColor),
          labelStyle: const TextStyle(color: Color(0xFF1C1B1F)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: widget.selectedColor)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFF79747E)),
              borderRadius: BorderRadius.circular(width * .01)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: widget.selectedColor),
              borderRadius: BorderRadius.circular(width * .01)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFF79747E)),
              borderRadius: BorderRadius.circular(width * .01)),
          errorBorder: OutlineInputBorder(
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
