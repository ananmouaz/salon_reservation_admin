import 'package:salon_reservation/features/restaurant/data/model/category_model.dart';

import '../../../core/api/core_models/base_result_model.dart';
import '../../../core/api/data_source/remote_data_source.dart';
import '../../../core/api/http/api_urls.dart';
import '../../../core/api/http/http_method.dart';

class RestaurantRepository {
  static Future<BaseResultModel?> getCategories() async {
    final res = await RemoteDataSource.request<CategoriesResponseModel>(
        converter: (json) => CategoriesResponseModel.fromJson(json),
        method: HttpMethod.get,
        withAuthentication: true,
        url: ApiURLs.categories
    );
    return res;
  }

  static Future<BaseResultModel?> getItems(String categoryId) async {
    final res = await RemoteDataSource.request<CategoryModel>(
        converter: (json) => CategoryModel.fromJson(json),
        method: HttpMethod.get,
        withAuthentication: true,
        url: '${ApiURLs.categories}/$categoryId/items'
    );
    return res;
  }
}
