import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc/services/auth_services.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServies _authServies;
  AuthBloc(this._authServies) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is IsHasLogin) {
        try {
          final resultCekHasLogin = await _authServies.isHasSignIn();
          if (resultCekHasLogin) {
            var user = await _authServies.getCurrentUser();
            emit(Authenticated(user: user));
          } else {
            emit(Unauthenticated());
          }
        } catch (eror) {
          emit(AuthEror(eror.toString()));
        }
      }

      if (event is IsHasLogOut) {
        emit(AuthLoading());
        try {
          _authServies.logout();
          emit(Unauthenticated());
        } catch (eror) {
          emit(AuthEror(eror.toString()));
        }
      }
    });
  }
}
