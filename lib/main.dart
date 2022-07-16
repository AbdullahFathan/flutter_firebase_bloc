import 'package:firebase_bloc/bloc/account_bloc/account_bloc.dart';
import 'package:firebase_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:firebase_bloc/services/auth_services.dart';
import 'package:firebase_bloc/ui/homescreen.dart';
import 'package:firebase_bloc/ui/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

AuthServies authservices = AuthServies();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(authservices)),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authservices)),
      ],
      child: const MaterialApp(
        home: MainPageAuth(),
      ),
    );
  }
}

class MainPageAuth extends StatelessWidget {
  const MainPageAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authservices)..add(IsHasLogin()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return const Homescreen();
          } else if (state is Unauthenticated) {
            return const LoginScreen();
          } else if (state is AuthEror) {
            print(state.eror.toString());
          }
          return Container();
        },
      ),
    );
  }
}
