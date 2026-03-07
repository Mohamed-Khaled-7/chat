import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void customShowDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        Center(child: SpinKitFadingCircle(color: Colors.white, size: 60.0)),
  );
}
