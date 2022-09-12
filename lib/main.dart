import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invoices/home_page.dart';
import 'package:invoices/firebase_options.dart';
import 'package:invoices/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDepenedencies();
  runApp(const HomePage());
}
