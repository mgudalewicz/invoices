import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoices/widgets/app_bar_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({
    super.key,
    this.pdfFromFile,
    this.urlLink,
  });

  final File? pdfFromFile;
  final String? urlLink;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: widget.pdfFromFile == null ? _pdfForLink() : _pdfForFile(),
          appBar: AppBarWidget(
            title: null,
            actions: _action(),
          )),
    );
  }

  List<Widget> _action() {
    return <Widget>[
      IconButton(
          onPressed: (() {
            _pdfViewerController.zoomLevel *= 1.25;
          }),
          icon: const Icon(Icons.zoom_in)),
      IconButton(
          onPressed: (() {
            _pdfViewerController.zoomLevel *= 0.75;
          }),
          icon: const Icon(Icons.zoom_out))
    ];
  }

  Widget _pdfForFile() {
    return SfPdfViewer.file(
      widget.pdfFromFile!,
      controller: _pdfViewerController,
    );
  }

  Widget _pdfForLink() {
    return SfPdfViewer.network(
      widget.urlLink!,
      controller: _pdfViewerController,
    );
  }
}
