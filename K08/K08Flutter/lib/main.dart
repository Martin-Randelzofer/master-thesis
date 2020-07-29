import 'dart:io';
import 'dart:isolate';
import 'package:collection/collection.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

void isolateTest(dynamic data) {
  SendPort rp = data['port'];
  String variant = data['variant'];
  rp.send(variant +
      " finished" +
      new DateTime.now().millisecondsSinceEpoch.toString());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String _resultText = "";
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        home: CupertinoPageScaffold(
          child: Center(child: _buildContent()),
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        RaisedButton(
          child: Text('Clear results'),
          onPressed: () {
            setState(() {
              _resultText = "";
            });
          },
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text('K08a'),
              onPressed: () {
                _k08a();
              },
            ),
            SizedBox(
              width: 20,
            ),
            RaisedButton(
              child: Text('K08b'),
              onPressed: () {
                _k08b();
              },
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('K08c1'),
                  onPressed: () {
                    _k08c(1, "K08c1");
                  },
                ),
                RaisedButton(
                  child: Text('K08c2'),
                  onPressed: () {
                    _k08c(5, "K08c2");
                  },
                ),
                RaisedButton(
                  child: Text('K08c3'),
                  onPressed: () {
                    _k08c(15, "K08c3");
                  },
                ),
              ],
            ),
          ],
        ),
        Text(_resultText),
      ],
    );
  }

  void _k08a() {
    for (int i = 0; i < 5; i++) {
      Stopwatch sw = Stopwatch();
      sw.start();
      fibonacci(40);
      sw.stop();
      setState(() {
        _resultText = _resultText +
            "K08a took " +
            sw.elapsedMilliseconds.toString() +
            "ms\n";
      });
    }
  }

  int fibonacci(int a) {
    if (a == 1 || a == 2) {
      return 1;
    } else {
      return fibonacci(a - 1) + fibonacci(a - 2);
    }
  }

  void _k08b() {
    int amountElements = 2000000;
    List<int> input = [];
    for (int i = 0; i < amountElements; i += 2) {
      input.add(i);
    }
    for (int i = 1; i < amountElements; i += 2) {
      input.add(i);
    }
    for (int i = 0; i < 5; i++) {
      Stopwatch sw = Stopwatch();
      sw.start();
      PriorityQueue<int> pq = PriorityQueue<int>();
      pq.addAll(input);
      pq.toList();
      sw.stop();
      setState(() {
        _resultText +=
            "K08b finished, took " + sw.elapsedMilliseconds.toString() + "ms\n";
      });
    }
  }

  void _k08c(int amountToCreate, String variant) {
    Stopwatch sw = Stopwatch();
    sw.start();
    ReceivePort receivePort = ReceivePort();
    setState(() {
      _resultText = variant+ " started "+new DateTime.now().millisecondsSinceEpoch.toString()+"\n";
    });
    for (int i = 0; i < amountToCreate; i++) {
      Isolate.spawn(
          isolateTest, {'port': receivePort.sendPort, 'variant': variant});
    }
    receivePort.listen((message) {
      setState(() {
        _resultText += message + "\n";
      });
    });
    sw.stop();
  }
}
