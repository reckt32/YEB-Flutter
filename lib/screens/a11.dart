import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yeb_flutter/screens/gd_deny.dart';
import 'package:yeb_flutter/screens/gd_screen.dart';
import 'package:yeb_flutter/screens/req_ext_gd.dart';
import 'dart:convert';
import 'package:yeb_flutter/services/test2.dart';
import 'package:yeb_flutter/services/test3.dart';
import 'package:yeb_flutter/services/test1.dart';
import 'package:yeb_flutter/models/gd_details.dart';
import 'package:yeb_flutter/services/request.dart';
import 'gd_deny.dart';
//import 'req_ext_gd.dart';

//saari details fetch karni hongi uske fuctions likho
class GDselected extends StatefulWidget {
  @override
  State<GDselected> createState() => _GDselectedState();
}

class _GDselectedState extends State<GDselected> {
  String? username = '';
  String? userId = '';
  String? gdDate = '';
  String? gdTime = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    Future<Gd_details> gdDetails = Request().fetchGDDetails();
    gdDetails.then((value) {
      setState(() {
        gdDate = value.date;
        gdTime = value.time;
      });
    });
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

  Future<void> sendPostRequest() async {
    final url = Uri.parse('http://10.0.2.2:8000/events/updated-gd-status/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU1OTExMDI3LCJpYXQiOjE3MTk5MTEwMjcsImp0aSI6ImFkYTE2ZGE3NDZkYTQ4M2I4NTJiNGRjODdiYzJlMGIyIiwidXNlcl9pZCI6Mn0.G86CMYcQJyK88CyoVALqGFyfiimaQF7E4e_ltAsQayI',
      },
      body: json.encode({'key': 'value'}),
    );

    if (response.statusCode == 200) {
      print('Post request successful');
      print('Response: ${response.body}');
    } else {
      print('Post request failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: (100.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0))),
        backgroundColor: Colors.blue[900],
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Color(0xffE6E6E6),
            radius: 30,
            child: Icon(
              Icons.person,
              color: Color(0xffCCCCCC),
            ),
            // Replace with your image asset
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
                    fontSize: 15.0,
                  ),
                ),
                /*Text(
                  userId,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),*/
              ],
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset('assets/icons/google_logo.webp')),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'CONGRATULATIONS !',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900]),
              textAlign: TextAlign.center,
            ),
            Text(
              'You have been selected for GD!',
              style: TextStyle(fontSize: 18, color: Colors.blue[900]),
              textAlign: TextAlign.center,
            ),
            Text(
              'Your GD is scheduled on $gdDate at $gdTime',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await sendPostRequest();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GDScreen()),
                            );
                          },
                          child: const Text('Accept',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GDDeny()),
                            );
                          },
                          child: const Text('Deny',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GDExt()),
                            );
                          },
                          child: const Text('Request Extension',
                              style: const TextStyle(color: Colors.white))),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GDExt()),
                );
                // Handle back navigation
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
