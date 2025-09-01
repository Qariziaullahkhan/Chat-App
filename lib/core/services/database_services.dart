import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final _fire = FirebaseFirestore.instance;
  
  Future<void> saveUser(Map<String, dynamic> userData, String uid) async {
    try {
      await _fire.collection('users').doc(uid).set(userData);
      log("User saved successfully with UID: $uid");
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> loadUser(String uid) async {
    try {
      // This should match how you saved the user
      final res = await _fire.collection('users').doc(uid).get();
      
      if (res.exists) {
        log("User loaded successfully: ${res.data()}");
        return res.data();
      } else {
        log("No user found with UID: $uid");
        return null;
      }
    } catch (e) {
      log("Error loading user: $e");
      rethrow;
    }
  }
}