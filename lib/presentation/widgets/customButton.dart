import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String nameButton;
   CustomButton({super.key, required this.nameButton,required this.onPressed});
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 31, vertical: 1),
      ),
      child: Text(
        nameButton,
        style: TextStyle(color: Colors.black87, fontFamily: 'pacifico'),
      ),
    );
  }
}
