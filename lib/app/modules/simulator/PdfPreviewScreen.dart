import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

import 'package:login/app/shared/repositories/entities/power_plants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String path;
  final PowerPlants pw;

  PdfPreviewScreen({this.path, this.pw});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  Future<void> share() async {
    Directory documentDirectory = await getExternalStorageDirectory();

    String documentPath = documentDirectory.path;
    final String localPath = '$documentPath/2700kWh-FRONIUS-Angelica.pdf';

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
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Proposta gerada"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                share();
              },
            ),
          ],
        ),
        path: widget.path);
  }
}
