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
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  @JsonKey(name: InvoicesFields.id)
  final String id;

  @JsonKey(name: InvoicesFields.invoiceNumber)
  final String invoiceNumber;

  @JsonKey(name: InvoicesFields.counterpartyName)
  final int counterpartyName;

  @JsonKey(name: InvoicesFields.netAmount)
  final int netAmount;

  @JsonKey(name: InvoicesFields.vat)
  final int vat;

  @JsonKey(name: InvoicesFields.grossAmount)
  final int grossAmount;

  @override
  List<Object?> get props => <dynamic>[
        id,
        invoiceNumber,
        counterpartyName,
        netAmount,
        vat,
        grossAmount,
      ];
}