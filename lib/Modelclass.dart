class Package {
  final String title;
  final String desc;
  final String price;

  Package({required this.title, required this.desc, required this.price});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      title: json['title'] ?? '',
      price: json['price'] ?? '0.0',
      desc: json['desc'] ?? '',
    );
  }
}

// models/booking.dart
class Booking {
  final String title;
  final String from_date;
  final String from_time;
  final String to_date;
  final String to_time;

  Booking(
      {required this.title,
      required this.from_date,
      required this.from_time,
      required this.to_date,
      required this.to_time});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      title: json['title'] ?? '',
      from_date: json['from_date'] ?? '',
      from_time: json['from_time'] ?? '',
      to_date: json['to_date'] ?? '',
      to_time: json['to_time'] ?? '',
    );
  }
}
