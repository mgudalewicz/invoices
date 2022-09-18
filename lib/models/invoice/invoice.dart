import 'package:equatable/equatable.dart';
import 'package:invoices/schema/invoices_fields.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice extends Equatable {
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.counterpartyName,
    required this.netAmount,
    required this.vat,
    required this.grossAmount,
    this.invoicePDF,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  @JsonKey(name: InvoicesFields.id)
  final String id;

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
        id,
        invoiceNumber,
        counterpartyName,
        netAmount,
        vat,
        grossAmount,
        invoicePDF,
      ];
}
