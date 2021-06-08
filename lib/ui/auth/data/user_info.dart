import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priyo_quiz/constants/sharedpref_keys.dart';
import 'package:priyo_quiz/services/shared_preference.dart';
import 'package:priyo_quiz/ui/auth/data/models/user.dart';
import 'package:rxdart/subjects.dart';

class UserInfo {
  String? _deviceId;
  String? _deviceType;

  final BehaviorSubject<UserProfile> _userDetails = BehaviorSubject<UserProfile>();

  BehaviorSubject<UserProfile> get userDetails => _userDetails;

  set deviceId(String? deviceId) {
    _deviceId = deviceId;
  }

  set deviceType(String? deviceType) {
    _deviceType = deviceType;
  }

  String? getDeviceId(){
    return _deviceId;
  }

  String? getDeviceType(){
    return _deviceType;
  }

  void saveUserData(UserProfile userData) {
    print("SAVEUSER");
    _userDetails.sink.add(userData);
    SharedPreferenceManager.instance
        .setString(SharedPrefKeys.USER, json.encode(userData));
  }

  Future<void> logout() async {
    _cleanUserStream();
    SharedPreferenceManager.instance.remove(SharedPrefKeys.USER);
    SharedPreferenceManager.instance.clear();
    
    await FirebaseAuth.instance.signOut();

    // final facebookLogin = FacebookLogin();
    // facebookLogin.isLoggedIn.then((b) {
    //   facebookLogin.logOut();
    // });

    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.isSignedIn().then((s) {
      googleSignIn.signOut();
    });
  }

  void dispose() {
    _userDetails.close();
  }

  void clean() {}

  void _cleanUserStream() {
    _userDetails.sink.add(UserProfile());
  }
}

final userInfo = UserInfo();