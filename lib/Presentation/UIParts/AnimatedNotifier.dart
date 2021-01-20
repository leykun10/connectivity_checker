import 'package:flutter/material.dart';
import 'package:flutter_app/Bloc/InternetState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/Bloc/InternetBloc.dart';
import 'package:flutter_app/Bloc/InternetEvent.dart';
class AnimatedNotifier extends StatefulWidget {
  final InternetState state;
  AnimatedNotifier(this.state);
  @override
  _AnimatedNotifierState createState() => _AnimatedNotifierState();
}

class _AnimatedNotifierState extends State<AnimatedNotifier>  with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Color uiColor=Colors.green;
  String title;
  bool iconChange;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =AnimationController(duration: Duration(milliseconds: 350),vsync: this);
  }

  void mapStateToUi(InternetState state){
    if(state is OnlineInternetState){
      iconChange =false;
      uiColor =Colors.green;
      _animationController.stop();
      title='online';
    }
    else if(state is InitialInternetState){
      uiColor =Colors.green;
    }
    else if(state is OfflineInternetState){
      animate();
      uiColor =Colors.red;
      title='offline';

    }
    else if(state is PoorConnectionState){
      animate();
      uiColor=Colors.blue;
      title='poor connection';
    }
  }
  void animate() async{
    _animationController.repeat(reverse: true);
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    mapStateToUi(widget.state);
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (widget,child)=>Transform.rotate(child: child,
          angle: _animationController.value,
          ),
          child: Center(child: Icon(Icons.add_alert,size: 100,color: uiColor,)),
        ),
        SizedBox(height: 50,),
        Center(child:Text(title,style: TextStyle(fontSize: 30,color: uiColor),)
        ),
        SizedBox(height: 30,),
        Container(
          color: Colors.blueGrey,
          child: FlatButton(child: Text('exit',style: TextStyle(color: Colors.white,fontSize: 20),),onPressed: (){
            BlocProvider.of<ConnectionBloc>(context).add(StopCheck());
          },),
        )
      ],
    );
  }
}
