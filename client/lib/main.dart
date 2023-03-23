import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'daySelector.dart';
import 'models/day.dart';
import 'notifiers/dayNotifier.dart';


// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
final helloWorldProvider = Provider((_) => 'Hello world');

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  Map<int, Color> beigeColorSwatch =
  {
    50:Color.fromRGBO(253, 239, 213, .1),
    100:Color.fromRGBO(253, 239, 213, .2),
    200:Color.fromRGBO(253, 239, 213, .3),
    300:Color.fromRGBO(253, 239, 213, .4),
    400:Color.fromRGBO(253, 239, 213, .5),
    500:Color.fromRGBO(253, 239, 213, .6),
    600:Color.fromRGBO(253, 239, 213, .7),
    700:Color.fromRGBO(253, 239, 213, .8),
    800:Color.fromRGBO(253, 239, 213, .9),
    900:Color.fromRGBO(253, 239, 213, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT App',
      home: ChatPage(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(0xFFFDEFD5, beigeColorSwatch),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class ChatPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
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
    const apiBase = String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');
    var url = '$apiBase/api/completion'; // Replace with your backend URL
    final body = json.encode({'days': days});
    final headers = Options(headers: {'Content-Type': 'application/json'});
    print(url);
    try {
      final response =  await Dio().post(url, data: body, options: headers);

      if (response.statusCode == 200) {
        print(response.toString());
        Map<String, dynamic> data = json.decode(response.toString());
        // Access 
        print(data);
        print(data.keys);
        List<dynamic> days = data['days'];
        List<Day> ds = [];
        for (var day in days) {
          ds.add(Day.fromJson(day));
        }
        print(ds);
        ref.read(daysProvider.notifier).updateDays(ds);
        setState(() {
          // Note TODO harden result.
          //_response = responseData['result'];
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
    
    final helloWorld = ref.read(helloWorldProvider);

    return Scaffold(
      backgroundColor: Color(0xfffdefd5),
      appBar: AppBar(
        title: Text('Matsnusing'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: DaySelector(callBack: dayCallBack,)),
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
