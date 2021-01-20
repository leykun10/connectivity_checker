import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundPlayer extends StatefulWidget {
  @override
  _SoundPlayerState createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  AudioCache audioPlayer;
  AudioPlayer _audioPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer=AudioCache(prefix:'assets/Music/');
    play();
  }
  void play() async{
  _audioPlayer=  await audioPlayer.play('Alarm-Fast-A1-www.fesliyanstudios.com.mp3').timeout(Duration(seconds: 4));
  }
  void stop(){
  _audioPlayer.stop();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.clear('Alarm-Fast-A1-www.fesliyanstudios.com.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: FlatButton(color: Colors.blueGrey,child: Text('stop',style: TextStyle(color: Colors.white,fontSize: 25),),onPressed: (){
      stop();
    },),);
  }
}

