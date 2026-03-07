import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {

  bool isSecure;
  Function(String) onChange;
  final String? Function(String?) validator;
  final String Hint;
  final String Lable;
  customTextField({
    required this.isSecure,
    super.key,
    required this.Hint,
    required this.Lable,
    required this.onChange,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: TextFormField(
          validator: validator,
          style: TextStyle(color: Colors.white),
          obscureText: isSecure,
          onChanged: onChange,
          //onTapOutside: (event) {
          //  FocusManager.instance.primaryFocus?.unfocus();
          //},
          cursorColor: Colors.white,
          decoration: InputDecoration(
            focusColor: Colors.white,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hint: Text(Hint, style: TextStyle(color: Colors.white)),
            label: Text(Lable, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
