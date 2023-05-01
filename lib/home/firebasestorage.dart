// Import the necessary libraries
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'date.dart';
import 'weather.dart';

// Declare a global instance of FirebaseAuth
final FirebaseAuth auth = FirebaseAuth.instance;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // Declare a text editing controller to capture user input
  final TextEditingController _dataController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the weather data:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _dataController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter data',
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to save the user input data to Firebase
  Future<void> _saveData() async {
    // Get the user's email from FirebaseAuth
    final User? user = auth.currentUser;
    final String email = user?.email ?? '';

    // Get the user's input data
    final String inputData = _dataController.text;

    // Save the data to Firebase
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    // Check if the user exists in the 'users' collection
    final QuerySnapshot<Object?> userQuery =
        await userCollection.where('email', isEqualTo: email).get();

    if (userQuery.docs.isNotEmpty) {
      // The user exists in the 'users' collection, so we can save the data
      final String userId = userQuery.docs[0].id;
      final DocumentReference userDoc =
          userCollection.doc(userId).collection('data').doc();

      // Save the data to Firebase
      await userDoc.set({
        'date': DateTime.now().toIso8601String(),
        'data': inputData,
      });

      // Clear the text field after saving the data
      _dataController.clear();
    } else {
      // The user does not exist in the 'users' collection
      print('User does not exist in the database');
    }
  }
}
