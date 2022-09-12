import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/models/invoice/invoice_write_request.dart';
import 'package:invoices/service_locator.dart';

class InvoicesDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();

  Future<Map<String, Invoice>> fetchAll() async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firebaseFirestore.collection('invoices').get();

    final Map<String, Invoice> invoices = <String, Invoice>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final Invoice invoice = Invoice.fromJson(doc.data()..['id'] = doc.id);
      invoices[doc.id] = invoice;
    }

    return invoices;
  }

  Stream<List<Invoice>> getItemsStream() {
    return _firebaseFirestore.collection('invoices').snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return Invoice.fromJson(doc.data()..['id'] = doc.id);
          },
        ).toList();
      },
    );
  }

  Future<void> create({
    required InvoiceWriteRequest invoiceWriteRequest,
  }) {
    return _firebaseFirestore.collection('invoices').add(invoiceWriteRequest.toJson());
  }
}
