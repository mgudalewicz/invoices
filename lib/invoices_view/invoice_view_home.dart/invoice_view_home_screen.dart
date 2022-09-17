import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoices/invoices_view/invoice_view_home.dart/cubit/invoice_view_home_cubit.dart';
import 'package:invoices/invoices_view/invoice_view_home.dart/invoice_view_home_body.dart';

class InvoiceViewHomeScreenScreen extends StatelessWidget {
  const InvoiceViewHomeScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => InvoiceViewHomeCubit()..init(),
        child: BlocBuilder<InvoiceViewHomeCubit, InvoiceViewHomeState>(builder: (context, state) {
          if (state is InvoiceViewHomeErrorState) {
            return Center(child: Text('Coś poszło nie tak: ${state.error}'));
          }

          if (state is InvoiceViewHomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InvoiceViewHomeInfoState) {
            return InvoiceViewHomeBody(
              state: state,
            );
          }
          return const Center(child: Text('Coś poszło nie tak'));
        }));
  }
}
