import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
  String _resultText = '';
  bool _startDownloadAgain = false;
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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_resultText),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Start Download File 1'),
          onPressed: () async {
            setState(() {
              _resultText = "";
            });
            var url = 'http://192.168.178.61:8080/file1.data';

            Stopwatch sw = Stopwatch();
            sw.start();
            var response = await http.get(url);
            if (response.statusCode == 200) {
              setState(() {
                _resultText = "Downloaded " +
                    response.bodyBytes.length.toString() +
                    " bytes, took" +
                    sw.elapsedMilliseconds.toString() +
                    "ms";
              });
              sw.stop();
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Start Ping'),
          onPressed: () async {
            setState(() {
              _resultText = "";
            });
            var url = 'http://192.168.178.61:8080/ping.data';

            Stopwatch sw = Stopwatch();
            sw.start();
            var response = await http.get(url);
            if (response.statusCode == 200) {
              setState(() {
                _resultText = "PING | Downloaded " +
                    response.bodyBytes.length.toString() +
                    " bytes, took" +
                    sw.elapsedMicroseconds.toString() +
                    "Microseconds";
              });
              sw.stop();
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Start Multiple Download'),
          onPressed: () async {
            setState(() {
              _resultText = "";
            });
            var baseUrl = 'http://192.168.178.61:8080/';

            Stopwatch sw = Stopwatch();
            

            List<Future> futures = List<Future>();
            sw.start();
            for (int i = 10; i < 110; i++) {
              futures.add(http.get(baseUrl + "file" + i.toString() + ".data"));
            }
            await Future.wait(futures);
            sw.stop();
            setState(() {
              _resultText = "Downloaded 100 files, took" +
                  sw.elapsedMilliseconds.toString() +
                  "ms";
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Start Repeated Download File 1'),
          onPressed: () async {
            setState(() {
              _resultText = "";
            });
            var url = 'http://192.168.178.61:8080/file1.data';
            _startDownloadAgain = true;
            int counter = 0;
            while (_startDownloadAgain) {
              var response = await http.get(url);
              setState(() {
                counter++;
                _resultText =
                    "Downloaded file " + counter.toString() + " times";
              });
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Stop Repeated Download File 1'),
          onPressed: () async {
            _startDownloadAgain = false;
          },
        ),
      ],
    ));
  }
}
