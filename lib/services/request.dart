import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yeb_flutter/models/gd_details.dart';
import 'package:yeb_flutter/models/gd_request.dart';

class Request {
  Future<Gd_details> fetchGDDetails() async {
    final apiUrl =
        'http://127.0.0.1:8000/events/gd_details'; // Replace with your actual API URL
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU1OTU5MDQ0LCJpYXQiOjE3MTk5NTkwNDQsImp0aSI6IjNhNjc4ZmJlMDlhZjRlN2U5ZTVjNzNjNjk1N2ZkZTcxIiwidXNlcl9pZCI6Mn0.bJ0NfEe4fYMc_iN-frhtqsKNvzQH2i8bIpewBung7RU',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Gd_details.fromJson(data);
      } else {
        print('Failed to load GD details');
        return Gd_details();
      }
    } catch (e) {
      print('Error fetching GD details: $e');
      throw e;
    }
  }

  Future<void> fetchUserData() async {
    final apiUrl =
        'http://127.0.0.1:8000/users/user-info/'; // Replace with your actual API URL
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU1OTU5MDQ0LCJpYXQiOjE3MTk5NTkwNDQsImp0aSI6IjNhNjc4ZmJlMDlhZjRlN2U5ZTVjNzNjNjk1N2ZkZTcxIiwidXNlcl9pZCI6Mn0.bJ0NfEe4fYMc_iN-frhtqsKNvzQH2i8bIpewBung7RU',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['username'];
      } else {
        print('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
