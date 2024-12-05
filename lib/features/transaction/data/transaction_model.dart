import '../../../../core/api/core_models/base_result_model.dart';

class Transaction {
  int? id;
  int? businessId;
  int? payment;
  int? remaining;
  String? createdAt;

  Transaction({
    this.id,
    this.businessId,
    this.payment,
    this.remaining,
    this.createdAt,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    payment = json['payment'];
    remaining = json['remaining'];
    createdAt = json['created_at'];
  }
}



class MyTransactionsResponseModel extends ListResultModel<Transaction> {
  int? totalCount;
  late List<Transaction> data;

  MyTransactionsResponseModel({this.totalCount, required this.data});

  MyTransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    list = <Transaction>[];

    json['data'].forEach((v) {
      list.add(Transaction.fromJson(v));
    });

    if (json['data'] != null) {
      data = list;
      totalCount = list.length;
    }
  }
}

class RemainingResponseModel extends BaseResultModel {
  num? remaining;

  RemainingResponseModel (
      this.remaining
      );

  RemainingResponseModel.fromJson(Map<String, dynamic> json) {
    remaining = json['remaining'];
  }
}
