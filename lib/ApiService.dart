// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_new_app/Modelclass.dart';

class ApiService {
  final String packagesUrl =
      "https://www.cgprojects.in/lens8/api/dummy/packages_list";
  final String currentBookingsUrl =
      "https://www.cgprojects.in/lens8/api/dummy/current_booking_list";

  Future<List<Package>> fetchPackages() async {
    final response = await http.get(Uri.parse(packagesUrl));
    print(",vdfjdhkjdh ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['response'];
      print(",djhdgjk  $data");
      return data.map((json) => Package.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load packages");
    }
  }

  Future<List<Booking>> fetchCurrentBookings() async {
    final response = await http.get(Uri.parse(currentBookingsUrl));
    if (response.statusCode == 200) {
      print("jhfjkhgjkdfhkj ${response.body}");
      final List<dynamic> data = jsonDecode(response.body)['response'];
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load bookings");
    }
  }
}
