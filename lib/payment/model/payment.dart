class Payment {
  Payment({
    this.id,
    this.user_id,
    this.reservation_id,
    this.payment_method,
    this.payment_status,
    this.payment_amount,
  });

  String? id;
  String? user_id;
  String? reservation_id;
  String? payment_method;
  String? payment_status;
  int? payment_amount;
}
