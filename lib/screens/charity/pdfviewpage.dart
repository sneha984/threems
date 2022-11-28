import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:threems/model/charitymodel.dart';

class PdfViewPage extends StatefulWidget {
  final  CharityModel charity;
  const PdfViewPage({Key? key, required this.charity}) : super(key: key);

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network(widget.charity.documents!),
    );
  }
}
class PdfPage extends StatefulWidget {
  final  CharityModel charitys;

  const PdfPage({Key? key, required this.charitys}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network(widget.charitys.otherDocument!),
    );
  }
}
