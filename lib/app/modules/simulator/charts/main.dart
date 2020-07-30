import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chart.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes() async {
    var pngBytes = await _capturePng();
    var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    print(bs64);

    Uint8List bytes = base64.decode(bs64);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = '$dir/abc.png';
    print("local file full path ${fullPath}");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    print(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RepaintBoundary(
                key: globalKey,
                child: Container(
                  color: Colors.red,
                  child: Chart(),
                  height: 700,
                  width: 1500,
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 6000,
        child: Center(
          child: Container(width: 5000, child: FlatButton(color: Color.fromARGB(255, 255, 255, 255), child: Text('Capture Png', textDirection: TextDirection.ltr), onPressed: _printPngBytes)),
        ),
      ),
    );
  }
}
