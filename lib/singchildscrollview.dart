import 'package:flutter/material.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SingleChildScrollView Demo',
      home: new Scaffold(
        appBar: AppBar(
          title: new Text('SingleChildScrollView Demo'),
        ),
        body: new SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: new Center(
            child: new Column(
              children: <Widget>[
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.pink,
                ),
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.pink,
                ),
                Container(
                  width: 300.0,
                  height: 200.0,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}