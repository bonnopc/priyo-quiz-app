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
  final _provider = AuthDataProvider();

  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> handleSocialLogin(SocialLoginType type) async {
    try {
      emit(AuthenticationLoading());

      final SocialAuth? authResponse = await FirebaseAuthService().handleSignIn(type);

      if(authResponse != null){
        final String? deviceId = userInfo.getDeviceId();
        final String? clientType = userInfo.getDeviceType();
        final String? provider = getSocialProviderNameFromType(type);

        final UserProfile? _user = await _provider.handleSocialSignIn(
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

  Future<void> createOtpOrVerify({
    String? phoneNo, String? otp
  }) async {
    try {
      emit(CreateOtpLoading());

      final _phone = phoneNo?.length == 11 ? phoneNo?.substring(1) : phoneNo;

      final bool? otpResponse = await _provider.createOtpOrVerify(
        phoneNo: "+880$_phone",
        otp: otp
      );

      if(otpResponse == true){
        if(otp != null && otp.isNotEmpty) emit(VerifyOtpSuccess());
        else emit(CreateOtpSuccess());
      }
      else emit(CreateOtpError());

    } catch (e) {
      print("Error on createOtp in AuthenticationCubit $e");
      emit(CreateOtpError());
    }
  }
}