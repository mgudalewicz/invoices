import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoices/manager/invoices_data_manager.dart';
import 'package:invoices/models/invoice/invoice.dart';
import 'package:invoices/service_locator.dart';

part 'invoice_view_home_state.dart';

class InvoiceViewHomeCubit extends Cubit<InvoiceViewHomeState> {
  InvoiceViewHomeCubit() : super(const InvoiceViewHomeLoadingState());

  final InvoicesDataManager _invoicesDataManager = sl();

  StreamSubscription<dynamic>? _subscription;

  Future<void> init() async {
    await _invoicesDataManager.fetch();

    _subscription = _invoicesDataManager.getAllInvoices().listen((List<Invoice> invoiceList) {
      if (invoiceList.isEmpty) {
        emit(const InvoiceViewHomeErrorState(error: 'Brak faktur'));
        return;
      }
      emit(InvoiceViewHomeInfoState(
        invoices: invoiceList,
      ));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
