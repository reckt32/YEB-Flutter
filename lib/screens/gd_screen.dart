import 'package:flutter/material.dart';
import 'package:yeb_flutter/models/gd_details.dart';
import 'package:yeb_flutter/screens/a11.dart';
import 'package:yeb_flutter/services/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GDScreen extends StatefulWidget {
  @override
  State<GDScreen> createState() => _GDScreenState();
}

class _GDScreenState extends State<GDScreen> {
  String? userId = '';
  String? username = '';
  String? gdDate = '';
  String? gdTime = '';
  String? gdCode = '';
  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    Future<Gd_details> gdDetails = Request().fetchGDDetails();
    gdDetails.then((value) {
      setState(() {
        gdDate = value.date;
        gdTime = value.time;
        gdCode = value.link;
      });
    });
    super.initState();
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
                  '$username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38.0,
                  ),
                ),
                Text(
                  '$userId',
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Details for GD',
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
                          onPressed: () {},
                          child: Text('$gdTime',
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
                          onPressed: () {},
                          child: Text('$gdTime',
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
                          onPressed: () {},
                          child: Text('$gdCode',
                              style: const TextStyle(color: Colors.white))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                    'The topic will be provided onspot by the fellow instructor in charge')),
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
