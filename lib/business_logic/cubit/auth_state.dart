part of 'auth_cubit.dart';

enum AuthType { signIn, signUp }

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final AuthType authType;
  AuthAuthenticated({required this.user,required this.authType});
}

class AuthUnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
