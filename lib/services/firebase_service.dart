import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Function to save data to Firebase
void saveDataToFirebase(String uid, String userName, double carbonFootprint) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'userName': userName,
    'carbonFootprint': carbonFootprint,
  });
}

// Example usage
void onSubmit(double carbonFootprint) async {
  // Get the user's UID from Firebase
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // Retrieve the user's name from Firebase
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  String userName = userDoc['userName'];

  // Save the data to Firebase
  saveDataToFirebase(uid, userName, carbonFootprint);
}
