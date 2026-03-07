import 'package:flutter/material.dart';

void showSnakBar(
    BuildContext context,
    String message,
    Color? backgroundColor,
    IconData icons,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),  
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: StadiumBorder(),
        duration: const Duration(seconds: 3),
      ),
    );
  }