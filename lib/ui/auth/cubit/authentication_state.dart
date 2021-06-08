part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationSuccess extends AuthenticationState {
  final UserProfile? user;

  AuthenticationSuccess(this.user);

  List<dynamic> get props => [user];
}
class AuthenticationError extends AuthenticationState {}