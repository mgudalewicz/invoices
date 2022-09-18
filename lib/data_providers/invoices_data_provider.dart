import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/models/invoice/invoice_write_request.dart';
import 'package:invoices/schema/invoices_fields.dart';
import 'package:invoices/service_locator.dart';

class InvoicesDataProvider {
  final FirebaseFirestore _firebaseFirestore = sl();
  final FirebaseStorage _firebaseStorage = sl();

  Future<Map<String, Invoice>> fetchWithId(String invoiceId) async {
    final QuerySnapshot<Map<String, dynamic>> result =
        await _firebaseFirestore.collection('invoices').where(InvoicesFields.id, isEqualTo: invoiceId).get();

    final Map<String, Invoice> invoice = <String, Invoice>{};

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in result.docs) {
      invoice[doc.id] = Invoice.fromJson(doc.data()..['id'] = doc.id);
    }

    return invoice;
  }

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

  Future<void> deletePdf({
    required String idInvoice,
    required String ulrLink,
  }) {
    _firebaseFirestore.collection('invoices').doc(idInvoice).update({'invoice_pdf': null});
    return _firebaseStorage.refFromURL(ulrLink).delete();
  }

  Future<void> addPdf({
    required String idInvoice,
    required String ulrLink,
  }) {
    return _firebaseFirestore.collection('invoices').doc(idInvoice).update({'invoice_pdf': ulrLink});
  }

  Future<String> uploadFile({
    required File invoicePDF,
  }) async {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var random = Random();
    String pdfNamed =
        String.fromCharCodes(Iterable.generate(20, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
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
