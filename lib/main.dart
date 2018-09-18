import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      title: 'Screens',
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _nameFieldController = TextEditingController();

  Future _gotToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      MaterialPageRoute<Map>(builder: (BuildContext context) {
        return NextScreen(name: _nameFieldController.text);
      }),
    );

    if (results != null && results.containsKey("info")) {
      _nameFieldController.text = results['info'];
    } else {
      print('Nothing...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 200, 200),
        title: Text('First screen'),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        ListTile(
          title: TextField(
            controller: _nameFieldController,
            decoration: InputDecoration(
              labelText: 'Enter your name',
            ),
          ),
        ),
        ListTile(
          title: RaisedButton(
            child: Text('Send to next screen'),
            onPressed: () {_gotToNextScreen(context);},
          ),
        ),
      ]),
    );
  }
}

class NextScreen extends StatefulWidget {
  final String name;

  NextScreen({Key key, this.name }) : super(key: key);

  @override
  _NextScreen createState() => _NextScreen();
}

class _NextScreen extends State<NextScreen> {

  var _backTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 200, 150),
        title: Text('Second screen'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: <Widget>[
          ListTile(
            title: widget.name != '' ? Text('${widget.name}') : null,
          ),

          ListTile(
            title: TextField(
              controller: _backTextFieldController,
            ),
          ),

          ListTile(
            title: FlatButton(
              child: Text('Send data back'),
              onPressed: () {
                Navigator.pop(context,{
                  'info': _backTextFieldController.text,
                });
              },
            ),
          ),
        ],),
      ),
    );
  }
}
