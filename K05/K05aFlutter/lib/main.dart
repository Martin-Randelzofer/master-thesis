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
        showPerformanceOverlay: true,
        home: CupertinoPageScaffold(
          child: _buildContent(),
        ),
      );
    } else {
      return MaterialApp(
        showPerformanceOverlay: true,
        home: Scaffold(
          body: _buildContent(),
        ),
      );
    }
  }

  final items = List<int>.generate(1000, (i) => i + 1);

  Widget _buildContent() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Text(items[index].toString());
      },
    );
  }
}
