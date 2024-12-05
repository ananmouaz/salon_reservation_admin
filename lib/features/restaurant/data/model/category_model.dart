import '../../../../core/api/core_models/base_result_model.dart';

class CategoryModel extends BaseResultModel{
  String? category;
  List<CategoryItem>? items;

  CategoryModel({
  this.category,
  this.items,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
  category = json['category'];

  List<CategoryItem> list = <CategoryItem>[];
  json['items'].forEach((v) {
    list.add(CategoryItem.fromJson(v));
  });
  items = list;
  }
}

class CategoryItem {
  int? id;
  int? menuId;
  int? categoryId;
  String? name;
  String? description;
  String? price;
  String? image;

  CategoryItem({
    this.id,
    this.menuId,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
  }
}

class CategoriesResponseModel extends BaseResultModel{
  List<CategoryModel>? items;

  CategoriesResponseModel({
    required this.items,
  });

  CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    List<CategoryModel> list = <CategoryModel>[];

    json['categories'].forEach((v) {
      list.add(CategoryModel.fromJson(v));
    });
    items = list;
  }
}