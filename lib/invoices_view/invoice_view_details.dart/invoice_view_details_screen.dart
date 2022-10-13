import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/invoices_view/invoice_view_details.dart/cubit/invoice_view_details_cubit.dart';
import 'package:invoices/invoices_view/invoice_view_details.dart/invoice_view_details_body.dart';

class InvoiceViewDetailsScreen extends StatelessWidget {
  const InvoiceViewDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => InvoiceViewDetailsCubit()..init(id),
        child: BlocBuilder<InvoiceViewDetailsCubit, InvoiceViewDetailsState>(builder: (context, state) {
          if (state is InvoiceViewDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InvoiceViewDetailsInfoState) {
            return InvoiceViewDetailsBody(
              state: state,
            );
          }
          return const Center(child: Text('Coś poszło nie tak'));
        }));
  }
}
