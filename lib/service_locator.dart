import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:invoices/data_providers/invoices_data_provider.dart';

final sl = GetIt.instance;

void configureDepenedencies() {
  //Firebase
  sl.registerSingleton(FirebaseFirestore.instance);

  //Provider
  sl.registerFactory(() => InvoicesDataProvider());
}
