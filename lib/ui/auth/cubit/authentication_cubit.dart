import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:priyo_quiz/services/firebase_auth.dart';
import 'package:priyo_quiz/ui/auth/data/models/requests.dart';
import 'package:priyo_quiz/ui/auth/data/models/user.dart';
import 'package:priyo_quiz/ui/auth/data/provider.dart';
import 'package:priyo_quiz/ui/auth/data/user_info.dart';

part 'authentication_state.dart';

String? getSocialProviderNameFromType(SocialLoginType type) {
  switch (type) {
    case SocialLoginType.google:
      return "google";
    case SocialLoginType.facebook:
      return "facebook";
    default:
      return null;
  }
}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> handleSocialLogin(SocialLoginType type) async {
    try {
      emit(AuthenticationLoading());

      final SocialAuth? authResponse = await FirebaseAuthService().handleSignIn(type);

      if(authResponse != null){
        final String? deviceId = userInfo.getDeviceId();
        final String? clientType = userInfo.getDeviceType();
        final String? provider = getSocialProviderNameFromType(type);

        final UserProfile? _user = await AuthDataProvider().handleSocialSignIn(
          authResponse.idToken, deviceId, clientType, provider);

        if(_user != null){
          userInfo.saveUserData(_user);
          emit(AuthenticationSuccess(_user));
        } else {
          emit(AuthenticationError());
        }

      } else {
        emit(AuthenticationError());
      }

    } catch (e) {
      print("Error on handleSocialLogin in AuthenticationCubit $e");
      emit(AuthenticationError());
    }
  }
}