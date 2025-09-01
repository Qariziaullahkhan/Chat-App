import 'dart:developer';

import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/other/base_viewmodel.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupviewModel extends BaseViewmodel {
  final AuthService _auth;
  final DatabaseServices _db;

  SignupviewModel(this._auth,this._db);
  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  void setName(String value) {
    _name = value;
    notifyListeners();
    log("Name: $_name");
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
    log("Email: $_email");
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
    log("Password: $_password");
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
    log("Confirm Password: $_confirmPassword");
  }

  signup() async {
  setstate(ViewState.loading);

  try {
    final res = await _auth.signup(_email, _password);
    if(res != null){
      // Remove the extra comma after email: _email
      UserModel user = UserModel(uid: res.uid, name: _name, email: _email);
      await _db.saveUser(user.toMap(), res.uid);
    }
    setstate(ViewState.idle);
  } on FirebaseAuthException catch (e) {
    setstate(ViewState.idle);
    rethrow;
  } catch (e) {
    log(e.toString());
    setstate(ViewState.idle);
    rethrow;
  }
}
}
