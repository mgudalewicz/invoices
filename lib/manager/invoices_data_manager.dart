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

  Stream<List<Invoice>> getPlayers() {
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
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }
}
