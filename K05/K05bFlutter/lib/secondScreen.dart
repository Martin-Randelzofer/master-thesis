import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: Center(
          child: CupertinoButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }
  }
}
