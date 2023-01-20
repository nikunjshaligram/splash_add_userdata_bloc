import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_add_userdata_bloc/bloc/adduser/adduser_bloc.dart';
import 'package:splash_add_userdata_bloc/bloc/splash/splash_bloc.dart';
import 'package:splash_add_userdata_bloc/bloc/validation/validation_bloc.dart';
import 'package:splash_add_userdata_bloc/presentation/screens/splash_screen.dart';

void main() {
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
          create: (context) => SplashBloc()..add(SetSplash()),
        ),
        BlocProvider(
          create: (context) => AdduserBloc(),
        ),
        BlocProvider(
          create: (context) => ValidationBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
