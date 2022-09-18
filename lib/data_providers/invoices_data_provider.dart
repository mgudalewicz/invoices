import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/models/invoice/invoice_write_request.dart';
import 'package:invoices/service_locator.dart';

class InvoicesDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();
  final FirebaseStorage _firebaseStorage = sl();

  Future<Map<String, Invoice>> fetchAllInvoices() async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firebaseFirestore.collection('invoices').get();

    final Map<String, Invoice> invoices = <String, Invoice>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      final Invoice invoice = Invoice.fromJson(doc.data()..['id'] = doc.id);
      invoices[doc.id] = invoice;
    }

    return invoices;
  }

  Stream<List<Invoice>> getInvoicesStream() {
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

  Future<String> uploadFile({
    required File invoicePDF,
  }) async {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var random = Random();
    String pdfNamed = String.fromCharCodes(List.generate(20, (index) => random.nextInt(chars.length)));
    UploadTask? uploadTask;
    final path = 'files/$pdfNamed.pdf';
    final file = File(invoicePDF.path);

    final ref = _firebaseStorage.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}
