import 'dart:io';

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
        home: CupertinoPageScaffold(
          child: _buildContent(),
        ),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          body: _buildContent(),
        ),
      );
    }
  }

  Widget _buildContent() {
    return Center(
      child: Text("K01Flutter_"+Platform.operatingSystem),
    );
  }

  int foo() {
    return 1;
  }
}
