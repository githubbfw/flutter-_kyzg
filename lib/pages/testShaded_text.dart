import 'package:flutter/material.dart';
import '../widgets/shaded_text.dart';

void main() => runApp(MaterialApp(
      home: Homepage(),
    ));

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shaded text demo'),
      ),
      body: Center(
        child: ShadeText(
            text: 'shaded text',
            textColor: Color(0xffff0000),
            shadeColor: Color(0xff00ff00),
            shadeBuilder: (BuildContext context, String text, Color color) {
              return Container(
                child: Text(
                  text,
                  style: TextStyle(color: color),
                ),
              );
            }),
      ),
    );
  }
}
