import 'package:emotion/emotion.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emotion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MYHomePage(),
    );
  }
}

class MYHomePage extends StatefulWidget {
  MYHomePage({Key? key}) : super(key: key);

  @override
  _MYHomePageState createState() => _MYHomePageState();
}

class _MYHomePageState extends State<MYHomePage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Emotion.hideKeyboard();
          var emoji = await Emotion.select(context);
          if (emoji != null) {
            textController.text = textController.text + emoji;
            Emotion.showKeyboard();
          }
        },
        child: Icon(Icons.emoji_emotions),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
