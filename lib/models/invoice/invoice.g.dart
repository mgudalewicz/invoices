// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'] as String,
      invoiceNumber: json['invoice_number'] as String,
      counterpartyName: json['counterparty_name'] as String,
      netAmount: (json['net_amount'] as num).toDouble(),
      vat: (json['vat'] as num).toDouble(),
      grossAmount: (json['gross_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'invoice_number': instance.invoiceNumber,
      'counterparty_name': instance.counterpartyName,
      'net_amount': instance.netAmount,
      'vat': instance.vat,
      'gross_amount': instance.grossAmount,
    };
