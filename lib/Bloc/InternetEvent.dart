import 'package:flutter_app/Bloc/InternetState.dart';

abstract class InternetEvent{
 connectionState state;
  InternetEvent(this.state);
}
class IsOnlineEvent extends InternetEvent{

  IsOnlineEvent(state):super(state);
}
class IsOfflineEvent extends InternetEvent{
  IsOfflineEvent(state):super(state);
}
class CheckEvent extends InternetEvent{
  CheckEvent():super(null);
}
class IsPoorConnectionEvent extends InternetEvent{
  IsPoorConnectionEvent(state):super(state);
}
class StopCheck extends InternetEvent{
  StopCheck():super(null);
}