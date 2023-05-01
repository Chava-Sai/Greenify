import 'package:flutter/material.dart';

import '../register/login.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final VoidCallback onLogout;

  const ProfilePage({
    Key? key,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF00AEEF),
                    Color(0XFF4AC3E3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('Assets/image/profile.jpg'),
                radius: 100,
              ),
              SizedBox(height: 16),
              Text(
                username,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(email),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(phoneNumber),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: onLogout,
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
