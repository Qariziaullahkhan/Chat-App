import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/services/database_services.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final DatabaseServices _db;
  UserProvider(this._db);

  UserModel? _currentuser;
  UserModel? get user => _currentuser;

  Future<void> loadUser(String uid) async {
    final userdata = await _db.loadUser(uid);
    if (userdata != null) {
      _currentuser = UserModel.fromMap(userdata);
      notifyListeners();
    }
  }
}
