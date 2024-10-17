class Booking {
  final String villaId;
  final String villaName;
  final String villaLocation;
  final String dayCount;
  final String bookingStartDate;
  final String bookingEndDate;
  final String totalAmount;
  final String userEmail;

  Booking({
    required this.villaId,
    required this.villaName,
    required this.villaLocation,
    required this.dayCount,
    required this.bookingStartDate,
    required this.bookingEndDate,
    required this.totalAmount,
    required this.userEmail,
  });

  factory Booking.fromMap(Map<String, dynamic> data) {
    return Booking(
      villaId: data['villa_id'] ?? '',
      villaName: data['villa_name'] ?? '',
      villaLocation: data['villa_location'] ?? '',
      dayCount: data['day_count'] ?? 0,
      bookingStartDate: data['booking_start_date'],
      bookingEndDate: data['booking_end_date'],
      totalAmount: data['total_amount'],
      userEmail: data['user_email'] ?? '',
    );
  }
}
