import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:login/app/shared/styles/main_colors.dart' as main;
import 'package:login/app/shared/styles/main_style.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String path;
  final PowerPlants pw;

  PdfPreviewScreen({this.path, this.pw});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  @override
  void initState() {
    super.initState();

    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: main.MainColors.cielo, //or set color with: Color(0xFF0000FF)
    ));
  }

  Future<void> share() async {
    Directory documentDirectory = await getExternalStorageDirectory();

    String documentPath = documentDirectory.path;
    final String localPath = '$documentPath/Soli-Energia-Solar(pré-proposta).pdf';

    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("$localPath");
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }

  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: main.MainColors.cielo, //or set color with: Color(0xFF0000FF)
    ));
    return PDFViewerScaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                size: 25,
                color: Colors.black,
              ),
              onPressed: () {
                share();
              },
            ),
          ],
        ),
        path: widget.path);
  }
}
