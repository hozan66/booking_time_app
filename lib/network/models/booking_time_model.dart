class BookingTimeModel {
  final String uid;
  final DateTime date;
  final String bookingTime;

  BookingTimeModel({
    required this.uid,
    required this.date,
    required this.bookingTime,
  });

  factory BookingTimeModel.fromJson(Map<String, dynamic> json) {
    return BookingTimeModel(
      uid: json['uid'],
      date: json['date'].toDate(),
      bookingTime: json['booking_time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'date': date.toUtc(),
      'booking_time': bookingTime,
    };
  }

  BookingTimeModel copyWith({
    String? uid,
    bool? isTimeAvailable,
    DateTime? date,
    String? bookingTime,
  }) {
    return BookingTimeModel(
      uid: uid ?? this.uid,
      date: date ?? this.date,
      bookingTime: bookingTime ?? this.bookingTime,
    );
  }
}
