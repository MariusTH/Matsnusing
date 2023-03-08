import 'dart:html';

import 'package:flutter/material.dart';

class TutorialHome extends StatelessWidget {
  final Function callBack;
  const TutorialHome({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      // body is the majority of the screen.
      body: Center(
        child: Column(
          children: [
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Mandag');
              },
              child: Text('Mandag'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Tirsdag');
              },
              child: Text('Tirsdag'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Onsdag');
              },
              child: Text('Onsdag'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Torsdag');
              },
              child: Text('Torsdag'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Fredag');
              },
              child: Text('Fredag'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Lørdag');
              },
              child: Text('Lørdag'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { 
                this.callBack('Søndag');
              },
              child: Text('Søndag'),
            ),
          ],
        ),
      ),
    );
  }
}