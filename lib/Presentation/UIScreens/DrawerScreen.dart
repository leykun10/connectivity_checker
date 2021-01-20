import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(
        color: Colors.black38,
        child: Column(children: [SizedBox(height: 200,),
    ],),
      ),);
  }
}
