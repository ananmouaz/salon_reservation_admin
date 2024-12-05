import 'package:salon_reservation/features/transaction/data/transaction_model.dart';
import '../../../core/api/core_models/base_result_model.dart';
import '../../../core/api/data_source/remote_data_source.dart';
import '../../../core/api/http/api_urls.dart';
import '../../../core/api/http/http_method.dart';


class TransactionRepository {
  static Future<BaseResultModel?> getTransactions(dynamic requestData) async {
    final res = await RemoteDataSource.request<MyTransactionsResponseModel>(
        converter: (json) => MyTransactionsResponseModel.fromJson(json),
        method: HttpMethod.get,
        queryParameters: requestData.toJson(),
        withAuthentication: true,
        url: ApiURLs.transactions);
    return res;
  }

  static Future<BaseResultModel?> getRemaining() async {
    final res = await RemoteDataSource.request<RemainingResponseModel>(
        converter: (json) => RemainingResponseModel.fromJson(json),
        method: HttpMethod.get,
        withAuthentication: true,
        url: ApiURLs.remaining);
    return res;
  }
}