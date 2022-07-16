import 'package:firebase_bloc/bloc/account_bloc/account_bloc.dart';
import 'package:firebase_bloc/ui/homescreen.dart';
import 'package:firebase_bloc/ui/signupscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          _loginform(),

          //* BUTTON BLOC

          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AccountBloc>(context).add(Login(
                  email: _emailTextController.text.trim(),
                  password: _passwordTextController.text.trim()));
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
                  "LOGIN USER",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }

  Widget _loginform() => Expanded(
          child: Column(
        children: [
          TextField(
            controller: _emailTextController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _passwordTextController,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
                text: "don't have an account ?? ",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = gotoSignupScreen,
                      text: " Sign Up",
                      style: const TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          decoration: TextDecoration.underline)),
                ]),
          )
        ],
      ));

  void gotoSignupScreen() => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
}
