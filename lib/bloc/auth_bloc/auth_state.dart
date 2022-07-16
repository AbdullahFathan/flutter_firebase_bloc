part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  User? user;
  Authenticated({
    required this.user,
  });
}

class Unauthenticated extends AuthState {}

class AuthEror extends AuthState {
  final String eror;
  AuthEror(
    this.eror,
  );
}

class AuthLoading extends AuthState {}
