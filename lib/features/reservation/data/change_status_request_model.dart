class ChangeStatusRequestModel {
  String status; int reservationId;

  ChangeStatusRequestModel({
    required this.status,
    required this.reservationId,
  });
}

class ChangeTotalRequestModel {
  int price; int reservationId;

  ChangeTotalRequestModel({
    required this.price,
    required this.reservationId,
  });
}