import 'package:flutter/material.dart';
import 'package:invoices/add_invoice/add_invoice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Invoice',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: (Text(currentIndex == 0 ? 'Dodawanie faktury' : 'Twoje faktury')),
          ),
          body: Builder(builder: (context) {
            if (currentIndex == 0) {
              return const AddInvoicePage();
            }
            return const SizedBox();
          }),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: 'Dodawanie faktury',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.folder),
                label: 'Wsystkie faktury',
              ),
            ],
          ),
        ));
  }
}
