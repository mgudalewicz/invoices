import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/home_page.dart';
import 'package:invoices/invoices_view/invoice_view_details.dart/cubit/invoice_view_details_cubit.dart';
import 'package:invoices/invoices_view/invoice_view_details.dart/invoice_view_details_screen.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/pdf_viewer.dart';

class InvoiceViewDetailsBody extends StatefulWidget {
  const InvoiceViewDetailsBody({
    super.key,
    required this.state,
  });

  final InvoiceViewDetailsInfoState state;

  @override
  State<InvoiceViewDetailsBody> createState() => _InvoiceViewDetailsBodyState();
}

class _InvoiceViewDetailsBodyState extends State<InvoiceViewDetailsBody> {
  PlatformFile? pickedPdf;
  bool isLink = false;

  @override
  Widget build(BuildContext context) {
    if (widget.state.invoice.invoicePDF != null && widget.state.invoice.invoicePDF != '') {
      isLink = true;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: GoToInvoiceViewHome,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.state.invoice.invoiceNumber),
      ),
      body: Column(
        children: [
          const Text('Kontrahent:'),
          Text(
            widget.state.invoice.counterpartyName,
            style: const TextStyle(fontSize: 22.0),
          ),
          const SizedBox(height: 16),
          const Text('Kwota netto:'),
          Text(
            '${widget.state.invoice.netAmount.toString()} zł',
            style: const TextStyle(fontSize: 22.0),
          ),
          const SizedBox(height: 16),
          Text('Vat ${(widget.state.invoice.vat * 100).round()} %'),
          Text(
            '${(widget.state.invoice.netAmount * widget.state.invoice.vat).toStringAsFixed(2)} zł',
            style: const TextStyle(fontSize: 22.0),
          ),
          const SizedBox(height: 16),
          const Text('Kwota brutto:'),
          Text(
            '${(widget.state.invoice.netAmount * widget.state.invoice.vat + widget.state.invoice.netAmount).toStringAsFixed(2)} zł',
            style: const TextStyle(fontSize: 22.0),
          ),
          if (isLink == false)
            ElevatedButton(
              onPressed: selectAndSavePdf,
              child: const Text('Dodaj fakturę (.pdf)'),
            ),
          if (isLink != false)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PdfViewer(
                          urlLink: widget.state.invoice.invoicePDF,
                        ),
                      ),
                    );
                  },
                  child: const Text('Otwórz fakturę'),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    onPressed: (() => deletePDF(invoice: widget.state.invoice)),
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future selectAndSavePdf() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;

    bool success = false;
    pickedPdf = result.files.first;
    if (pickedPdf != null) {
      success = await savePDF();
    }
    if (success == true) {
      refreshPage();
    }
  }

  Future<bool> savePDF() {
    return context.read<InvoiceViewDetailsCubit>().saveInvoicePdf(
          idInvoice: widget.state.invoice.id,
          invoicePDF: File(pickedPdf!.path!),
        );
  }

  Future<void> refreshPage() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InvoiceViewDetailsScreen(
          id: widget.state.invoice.id,
        ),
      ),
    );
  }

  Future<void> deletePDF({
    required Invoice invoice,
  }) {
    final InvoiceViewDetailsCubit cubit = context.read();
    cubit.deletePDF(idInvoice: invoice.id, ulrLink: invoice.invoicePDF!);

    return refreshPage();
  }

  Future<void> GoToInvoiceViewHome() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomePage(pageIndex: 1),
      ),
    );
  }
}
