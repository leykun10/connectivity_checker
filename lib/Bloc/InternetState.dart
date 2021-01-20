enum connectionState{
   offline,online,poor
}
abstract class InternetState{
}

class InitialInternetState extends InternetState{}

class LoadingState extends InternetState{}

class OnlineInternetState extends InternetState{
  final connectionState online;
  OnlineInternetState(this.online):super();
}

class OfflineInternetState extends InternetState{
  final connectionState offline;
  OfflineInternetState(this.offline):super();
}
class PoorConnectionState extends InternetState{
  final connectionState poor;
  PoorConnectionState(this.poor);
}
