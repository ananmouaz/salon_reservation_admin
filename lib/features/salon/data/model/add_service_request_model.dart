class AddServiceRequestModel {
  String? service;
  String? name;
  String? duration;
  String? price;
  String? type;
  int? status;

  AddServiceRequestModel(
      {
        required this.service,
        required this.name,
        required this.duration,
        required this.price,
        required this.type,
        required this.status,
      });

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'name': name,
      'duration': duration,
      'price': price,
      'type': type,
      'status': status,
    };
  }
}