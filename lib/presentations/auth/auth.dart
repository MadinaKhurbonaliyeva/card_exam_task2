import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/screens/cards/cards.dart';
import 'bloc/auth_bloc.dart';
import 'mixin/auth_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const CardsPage();
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Image(image: AssetImage('asset/images/cards.jpg'))
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5,),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Enter your email",
                                  labelStyle: const TextStyle(
                                    color: Colors.lightGreen,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  fillColor: Colors.green,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 5,),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Enter your password",
                                  labelStyle: const TextStyle(
                                    color: Colors.lightGreen,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  fillColor: Colors.green,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50,bottom: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Colors.green),
                                onPressed: () {
                                  context.read<AuthBloc>().add(LoginEvent(
                                      email: emailController.text,
                                      password: passwordController.text));
                                },
                                child: const Text('Login', style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Colors.green),
                              onPressed: () {
                                context.read<AuthBloc>().add(SignUpEvent(
                                  email: emailController.text,
                                  password: passwordController.text,));
                              },
                              child: const Text('Sign Up', style: TextStyle(color: Colors.black),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}