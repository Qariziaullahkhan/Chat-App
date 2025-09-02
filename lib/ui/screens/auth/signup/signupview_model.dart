import 'dart:developer';
import 'dart:io';

import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/core/other/base_viewmodel.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_services.dart';
import 'package:chat_app/core/services/storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SignupviewModel extends BaseViewmodel {
  final AuthService _auth;
  final DatabaseServices _db;
  final StorageService _storage;
  SignupviewModel(this._auth, this._db, this._storage);

  final _picker = ImagePicker();
  File? _image;

  File? get image => _image;

  pickImage() async {
    log("Pick Image");
    final pic = await _picker.pickImage(source: ImageSource.gallery);

    if (pic != null) {
      _image = File(pic.path);
      notifyListeners();
    }
  }

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
    String? downloadUrl;
    setstate(ViewState.loading);

    try {
      final res = await _auth.signup(_email, _password);

      if (_password != _confirmPassword) {
        throw Exception("Passwords do not match");
      }
      if (res != null) {
        if (_image != null) {
          downloadUrl = await _storage.uploadImage(_image!);
        }

        UserModel user = UserModel(
          uid: res.uid,
          name: _name,
          email: _email,
          imageUrl: downloadUrl,
        );
        await _db.saveUser(user.toMap(),);
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
