import 'package:firebase_bloc/bloc/account_bloc/account_bloc.dart';
import 'package:firebase_bloc/ui/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign UP "),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          _signUpForm(),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<AccountBloc>(context).add(Register(
                    email: _emailInputController.text.trim(),
                    password: _passwordInputController.text.trim()));
              },
              child: BlocConsumer<AccountBloc, AccountState>(
                listener: (context, state) {
                  if (state is AccountEror) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.eror)));
                  } else if (state is AccountSucess) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Homescreen()));
                  }
                },
                builder: (context, state) {
                  if (state is AccountLoading) {
                    return const CircularProgressIndicator();
                  }
                  return const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  Widget _signUpForm() => Column(
        children: [
          TextField(
            controller: _emailInputController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _passwordInputController,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
