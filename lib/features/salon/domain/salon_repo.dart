import 'package:salon_reservation/core/api/core_models/message_response_model.dart';

import '../../../core/api/core_models/base_result_model.dart';
import '../../../core/api/data_source/remote_data_source.dart';
import '../../../core/api/http/api_urls.dart';
import '../../../core/api/http/http_method.dart';
import '../data/model/add_service_request_model.dart';
import '../data/model/salon_model.dart';
import '../data/model/update_business_request_model.dart';

class SalonRepository {
  static Future<BaseResultModel?> getServices(dynamic requestData) async {
    final res = await RemoteDataSource.request<ServicesResponseModel>(
        converter: (json) => ServicesResponseModel.fromJson(json),
        method: HttpMethod.get,
        queryParameters: requestData.toJson(),
        withAuthentication: true,
        url: ApiURLs.businessService);
    return res;
  }

  /// Login using username
  static Future<BaseResultModel?> updateSalon(
      UpdateBusinessRequestModel updateBusinessRequestModel) async {
    try {
      final res = await RemoteDataSource.request<MessageResponseModel>(
          converter: (json) => MessageResponseModel.fromJson(json),
          method: HttpMethod.post,
          data: updateBusinessRequestModel.toJson(),
          withAuthentication: true,
          url: ApiURLs.updateBusiness);
      return res;
    } catch(e) {
      print(e);
    }
  }

  /// Login using username
  static Future<BaseResultModel?> addService(
      AddServiceRequestModel addServiceRequestModel) async {
    try {
      final res = await RemoteDataSource.request<MessageResponseModel>(
          converter: (json) => MessageResponseModel.fromJson(json),
          method: HttpMethod.post,
          data: addServiceRequestModel.toJson(),
          withAuthentication: true,
          url: ApiURLs.service);
      return res;
    } catch(e) {
      print(e);
    }
  }

  /// Login using username
  static Future<BaseResultModel?> editService(
      AddServiceRequestModel addServiceRequestModel, int id) async {
    try {
      final res = await RemoteDataSource.request<MessageResponseModel>(
          converter: (json) => MessageResponseModel.fromJson(json),
          method: HttpMethod.post,
          data: addServiceRequestModel.toJson(),
          withAuthentication: true,
          url: '${ApiURLs.updateService}/$id');
      return res;
    } catch(e) {
      print(e);
    }
  }

  /// Login using username
  static Future<BaseResultModel?> deleteService(
      int id) async {
    try {
      final res = await RemoteDataSource.request<MessageResponseModel>(
          converter: (json) => MessageResponseModel.fromJson(json),
          method: HttpMethod.get,
          withAuthentication: true,
          url: '${ApiURLs.deleteService}/$id');
      return res;
    } catch(e) {
      print(e);
    }
  }
}
