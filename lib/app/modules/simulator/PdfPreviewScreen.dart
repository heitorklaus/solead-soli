import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Proposta gerada"),
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
