import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/Presentation/UIScreens/HomepageScreen.dart';
import 'Bloc/InternetBloc.dart';
import 'dart:async';
import 'NetworkRepo/NetworkRepo.dart';

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<ConnectionBloc>(
          create: (context)=>ConnectionBloc(),
          child: Homepage()),
    );
  }
}
