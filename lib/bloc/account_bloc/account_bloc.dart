import 'package:bloc/bloc.dart';
import 'package:firebase_bloc/services/auth_services.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthServies _authServies;
  AccountBloc(this._authServies) : super(AccountInitial()) {
    on<AccountEvent>((event, emit) async {
      if (event is Login) {
        emit(AccountLoading());
        try {
          final result = await _authServies.login(event.email, event.password);
          if (result == true) {
            emit(AccountSucess());
            print(" Login has success {account_bloc.dart}");
          } else {
            emit(AccountEror("Login has fail {account_bloc.dart}"));
          }
        } catch (eror) {
          emit(AccountEror(eror.toString()));
        }
      }

      if (event is Register) {
        emit(AccountLoading());
        try {
          final result =
              await _authServies.register(event.email, event.password);
          if (result == true) {
            emit(AccountSucess());
            print(" Register  has success {account_bloc.dart}");
          } else {
            emit(AccountEror("Register has fail {account_bloc.dart} "));
          }
        } catch (eror) {
          emit(AccountEror(eror.toString()));
        }
      }
    });
  }
}
