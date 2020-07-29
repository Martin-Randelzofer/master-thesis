import 'dart:io';
import 'package:K11Flutter/screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        home: Builder(
          builder: (context) => CupertinoPageScaffold(            
            child: Center(child: _buildContent(context)),
          ),
        ),
      );
    } else {
      return MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(child: _buildContent(context)),
            ),
          ));
    }
  }

  Widget _buildContent(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        child: Text('Go to Page 2'),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => Screen2()),
          );
        },
      );
    } else {
      return RaisedButton(
        child: Text('Go to Page 2'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => Screen2()),
          );
        },
      );
    }
  }
}
