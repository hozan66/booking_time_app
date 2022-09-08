// Packages
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

const String userCollection = 'Users';

const String bookingCollection = 'Booking';

class DatabaseService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  DatabaseService();

  // Getting a single document from User collection
  Future<DocumentSnapshot> getUserInfo(String uid) {
    return _database.collection(userCollection).doc(uid).get();
  }

  // Adding Booking time to Firestore
  Future<void> addBookingTimeToFirestore(
      Map<String, dynamic> bookingData) async {
    // try {
    // Adding a new document inside Booking collection
    await _database.collection(bookingCollection).add(bookingData);
    // } catch (e) {
    //   log(e.toString());
    // }
  }
}
