part of 'invoice_view_details_cubit.dart';

abstract class InvoiceViewDetailsState extends Equatable {
  const InvoiceViewDetailsState();

  @override
  List<dynamic> get props => <dynamic>[];
}

class InvoiceViewDetailsLoadingState extends InvoiceViewDetailsState {
  const InvoiceViewDetailsLoadingState();
}

class InvoiceViewDetailsInfoState extends InvoiceViewDetailsState {
  const InvoiceViewDetailsInfoState({
    required this.invoice,
  });
  final Invoice invoice;

  @override
  List<dynamic> get props => <dynamic>[
        invoice,
      ];
}

class InvoiceViewDetailsErrorState extends InvoiceViewDetailsState {
  const InvoiceViewDetailsErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
