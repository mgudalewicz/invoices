import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/add_invoice/cubit/add_invoice_cubit.dart';
import 'package:invoices/widgets/app_text_form_field.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _invoiceNumberInputKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _counterpartyNameInputKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _netAmountNameInputKey = GlobalKey<FormFieldState<String>>();

  int _vatSelected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddInvoiceCubit(),
        child: BlocBuilder<AddInvoiceCubit, AddInvoiceState>(builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppTextFormField(
                      formFieldKey: _invoiceNumberInputKey,
                      labelText: 'Numer faktury',
                      hintText: 'Podaj numer faktury',
                    ),
                    AppTextFormField(
                      formFieldKey: _counterpartyNameInputKey,
                      labelText: 'Nazwa kontrahenta',
                      hintText: 'Podaj nazwę kontrahenta',
                    ),
                    AppTextFormField(
                      formFieldKey: _netAmountNameInputKey,
                      labelText: 'Kwota netto',
                      keyboardType: TextInputType.number,
                    ),
                    _choiceVatRate(),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget _choiceVatRate() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text('Vat: 0%'),
              Radio(
                  value: 0,
                  groupValue: _vatSelected,
                  onChanged: (newValue) {
                    setState(() {
                      _vatSelected = newValue!;
                    });
                  }),
            ],
          ),
          Column(
            children: [
              const Text('Vat: 7%'),
              Radio(
                  value: 7,
                  groupValue: _vatSelected,
                  onChanged: (newValue) {
                    setState(() {
                      _vatSelected = newValue!;
                    });
                  }),
            ],
          ),
          Column(
            children: [
              const Text('Vat: 23%'),
              Radio(
                  value: 23,
                  groupValue: _vatSelected,
                  onChanged: (newValue) {
                    setState(() {
                      _vatSelected = newValue!;
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
