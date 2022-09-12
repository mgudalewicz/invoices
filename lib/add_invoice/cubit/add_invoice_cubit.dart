import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoices/manager/invoices_data_manager.dart';
import 'package:invoices/models/invoice/invoice_write_request.dart';
import 'package:invoices/service_locator.dart';

part 'add_invoice_state.dart';

class AddInvoiceCubit extends Cubit<AddInvoiceState> {
  AddInvoiceCubit() : super(const AddInvoiceState());

  final InvoicesDataManager _invoicesDataManager = sl();

  Future<void> create({
    required String invoiceNumber,
    required String counterpartyName,
    required double netAmount,
    required double vat,
    required double grossAmount,
  }) async {
    final InvoiceWriteRequest invoiceWriteRequest = InvoiceWriteRequest(
      invoiceNumber: invoiceNumber,
      counterpartyName: counterpartyName,
      netAmount: netAmount,
      vat: vat,
      grossAmount: grossAmount,
    );
    try {
      await _invoicesDataManager.create(invoiceWriteRequest);
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Coś poszło nie tak: $error',
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: 'Faktura została zapisana',
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
    );
  }
}
