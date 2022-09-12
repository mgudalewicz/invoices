import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void configureDepenedencies() {
  //Firebase
  sl.registerSingleton(FirebaseFirestore.instance);
}
