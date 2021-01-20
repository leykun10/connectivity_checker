import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';

class HostValueObject extends Equatable{
 final String hostIP;
 final int port;
 final Duration timeout;


  HostValueObject({this.hostIP, this.port, this.timeout});

  @override
  // TODO: implement props
  List<Object> get props => [hostIP,port,timeout];
}
enum ConnectionStatus {Connected,Disconnected,PoorConnection}
class NetworkRepo {

  NetworkRepo(){
    _statusController=StreamController.broadcast(onListen: checkConnectionStatus,);
  }

  void cancel(){
    trial=0;
    _timer.cancel();
  }



  Socket s;
  Timer _timer;
  StreamController<ConnectionStatus> _statusController;



  Future<ConnectionStatus> checkHost(HostValueObject hostValueObject) async {
    try {
      s = await Socket.connect (hostValueObject.hostIP, hostValueObject.port,
          timeout: hostValueObject.timeout);
      s?.close();
      print('were here ${hostValueObject.hostIP}');
      return ConnectionStatus.Connected;
    }  catch(error) {
      s?.close();
      print('wassssss here ${hostValueObject.hostIP}');
      return ConnectionStatus.Disconnected;
    }
  }

  Stream<ConnectionStatus> get streamedStatus=>_statusController.stream;

  void checkConnectionStatus() async{
    print('i should be called');
      ConnectionStatus status= await hasConnection(addresses);
      _statusController.add(status);

    _timer=Timer.periodic(Duration(seconds: 5), (timer) async{
      if(_statusController.hasListener && !_statusController.isClosed){
        ConnectionStatus status= await hasConnection(addresses);
        _statusController.add(status);
      }



    });

  }



    List<HostValueObject> addresses=[HostValueObject(hostIP: '213.55.96.148',port: 53, timeout: Duration(seconds: 4)),
      HostValueObject(hostIP: '213.55.96.166',port: 53, timeout: Duration(seconds: 4)),
      HostValueObject(hostIP: '197.156.74.223',port: 53, timeout: Duration(seconds: 4)),
      HostValueObject(hostIP: '8.8.8.8',port: 53, timeout: Duration(seconds: 4)) ];

    int trial=0;
    Future<ConnectionStatus> hasConnection(List<HostValueObject> hostValueObjects) async{
      List<Future<ConnectionStatus>> requests=[];
      for(HostValueObject hostValueObject in hostValueObjects){

         requests.add(checkHost(hostValueObject));
        }
      print(DateTime.now());
    List<ConnectionStatus> status=await Future.wait(requests);
    print(DateTime.now());
       if(status.contains(ConnectionStatus.Connected)) {
         trial=0;
         return ConnectionStatus.Connected;
       }

       else {
         trial+=1;
         if(trial>=5){

           return ConnectionStatus.Disconnected;
         }
         return ConnectionStatus.PoorConnection;}

      }





      
    }




    
