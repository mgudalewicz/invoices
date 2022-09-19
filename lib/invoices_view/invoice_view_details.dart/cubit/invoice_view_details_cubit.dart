import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoices/manager/invoices_data_manager.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/service_locator.dart';

part 'invoice_view_details_state.dart';

class InvoiceViewDetailsCubit extends Cubit<InvoiceViewDetailsState> {
  InvoiceViewDetailsCubit() : super(const InvoiceViewDetailsLoadingState());

  final InvoicesDataManager _invoicesDataManager = sl();

  StreamSubscription<dynamic>? _subscription;

  Future<void> init(String id) async {
    await _invoicesDataManager.fetch();

    _subscription = _invoicesDataManager.getAllInvoices().listen((
      List<Invoice> invoiceList,
    ) {
      Invoice? invoice = invoiceList.firstWhere((Invoice invoice) => invoice.id == id);
      emit(InvoiceViewDetailsInfoState(
        invoice: invoice,
      ));
    });
  }

  Future<bool> saveInvoicePdf({
    required String idInvoice,
    required File invoicePDF,
  }) async {
    final String? pdfUrl;
    try {
      pdfUrl = await _invoicesDataManager.uploadFile(invoicePDF: invoicePDF);
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak: $error',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
      return false;
    }
    try {
      _invoicesDataManager.addPdf(idInvoice: idInvoice, ulrLink: pdfUrl!);
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak: $error',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
      return false;
    }
    Fluttertoast.showToast(
      msg: 'Faktura została dodana',
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.cyan.shade800,
    );
    return true;
  }

  Future<bool> deletePDF({
    required String idInvoice,
    required String ulrLink,
  }) async {
    try {
      await _invoicesDataManager.deletePdf(
        idInvoice: idInvoice,
        ulrLink: ulrLink,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak: $error',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
      return false;
    }
    Fluttertoast.showToast(
      msg: 'Faktura została usunięta',
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.cyan.shade800,
    );
    return true;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
