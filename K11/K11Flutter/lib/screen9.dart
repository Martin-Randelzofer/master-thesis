import 'dart:io';

import 'package:K11Flutter/screen10.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: Center(
          child: CupertinoButton(
            child: Text('Go to Page 10'),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => Screen10()),
              );
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('Go to Page 10'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Screen10()),
              );
            },
          ),
        ),
      );
    }
  }
}
