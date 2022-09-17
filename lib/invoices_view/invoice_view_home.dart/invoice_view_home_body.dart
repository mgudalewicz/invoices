import 'package:flutter/material.dart';
import 'package:invoices/invoices_view/invoice_view_home.dart/cubit/invoice_view_home_cubit.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/widgets/app_text_form_field.dart';

class InvoiceViewHomeBody extends StatefulWidget {
  const InvoiceViewHomeBody({
    super.key,
    required this.state,
  });

  final InvoiceViewHomeInfoState state;

  @override
  State<InvoiceViewHomeBody> createState() => _InvoiceViewHomeBodyState();
}

class _InvoiceViewHomeBodyState extends State<InvoiceViewHomeBody> {
  late List<Invoice> invoiceOverviewList = widget.state.invoices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppTextFormField(
            labelText: 'Wyszukaj faktury',
            hintText: 'Wyszukaj po numerze lub kontrahencie',
            onChanged: _searcInvoice,
          ),
          const Divider(color: Colors.blue),
          _invoicesList(context, invoiceOverviewList),
        ],
      ),
    );
  }

  Widget _invoicesList(BuildContext context, List<Invoice> invoices) {
    return Expanded(
      child: ListView(
        children: [
          for (final invoice in invoices) ...[
            GestureDetector(
              onTap: (() => _dialogBuilder(context, invoice)),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 205, 223, 232),
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          const Text('Numer faktury:'),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Text(
                              invoice.invoiceNumber,
                              style: const TextStyle(fontSize: 20.0),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Kontrahent:'),
                          const SizedBox(width: 36),
                          Flexible(
                            child: Text(
                              invoice.counterpartyName,
                              style: const TextStyle(fontSize: 20.0),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )
                    ]),
                  )),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, Invoice invoice) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 120),
          title: Text(invoice.invoiceNumber),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Kontrahent:'),
              Text(
                invoice.counterpartyName,
                style: const TextStyle(fontSize: 22.0),
              ),
              const SizedBox(height: 16),
              const Text('Kwota netto:'),
              Text(
                '${invoice.netAmount.toString()} zł',
                style: const TextStyle(fontSize: 22.0),
              ),
              const SizedBox(height: 16),
              Text('Vat ${(invoice.vat * 100).round()} %'),
              Text(
                '${(invoice.netAmount * invoice.vat).toStringAsFixed(2)} zł',
                style: const TextStyle(fontSize: 22.0),
              ),
              const SizedBox(height: 16),
              const Text('Kwota brutto:'),
              Text(
                '${(invoice.netAmount * invoice.vat + invoice.netAmount).toStringAsFixed(2)} zł',
                style: const TextStyle(fontSize: 22.0),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Zamknij'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _searcInvoice(String query) {
    final List<Invoice> suggestions = widget.state.invoices.where((Invoice invoice) {
      final String invoiceNumber = invoice.invoiceNumber.toLowerCase();
      final String counterpartyName = invoice.counterpartyName.toLowerCase();
      final String input = query.toLowerCase();
      if (invoiceNumber.contains(input)) {
        return invoiceNumber.contains(input);
      }
      return counterpartyName.contains(input);
    }).toList();
    setState(() => invoiceOverviewList = suggestions);
  }
}
