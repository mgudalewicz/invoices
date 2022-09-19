import 'package:flutter/material.dart';
import 'package:invoices/add_invoice/add_invoice.dart';
import 'package:invoices/invoices_view/invoice_view_home.dart/invoice_view_home_screen.dart';
import 'package:invoices/widgets/app_bar_widget.dart';
import 'package:invoices/widgets/app_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.pageIndex,
  });

  final int? pageIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.pageIndex != null) {
      currentIndex = widget.pageIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Invoice',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBarWidget(title: currentIndex == 0 ? 'Dodawanie faktury' : 'Twoje faktury'),
          body: Builder(builder: (context) {
            if (currentIndex == 0) {
              return const AddInvoicePage();
            }
            return const InvoiceViewHomeScreenScreen();
          }),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.cyan.shade800,
            currentIndex: currentIndex,
            unselectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(color: Colors.cyanAccent),
            fixedColor: Colors.cyanAccent,
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
