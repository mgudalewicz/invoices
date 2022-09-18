import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoices/data_providers/invoices_data_provider.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/models/invoice/invoice_write_request.dart';
import 'package:invoices/service_locator.dart';

class InvoicesDataManager {
  final InvoicesDataProvider _invoicesDataProvider = sl();

  Future<void> fetch() async {
    _invoicesDataProvider.fetchAllInvoices();
  }

  Stream<List<Invoice>> getAllInvoices() {
    return _invoicesDataProvider.getInvoicesStream();
  }

  Future<void> create(
    InvoiceWriteRequest invoiceWriteRequest,
  ) async {
    try {
      await _invoicesDataProvider.create(
        invoiceWriteRequest: invoiceWriteRequest,
      );
      await fetch();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

<<<<<<< HEAD
  Future<void> deletePdf({
    required String idInvoice,
    required String ulrLink,
  }
  ) async {
    try {
      await _invoicesDataProvider.deletePdf(
        idInvoice: idInvoice,
        ulrLink: ulrLink,
      );
      await fetch();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

    Future<void> addPdf({
    required String idInvoice,
    required String ulrLink,
  }
  ) async {
    try {
      await _invoicesDataProvider.addPdf(
        idInvoice: idInvoice,
        ulrLink: ulrLink,
      );
      await fetch();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

=======
>>>>>>> 256f233 (add download and display pdf to 'add_invoice' page)
  Future<String?> uploadFile({
    required File invoicePDF,
  }) async {
    String? link;
    try {
      link = await _invoicesDataProvider.uploadFile(
        invoicePDF: invoicePDF,
      );
      await fetch();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }
    return link;
  }
}
