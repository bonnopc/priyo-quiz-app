import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:priyo_quiz/ui/auth/data/models/requests.dart';

enum SocialLoginType { google, facebook, apple }

class FirebaseAuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future<SocialAuth?> handleSignIn(SocialLoginType type) async {
    switch (type) {
      case SocialLoginType.google:
        try {
          GoogleSignInAccount? googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount?.authentication;

          final googleAuthCred = GoogleAuthProvider.credential(
              idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

          final user = await firebaseAuth.signInWithCredential(googleAuthCred);
          String? firebaseIdToken = await firebaseAuth.currentUser?.getIdToken();
          print("googleAuth?.idToken ${googleAuth?.idToken}");
          print("googleAuth?.accessToken ${googleAuth?.accessToken}");
          print("firebaseIdToken ==> $firebaseIdToken");
          final args = SocialAuth(
              email: user.additionalUserInfo?.profile?['email'],
              idToken: googleAuth?.idToken);

          return args;
        } catch (e) {
          print("Error when login with google $e");
          return null;
        }
      default:
        return null;
    }
  }

  Future<GoogleSignInAccount?> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    return googleUser;
  }
}