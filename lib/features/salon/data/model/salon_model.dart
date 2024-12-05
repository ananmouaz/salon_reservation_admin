import 'dart:developer';

import '../../../../core/api/core_models/base_result_model.dart';

class SalonModel {
  int? id;
  String? name;
  int? userId;
  int? hijabis;
  String? location;
  String? openingHours;
  String? status;
  List<ServiceModel>? service;
  String? image;

  SalonModel({
    this.id,
    this.name,
    this.userId,
    this.hijabis,
    this.location,
    this.openingHours,
    this.status,
    this.service,
    this.image,
  });

  SalonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    hijabis = json['hijabis'];
    location = json['location'];
    openingHours = json['opening_hours'];
    status = json['status'];
    image = json['image'];
    List<ServiceModel> tempList = [];

    if(json['service'] != null) {
      json['service'].forEach((v) {
        tempList.add(ServiceModel.fromJson(v));
      });
      service = tempList;
    }

  }
}

class ServiceModel {
  int? id;
  int? businessId;
  String? service;
  int? price; 
  String? duration;
  String? type;
  int? status;
  String? name;

  ServiceModel({
    this.id,
    this.service,
    this.businessId,
    this.price,
    this.duration,
    this.type,
    this.status,
    this.name,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    businessId = json['business_id'];
    price = json['price'];
    duration = json['duration'];
    type = json['type'];
    status = json['status'];
    name = json['name'];
  }
}

class ServicesResponseModel extends ListResultModel<ServiceModel> {
  int? totalCount;
  late List<ServiceModel> data;

  ServicesResponseModel({this.totalCount, required this.data});

  ServicesResponseModel.fromJson(Map<String, dynamic> json) {
    list = <ServiceModel>[];

    json['data'].forEach((v) {
      list.add(ServiceModel.fromJson(v));
    });

    if (json['data'] != null) {
      data = list;
      totalCount = list.length;
    }
  }
}

class SalonsResponseModel extends ListResultModel<SalonModel> {
  int? totalCount;
  late List<SalonModel> data;

  SalonsResponseModel({this.totalCount, required this.data});

  SalonsResponseModel.fromJson(Map<String, dynamic> json) {
    list = <SalonModel>[];

    json['data'].forEach((v) {
      list.add(SalonModel.fromJson(v));
    });

    if (json['data'] != null) {
      data = list;
      totalCount = list.length;
    }
  }
}
