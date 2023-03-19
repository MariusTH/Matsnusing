import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/dayNotifier.dart';

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

// class SelectButton extends TextButton {
//   SelectButton({
//     Key? key,
//     required VoidCallback onPressed,
//     String? text,
//     TextStyle? textStyle,
//     Color? backgroundColor,
//     double? borderRadius,
//   }) : super(
//           key: key,
//           onPressed: onPressed,
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 text!.toUpperCase(),
//                 textAlign: TextAlign.start,
//               )
//             ),
//           ),
//           style: BTN_STYLE,
//         );
// }

// help me create a selectbutton class that extends consumerwidget
// and then use it in the dayselector class below
class SelectButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? borderRadius;
  SelectButton({
    required this.onPressed,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderRadius,
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
          margin: const EdgeInsetsDirectional.fromSTEB(
            20.0,
            4.0,
            20.0,
            4.0
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      text!.toUpperCase(),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ref.watch(daysProvider.notifier).getDay(text!)?.middag!.toUpperCase() ?? "",
                      textAlign: TextAlign.start,
                    ),
                  ],
                )
              ),
            ),
            style: BTN_STYLE,
          ),
        );
  }
}