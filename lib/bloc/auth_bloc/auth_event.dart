part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class IsHasLogin extends AuthEvent {}

class IsHasLogOut extends AuthEvent {}
