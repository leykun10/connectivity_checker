
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Presentation/UIParts/SoundPlayer.dart';
import 'package:screen/screen.dart';
import 'AnimatedNotifier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/Bloc/InternetState.dart';
import 'package:flutter_app/Bloc/InternetBloc.dart';
import 'package:flutter_app/Bloc/InternetEvent.dart';
class HomeUi extends StatefulWidget {
  final InternetState state;
  HomeUi(this.state);
  @override
  _HomeUiState createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {



  Widget displayWidget(connectionState state){

    return Container
      (child: state==connectionState.poor?
        Container(child: AnimatedNotifier(widget.state),
        )
        :Column(children: [
      SizedBox(height: 50,),

      AnimatedNotifier(widget.state),

      if(state==connectionState.offline)SoundPlayer()],),);
  }

  Widget mapStateToWidgetProperties(InternetState state){
    if(state is LoadingState){
      return Center(child: CircularProgressIndicator(),);
    }
    if(state is InitialInternetState){
      return Column(
        children: [
          SizedBox(height: 200,),
          Center(child: CircularProgressIndicator(),),
          SizedBox(height: 50,),
           Center(child: FlatButton(color: Colors.white,child: Text('start',style: TextStyle(fontSize: 25,color: Colors.black26),),
          onPressed: (){
            BlocProvider.of<ConnectionBloc>(context).add(CheckEvent());
          },),),
          SizedBox(height: 20,),
          Center(child: FlatButton(color: Colors.white,child: Text('exit app',style: TextStyle(fontSize: 25,color: Colors.black26),),
            onPressed: (){
                      SystemNavigator.pop(animated: true);
            },),)
        ],
      );
    }
    else if(state is OnlineInternetState){
      return displayWidget(state.online);
    }
    else if(state is OfflineInternetState){
      return displayWidget(state.offline);
    }
    else if(state is PoorConnectionState){
      return displayWidget(state.poor);
    }
    return null;
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Screen.keepOn(true);
  }
  @override
  Widget build(BuildContext context) {
    return mapStateToWidgetProperties(widget.state);
  }
}
