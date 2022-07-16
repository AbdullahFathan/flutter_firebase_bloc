part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class Login extends AccountEvent {
  final String email;
  final String password;
  Login({
    required this.email,
    required this.password,
  });
}

class Register extends AccountEvent {
  final String email;
  final String password;
  Register({
    required this.email,
    required this.password,
  });
}
