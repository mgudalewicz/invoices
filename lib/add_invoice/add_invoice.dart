import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/add_invoice/cubit/add_invoice_cubit.dart';
import 'package:invoices/home_page.dart';
import 'package:invoices/widgets/app_text_form_field.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _invoiceNumberInputKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _counterpartyNameInputKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _netAmountNameInputKey = GlobalKey<FormFieldState<String>>();

  int _vatValue = 0;
  double _grossAmount = 0;
  double _netAmount = 0;

  @override
  Widget build(BuildContext context) {
    _grossAmount = _netAmount * (100 + _vatValue) / 100;
    return BlocProvider(
        create: (context) => AddInvoiceCubit(),
        child: BlocBuilder<AddInvoiceCubit, AddInvoiceState>(builder: (context, state) {
          return Scaffold(
            floatingActionButton: _floatingButton(context),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 40),
                        const Text('Faktura',
                            style: TextStyle(
                              fontSize: 40.0,
                            )),
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
                        _netAmountTextFormField(),
                        _choiceVatRate(),
                        const SizedBox(height: 10),
                        Text('Kwota brutto: ${_grossAmount.toStringAsFixed(2)} zł',
                            style: const TextStyle(
                              fontSize: 20.0,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Column _floatingButton(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AddInvoiceCubit>().create(
                    invoiceNumber: _invoiceNumberInputKey.currentState!.value!,
                    counterpartyName: _counterpartyNameInputKey.currentState!.value!,
                    netAmount: _netAmount,
                    vat: _vatValue / 100,
                    grossAmount: _grossAmount,
                  );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                  fullscreenDialog: true,
                ),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _netAmountTextFormField() {
    return AppTextFormField(
      validatorNumber: true,
      formFieldKey: _netAmountNameInputKey,
      labelText: 'Kwota netto (zł)',
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
      onChanged: (String value) {
        setState(() {
          if (value != '') {
            _netAmount = double.tryParse(value)!;
          }
          if (value == '') {
            _netAmount = 0;
          }
        });
      },
    );
  }

  Widget _choiceVatRate() {
    return Container(
      margin: const EdgeInsets.all(10.0),
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
                  groupValue: _vatValue,
                  onChanged: (newValue) {
                    setState(() {
                      _vatValue = newValue!;
                    });
                  }),
            ],
          ),
          Column(
            children: [
              const Text('Vat: 7%'),
              Radio(
                  value: 7,
                  groupValue: _vatValue,
                  onChanged: (newValue) {
                    setState(() {
                      _vatValue = newValue!;
                    });
                  }),
            ],
          ),
          Column(
            children: [
              const Text('Vat: 23%'),
              Radio(
                  value: 23,
                  groupValue: _vatValue,
                  onChanged: (newValue) {
                    setState(() {
                      _vatValue = newValue!;
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
