import 'package:resta_dash/main.export.dart';

final appStateEventProvider = StreamProvider<AppStateEvent>((ref) async* {
  yield* EvBus.instance.onAppStateEvent();
});
final loggedOutEvProvider = StreamProvider<LoggedOutEv>((ref) async* {
  yield* EvBus.instance.onLogoutEv();
});
