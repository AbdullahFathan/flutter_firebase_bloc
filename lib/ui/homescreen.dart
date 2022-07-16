import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:firebase_bloc/ui/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final username = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome To Homescreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome ${username.email}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(IsHasLogOut());
              },
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Unauthenticated) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  }
                  if (state is AuthEror) {
                    print(state.eror.toString());
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const Text(
                    "LOG OUT",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
