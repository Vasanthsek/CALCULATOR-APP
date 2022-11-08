import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(
      {Key? key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      required this.buttonTapped})
      : super(key: key);
  final Color color;
  final Color textColor;
  final String buttonText;
  final   buttonTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  buttonText,
                  style: TextStyle(color: textColor,fontSize: 20),
                ),
              ),
            )),
      ),
    );
  }
}
