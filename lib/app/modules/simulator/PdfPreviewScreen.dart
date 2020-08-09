import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:login/app/shared/repositories/entities/power_plants.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String path;
  final PowerPlants pw;

  PdfPreviewScreen({this.path, this.pw});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Proposta gerada" + widget.pw.inversor),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: widget.path);
  }
}
