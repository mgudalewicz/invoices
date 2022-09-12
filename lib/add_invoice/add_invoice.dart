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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AppTextFormField(
                        formFieldKey: _invoiceNumberInputKey,
                        labelText: 'Numer faktury',
                        hintText: 'Podaj numer faktury',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

