// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_write_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceWriteRequest _$InvoiceWriteRequestFromJson(Map<String, dynamic> json) =>
    InvoiceWriteRequest(
      invoiceNumber: json['invoice_number'] as String,
      counterpartyName: json['counterparty_name'] as int,
      netAmount: json['net_amount'] as int,
      vat: json['vat'] as int,
      grossAmount: json['gross_amount'] as int,
    );

Map<String, dynamic> _$InvoiceWriteRequestToJson(
        InvoiceWriteRequest instance) =>
    <String, dynamic>{
      'invoice_number': instance.invoiceNumber,
      'counterparty_name': instance.counterpartyName,
      'net_amount': instance.netAmount,
      'vat': instance.vat,
      'gross_amount': instance.grossAmount,
    };
