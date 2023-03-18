import 'package:flutter/material.dart';
import "components/button.dart";

class DaySelector extends StatelessWidget {
  final Function callBack;
  DaySelector({super.key, required this.callBack,});

  @override
  Widget build(BuildContext context) {
    List<String> days = [
      "Mandag",
      "Tirsdag",
      "Onsdag",
      "Torsdag",
      "Fredag",
      "Lørdag",
      "Søndag"
    ];
    List<Widget> buttons = [];
    for (var day in days) {
      buttons.add(
        Container(
          margin: const EdgeInsetsDirectional.fromSTEB(
            20.0,
            4.0,
            20.0,
            4.0
          ),
          child: SelectButton(
            onPressed: () { 
              this.callBack(day);
            },
            text: day,
          ),
        )
      );
    }
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      backgroundColor: Color(0xfffdefd5),
      // body is the majority of the screen.
      body: Center(
        child: Column(
          children: buttons,
        ),
      ),
    );
  }
}