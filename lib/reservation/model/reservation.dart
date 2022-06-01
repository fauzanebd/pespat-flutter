class Reservation {
  Reservation({
    this.id,
    this.place_id,
    this.user_id,
    this.reservation_time,
  });

  String? id;
  String? place_id;
  String? user_id;
  DateTime? reservation_time;
}
