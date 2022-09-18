import 'package:equatable/equatable.dart';
import 'package:invoices/schema/invoices_fields.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_write_request.g.dart';

@JsonSerializable()
class InvoiceWriteRequest extends Equatable {
  const InvoiceWriteRequest({
    required this.invoiceNumber,
    required this.counterpartyName,
    required this.netAmount,
    required this.vat,
    required this.grossAmount,
    this.invoicePDF,
  });

  factory InvoiceWriteRequest.fromJson(Map<String, dynamic> json) => _$InvoiceWriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceWriteRequestToJson(this);

  @JsonKey(name: InvoicesFields.invoiceNumber)
  final String invoiceNumber;

  @JsonKey(name: InvoicesFields.counterpartyName)
  final String counterpartyName;

  @JsonKey(name: InvoicesFields.netAmount)
  final double netAmount;

  @JsonKey(name: InvoicesFields.vat)
  final double vat;

  @JsonKey(name: InvoicesFields.grossAmount)
  final double grossAmount;

  @JsonKey(name: InvoicesFields.invoicePDF)
  final String? invoicePDF;

  @override
  List<Object?> get props => <dynamic>[
        invoiceNumber,
        counterpartyName,
        netAmount,
        vat,
        grossAmount,
        invoicePDF,
      ];
}
