import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_1/presentations/auth/auth.dart';
import 'package:credit_card_1/presentations/auth/bloc/auth_bloc.dart';
import 'package:credit_card_1/presentations/home/bloc/card_bloc.dart';
import 'package:credit_card_1/presentations/home/data/repository/user_card_repository.dart';
import 'package:credit_card_1/presentations/home/get_cards/get_cards.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CardBloc(cardsRepository: UserCardsRepository(
                firestore: FirebaseFirestore.instance,
              ),),
        ),
        BlocProvider(
          create: (context) =>
              GetCardsCubit(
                cardsRepository: UserCardsRepository(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AuthPage(),
        ),
      ),
    );
  }
}