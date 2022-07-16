part of 'account_bloc.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSucess extends AccountState {}

class AccountEror extends AccountState {
  final String eror;
  AccountEror(
    this.eror,
  );
}
