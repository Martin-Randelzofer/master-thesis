import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: Center(
          child: Text("We are on page 10!"),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text("We are on page 10!"),
        ),
      );
    }
  }
}
