import 'dart:developer';

import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/other/base_viewmodel.dart';
import 'package:chat_app/core/services/database_services.dart';

class HomeviewModel extends BaseViewmodel {
  final DatabaseServices _db;
  final String uid;
  UserModel? _currentuser;
  UserModel? get currentuser => _currentuser;
  
  HomeviewModel(this._db, this.uid) {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setstate(ViewState.loading);
    try {
      final res = await _db.loadUser(uid);
      if (res != null) {
        _currentuser = UserModel.fromMap(res);
      } else {
        log("User data not found for UID: $uid");
      }
    } catch (e) {
      // Handle errors
      log("Error fetching user data: $e");
    } finally {
      setstate(ViewState.idle);
    }
  }
}