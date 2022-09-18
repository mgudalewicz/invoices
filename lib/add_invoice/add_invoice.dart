import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/add_invoice/cubit/add_invoice_cubit.dart';
import 'package:invoices/home_page.dart';
<<<<<<< HEAD
import 'package:invoices/widgets/app_button.dart';
import 'package:invoices/widgets/pdf_viewer.dart';
=======
import 'package:invoices/pdf_viewer.dart';
>>>>>>> 256f233 (add download and display pdf to 'add_invoice' page)
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

  PlatformFile? pickedPdf;

  int _vatValue = 0;
  double _grossAmount = 0;
  double _netAmount = 0;

  @override
  Widget build(BuildContext context) {
    _grossAmount = _netAmount * (100 + _vatValue) / 100;
    return BlocProvider(
        create: (context) => AddInvoiceCubit(),
        child: BlocBuilder<AddInvoiceCubit, AddInvoiceState>(builder: (context, state) {
<<<<<<< HEAD
          return SafeArea(
            child: Scaffold(
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
                                fontSize: 30.0,
                              )),
                          const SizedBox(height: 20),
                          if (pickedPdf == null)
                            AppButton(
                              onPressed: selectPdf,
                              text: 'Dodaj załącznik (.pdf)',
                            ),
                          if (pickedPdf != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                AppButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PdfViewer(
                                          pdfFromFile: File(pickedPdf!.path!),
                                        ),
                                      ),
                                    );
                                  },
                                  text: 'Otwórz załącznik',
                                ),
                                IconButton(
                                  iconSize: 25,
=======
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
                        if (pickedPdf == null)
                          ElevatedButton(
                            onPressed: selectPdf,
                            child: const Text('Dodaj fakturę (.pdf)'),
                          ),
                        if (pickedPdf != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PdfViewer(
                                        pdfFromFile: File(pickedPdf!.path!),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Otwórz fakturę'),
                              ),
                              SizedBox(
                                width: 20,
                                child: IconButton(
>>>>>>> 256f233 (add download and display pdf to 'add_invoice' page)
                                  onPressed: (() => setState(() {
                                        pickedPdf = null;
                                      })),
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
<<<<<<< HEAD
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
=======
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
>>>>>>> 256f233 (add download and display pdf to 'add_invoice' page)
                ),
              ),
            ),
          );
        }));
  }

  Future selectPdf() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;
    setState(() {
      pickedPdf = result.files.first;
    });
  }

  Column _floatingButton(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        FloatingActionButton(
          backgroundColor: Colors.cyan.shade800,
          onPressed: () {
            File? file;
            if (pickedPdf != null) {
              file = File(pickedPdf!.path!);
            }
            if (_formKey.currentState!.validate()) {
              context.read<AddInvoiceCubit>().create(
                    invoiceNumber: _invoiceNumberInputKey.currentState!.value!,
                    counterpartyName: _counterpartyNameInputKey.currentState!.value!,
                    netAmount: _netAmount,
                    vat: _vatValue / 100,
                    grossAmount: _grossAmount,
                    pickedPdf: file,
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
        border: Border.all(color: Colors.blueGrey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text('Vat: 0%'),
              Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => Colors.cyan.shade600,
                  ),
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
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => Colors.cyan.shade600,
                  ),
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
                  fillColor: MaterialStateColor.resolveWith(
                    (states) => Colors.cyan.shade600,
                  ),
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
