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
      title: 'Flutter Demo',
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
          var emoji = await Emotion.keyboard(context);
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
