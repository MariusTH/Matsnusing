import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'daySelector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT App',
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _foodController = TextEditingController();
  final _timeController = TextEditingController();
  String _response = '';
  var days = <String>[];
  dayCallBack(String day) {
    if(days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    print(days);
  }
  Future<void> _generateResponse() async {
    const url = 'http://localhost:3000/api/completion'; // Replace with your backend URL
    final body = json.encode({'days': days});
    final headers = Options(headers: {'Content-Type': 'application/json'});

    try {
      final response =  await Dio().post(url, data: body, options: headers);

      if (response.statusCode == 200) {
        print('data: ${response.data}');
        print('data string: ${response.toString()}');
        final responseData = json.decode(response.toString());
        print('Response: $responseData');
        setState(() {
          // Note TODO harden result.
          _response = responseData['result'];
        });
      } else {
        print('Error generating response: ${response.statusMessage}');
      }
    // Handle the response
    } on DioError catch (e) {
      if (e is DioError) {
        print('DioError: ${e.error}');
      } else {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: TutorialHome(callBack: dayCallBack,)),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  _response,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _generateResponse,
                ), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
