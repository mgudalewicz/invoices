part of 'invoice_view_home_cubit.dart';

abstract class InvoiceViewHomeState extends Equatable {
  const InvoiceViewHomeState();

  @override
  List<dynamic> get props => <dynamic>[];
}

class InvoiceViewHomeLoadingState extends InvoiceViewHomeState {
  const InvoiceViewHomeLoadingState();
}

class InvoiceViewHomeInfoState extends InvoiceViewHomeState {
  const InvoiceViewHomeInfoState({
    required this.invoices,
  });
  final List<Invoice> invoices;

  @override
  List<dynamic> get props => <dynamic>[
        invoices,
      ];
}

class InvoiceViewHomeErrorState extends InvoiceViewHomeState {
  const InvoiceViewHomeErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
