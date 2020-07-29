import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String testResult = "";

  void setTestResult(String text) {
    setState(() {
      testResult = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        home: CupertinoPageScaffold(
          child: Center(child: _buildContent(testResult, setTestResult)),
        ),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: _buildContent(testResult, setTestResult)),
        ),
      );
    }
  }

  Widget _buildContent(String testResult, Function setTestResult) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("Test Result: " + testResult),
        SizedBox(
          height: 50,
        ),
        //K07a file 1
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Init K07a & b'),
              onPressed: () async {
                var bytes = await rootBundle.load("assets/file2");
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;
                new File(appDocPath + "/file2").writeAsBytes(bytes.buffer
                    .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                setTestResult(
                    "Init K07a & b finished, read file2 from asset to appPath/file2");
              },
            ),
            RaisedButton(
              child: Text('Start K07a'),
              onPressed: () async {
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;
                File file = File(appDocPath + "/file2");
                Stopwatch sw = Stopwatch();
                sw.start();
                Uint8List bytes = await file.readAsBytes();
                sw.stop();
                setTestResult(
                    "K07a: " + sw.elapsedMilliseconds.toString() + "ms");
              },
            ),
          ],
        ),
        //K07b
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Start K07b'),
              onPressed: () async {
                //Retrieve bytes for write
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;
                File fileInput = File(appDocPath + "/file2");
                Uint8List bytes = await fileInput.readAsBytes();

                setTestResult("Read file," +
                    bytes.length.toString() +
                    "bytes,  wait 2 seconds");
                await Future.delayed(Duration(seconds: 2));

                Stopwatch sw = Stopwatch();
                sw.start();
                File fileOutput = await File(appDocPath + "/fileSingleWrite")
                    .writeAsBytes(bytes);
                sw.stop();
                setTestResult(
                    "K07b: " + sw.elapsedMilliseconds.toString() + "ms");
              },
            ),
          ],
        ),
        //K07c
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Init K07c'),
              onPressed: () async {
                var bytes = await rootBundle.load("assets/file3");
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;
                for (int i = 0; i < 100; i++) {
                  bytes.setUint8(i, i);
                  bytes.setUint8(i + 1, i + 1);
                  bytes.setUint8(i + 2, i + 2);
                  bytes.setUint8(i + 3, i + 3);
                  new File(appDocPath + "/file3_" + i.toString()).writeAsBytes(
                      bytes.buffer.asUint8List(
                          bytes.offsetInBytes, bytes.lengthInBytes));
                }
                setTestResult(
                    "Init K07c finished, read file3 from asset and saved to appPath/file3");
              },
            ),
            RaisedButton(
              child: Text('Start K07c'),
              onPressed: () async {
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;
                Stopwatch sw = Stopwatch();
                sw.start();

                for (int i = 0; i < 100; i++) {
                  File(appDocPath + "/file3_" + i.toString()).readAsBytesSync();
                }

                sw.stop();
                setTestResult("K07c finished, took " +
                    sw.elapsedMilliseconds.toString() +
                    " ms");
              },
            ),
          ],
        ),
      ],
    );
  }
}
