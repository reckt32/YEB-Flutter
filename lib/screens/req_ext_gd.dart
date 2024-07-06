import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yeb_flutter/screens/a11.dart';
import 'dart:convert';
import 'package:yeb_flutter/services/test3.dart';

import 'package:yeb_flutter/screens/gd_deny.dart';
//saari details fetch karni hongi uske fuctions likho
//saari details fetch karni hongi uske fuctions likho
class GDExt extends StatefulWidget {
  const GDExt({super.key});

  @override
  State<GDExt> createState() => _GDExtState();
}

class _GDExtState extends State<GDExt> {
  String? userId = '';
  String? username = '';
  Future<void> sendPostRequest(String reason) async {
    final url = Uri.parse('http://10.0.2.2:8000/events/gd_request/');
    final headers = {'Content-Type': 'application/json',
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU1OTExMDI3LCJpYXQiOjE3MTk5MTEwMjcsImp0aSI6ImFkYTE2ZGE3NDZkYTQ4M2I4NTJiNGRjODdiYzJlMGIyIiwidXNlcl9pZCI6Mn0.G86CMYcQJyK88CyoVALqGFyfiimaQF7E4e_ltAsQayI',
    };
    final body = json.encode({
      'reason': reason,
      'gd_static_id': '8e22f4b6-28e1-4d6a-a755-40b77594ebc1',
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
        'http://10.0.2.2:8000/users/user-info/'; // Replace with your actual API URL
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU1OTExMDI3LCJpYXQiOjE3MTk5MTEwMjcsImp0aSI6ImFkYTE2ZGE3NDZkYTQ4M2I4NTJiNGRjODdiYzJlMGIyIiwidXNlcl9pZCI6Mn0.G86CMYcQJyK88CyoVALqGFyfiimaQF7E4e_ltAsQayI',
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
                'assets/icons/google.png'), // Replace with your image asset
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
                child: Image.asset('assets/icons/google.png')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Kindly state the reason for requesting an extension of your GD extension',
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
                      'Kindly note that requesting an extension does not guarantee that it will be granted. The decision will be made by the admin team.',
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
                  onPressed: () async {
                    String reason= textEditingController.text;
                    await sendPostRequest(reason);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (GDAcceptedScreen())),
                    );
                  },
                  child: const Text('Submit',
                      style: const TextStyle(color: Colors.white))),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GDselected()));
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
