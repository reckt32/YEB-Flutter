import 'package:flutter/material.dart';
import 'package:yeb_flutter/screens/a11.dart';
import 'package:yeb_flutter/screens/req_ext_gd.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yeb_flutter/services/request.dart';

//saari details fetch karni hongi uske fuctions likho
class GDDeny extends StatefulWidget {
  @override
  State<GDDeny> createState() => _GDDenyState();
}

class _GDDenyState extends State<GDDeny> {
  String? userId = '';
  String? username = '';
  Future<void> sendPostRequest() async {
    final url = Uri.parse('http://127.0.0.1/events/gd_request/');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'reason': 'India ka match hai',
      'gd_static_id': '6ec56dd3-b285-4ceb-bf92-3bc67436f81c',
      'type': 'not_coming',
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Request successful: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
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
        setState(() {
          userId = data['static_id'];
          username = data['username'];
        });
      } else {
        print('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: (150.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0))),
        backgroundColor: Colors.blue[900],
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 10.0,
            backgroundImage: AssetImage(
                'assets/icons/google_logo.webp'), // Replace with your image asset
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  username!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38.0,
                  ),
                ),
                Text(
                  userId!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset('assets/icons/google_logo.webp')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Kindly state the reason for denying participating in the GD',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 213, 212, 212),
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      'Kindly note that by denying to particpate in GD, you will no longer be a part of YEB process',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    sendPostRequest();
                  },
                  child: const Text('Submit',
                      style: const TextStyle(color: Colors.white))),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GDselected();
                  }));
                },
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          // Handle navigation on tap
          switch (index) {
            case 0:
              // Navigate to Home
              break;
            case 1:
              // Navigate to Settings
              break;
            case 2:
              // Handle Logout
              break;
          }
        },
      ),
    );
  }
}
