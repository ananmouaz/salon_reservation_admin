class UpdateBusinessRequestModel {
  String? name;
  String? location;
  String? openingHours;
  String? status;
  int? hijabis;

  UpdateBusinessRequestModel(
      {
        required this.name,
        required this.location,
        required this.openingHours,
        required this.status,
        required this.hijabis,
      });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'opening_hours': openingHours,
      'status': status,
      'hijabis': hijabis,
    };
  }
}