import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../api/core_models/base_response_model.dart';
import '../../../api/core_models/base_result_model.dart';
import '../models/get_list_request.dart';
import '../../../api/errors/base_error.dart';
part 'pagination_state.dart';

typedef RepositoryCallBack = Future<BaseResultModel?> Function(dynamic data);

class PaginationCubit<ListModel> extends Cubit<PaginationState> {
  final RepositoryCallBack? getData;

  PaginationCubit(this.getData) : super(PaginationInitial());
  List<ListModel> list = [];
  Map<String, dynamic> params = {};
  int maxResultCount = 10;
  int page = 1;

  getList({bool loadMore = false, Map<String, dynamic>? param}) async {
    if (getData == null) return;

    if (!loadMore) {
      page = 1;
      if (list.isEmpty) {
        emit(Loading());
      }
    } else {
      page += 1;
    }

    if (param != null) {
      params.addAll(param);
    }

    var requestData = GetListRequest(
        extraParams: params,
        page: page
    );
    var response = await getData!(requestData);
    if (response is ListResultModel<ListModel>) {
      if (loadMore) {
        list.addAll(response.list);
      } else {
        list = response.list;
      }
      emit(GetListSuccessfully(
          list: list, noMoreData: response.list.isEmpty && loadMore));
    } else if (response is BaseError) {
      emit(Error(response.message));
    } else if (response is ServerError) {
      emit(Error(response.error ?? 'An error has occurred'));
    } else {
      emit(PaginationInitial());
    }
  }
}