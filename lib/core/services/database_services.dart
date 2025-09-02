import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final _fire = FirebaseFirestore.instance;
  
  Future<void> saveUser(Map<String, dynamic> userData, ) async {
    try {
      await _fire.collection("users").doc(userData["uid"]).set(userData);
      log("User saved successfully");
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> loadUser(String uid) async {
    try {
      // This should match how you saved the user
      final res = await _fire.collection('users').doc(uid).get();
      
      if (res.data() != null) {
        log("User fetched successfully");
        return res.data();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
  Future<List<Map<String, dynamic>>?> fetchUser(String currentUserId) async {
    try {
      final res = await _fire
          .collection('users')
          .where('uid', isNotEqualTo: currentUserId)
          .get();

      return res.docs.map((e) => e.data()).toList();
    } catch (e) {
      log("Error loading user: $e");
      rethrow;
    }
  }
Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserStream(
          String currentUserId) =>
      _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .snapshots();
}