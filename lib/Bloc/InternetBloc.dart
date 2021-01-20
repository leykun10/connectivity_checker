import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'InternetEvent.dart';
import 'InternetState.dart';
import '../NetworkRepo/NetworkRepo.dart';
class ConnectionBloc extends Bloc<InternetEvent, InternetState> {
  ConnectionBloc() : super(InitialInternetState());

  StreamSubscription<ConnectionStatus> connectivityListener;
  NetworkRepo _dataConnectionChecker = NetworkRepo();
  Stream<InternetState> mapCheckInternetStateToState(
      InternetEvent isOnlineEvent) async*{
    yield LoadingState();
    connectivityListener?.cancel();
    print('came here');
    connectivityListener = _dataConnectionChecker.streamedStatus.listen((event) async {
      if (event == ConnectionStatus.Connected) {
        print(event.toString());
        return add(IsOnlineEvent(connectionState.online));
      } else if (event ==  ConnectionStatus.Disconnected) {
        print(event.toString());
        return add(IsOfflineEvent(connectionState.offline));
      }
      else if(event == ConnectionStatus.PoorConnection){
        return add(IsPoorConnectionEvent(connectionState.poor));
      }
    });
  }

  @override
  Stream<InternetState> mapEventToState(InternetEvent event) async* {
    if (event is CheckEvent) {
      print('was here check');
      yield* mapCheckInternetStateToState(event);
    } else if (event is IsOnlineEvent) {

      yield OnlineInternetState(connectionState.online);
    } else if (event is IsOfflineEvent) {
      yield OfflineInternetState(connectionState.offline);
    }
    else if(event is IsPoorConnectionEvent){
      yield PoorConnectionState(connectionState.poor);
    }
    else if(event is StopCheck){

      _dataConnectionChecker.cancel();

      yield InitialInternetState();
    }
  }
}
