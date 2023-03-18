import 'package:flutter/material.dart';

TextStyle TXT_STYLE = const TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: "Information",
  fontSize: 16.0,
  color: Color(0xFF333333),
);

ButtonStyle BTN_STYLE = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xfffdefd5)),
  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xff333333)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(
        color: Color(0xFF756C5D),
        width: 2.0,
      ),
    ),
  ),
  textStyle: MaterialStateProperty.all<TextStyle>(TXT_STYLE),
  minimumSize: MaterialStateProperty.all<Size>(const Size(350.0, 60.0)),
);

class SelectButton extends TextButton {
  SelectButton({
    Key? key,
    required VoidCallback onPressed,
    String? text,
    TextStyle? textStyle,
    Color? backgroundColor,
    double? borderRadius,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                text!.toUpperCase(),
                textAlign: TextAlign.start,
              )
            ),
          ),
          style: BTN_STYLE,
        );
}