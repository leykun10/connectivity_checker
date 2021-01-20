import 'package:flutter/material.dart';
import 'package:flutter_app/Bloc/InternetBloc.dart';
import 'package:flutter_app/Bloc/InternetState.dart';
import 'package:flutter_app/Presentation/UIParts/HomeComponent.dart';
import 'DrawerScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('demo'),),
    drawer: DrawerPage(),
    backgroundColor: Colors.black,
    body: BlocBuilder<ConnectionBloc,InternetState>(
      builder: (BuildContext context,InternetState state){

        return HomeUi(state);
      }
    ),
    );
  }
}
