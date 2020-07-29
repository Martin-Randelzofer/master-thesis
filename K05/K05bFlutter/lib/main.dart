import 'dart:io';

import 'package:K05bFlutter/secondScreen.dart';
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
        //showPerformanceOverlay: true,
        home: Builder(
          builder: (context) => CupertinoPageScaffold(
            child: Center(child: _buildContent(context)),
          ),
        ),
      );
    } else {
      return MaterialApp(
          //showPerformanceOverlay: true,
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
        child: Text('Click'),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => SecondScreen()),
          );
        },
      );
    } else {
      return RaisedButton(
        child: Text('Click'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SecondScreen()),
          );
        },
      );
    }
  }
}
