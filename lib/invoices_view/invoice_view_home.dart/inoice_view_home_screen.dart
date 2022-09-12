import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/invoices_view/invoice_view_home.dart/cubit/invoice_view_home_cubit.dart';
import 'package:invoices/models/invoice/invoice.dart';

class InvoiceViewHomePageContent extends StatelessWidget {
  const InvoiceViewHomePageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceViewHomeCubit()..init(),
      child: BlocBuilder<InvoiceViewHomeCubit, InvoiceViewHomeState>(
        builder: (context, state) {
          if (state is InvoiceViewHomeErrorState) {
            return Center(child: Text('Coś poszło nie tak: ${state.error}'));
          }

          if (state is InvoiceViewHomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InvoiceViewHomeInfoState) {
            return Column(
              children: [
                const Divider(color: Colors.blue),
                _invoicesList(state.invoices),
              ],
            );
          }
          return const Center(child: Text('Coś poszło nie tak'));
        },
      ),
    );
  }
}

Widget _invoicesList(List<Invoice> invoices) {
  return Expanded(
    child: ListView(
      children: [
        for (final invoice in invoices) ...[
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
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
                      const SizedBox(width: 40),
                      Text(
                        invoice.counterpartyName,
                        style: const TextStyle(fontSize: 20.0),
                        maxLines: 1,
                      ),
                    ],
                  )
                ]),
              )),
        ],
      ],
    ),
  );
}
