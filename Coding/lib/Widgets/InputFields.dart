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
      this.selectedColor = const Color(0xFF0C58A0),
      this.hint = "",
      this.onTap = defaultFunction,
      this.enable = true,
      this.fontSize = 18,
      this.width = 0,
      this.maxLength = 0,
      this.borderRadius = 0,
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
  final double borderRadius;

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
                        color: ontap
                            ? const Color(0xFFABAAAC)
                            : const Color(0xFF0C58A0),
                      )),
                )
              : widget.suffix,
          border: InputBorder.none,
          labelText: widget.text,
          fillColor: const Color.fromARGB(255, 250, 250, 250),
          filled: true,
          contentPadding: const EdgeInsets.all(17.0),
          counterText: "",
          isDense: true,
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 15.sp),
          floatingLabelStyle:
              TextStyle(fontSize: 15.sp, color: widget.selectedColor),
          labelStyle:
              TextStyle(fontSize: 15.sp, color: const Color(0xFFABAAAC)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: widget.selectedColor),
              borderRadius: BorderRadius.circular(widget.borderRadius == 0
                  ? width * .01
                  : widget.borderRadius)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFFABAAAC)),
              borderRadius: BorderRadius.circular(widget.borderRadius == 0
                  ? width * .01
                  : widget.borderRadius)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: widget.selectedColor),
              borderRadius: BorderRadius.circular(widget.borderRadius == 0
                  ? width * .01
                  : widget.borderRadius)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFFABAAAC)),
              borderRadius: BorderRadius.circular(widget.borderRadius == 0
                  ? width * .01
                  : widget.borderRadius)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: Color(0xFFABAAAC)),
              borderRadius: BorderRadius.circular(widget.borderRadius == 0
                  ? width * .01
                  : widget.borderRadius)),
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
