
import 'package:credit_card_1/regbloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'log_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider( // Use MultiBlocProvider for multiple BLoCs
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc()..add(InitialLoginBloc()),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc()..add(InitialRegisterBloc()),
          ),
          // Add more BlocProvider widgets for additional BLoCs if needed
        ],
        child: Login(),
      ),
    );
  }
}
