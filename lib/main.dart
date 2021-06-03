import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello World!!!!!!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hello World!!!!!!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = 'Hello';

  void _requestHelloWorld() async {
    final response = await http.get(
      Uri.http('3.23.239.230', 'catalog/api/1'),
    );

    if (response.statusCode != 200) {
      setState(() {
        int stsCd = response.statusCode;
        message = "Failed to get $stsCd";
      });
    } else {
      Map<String, dynamic> json = jsonDecode(response.body);
      print('タイトル:${json['message']}');

      setState(() {
        message = 'Hello ' + json['message'];
      });
    }
  }

  void _resetMessage() {
    setState(() {
      message = 'Hello';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(
              width: 0,
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(120, 70),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    _requestHelloWorld();
                  },
                  child: Text('API叩く'),
                ),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(120, 70),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    _resetMessage();
                  },
                  child: Text('リセット'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
