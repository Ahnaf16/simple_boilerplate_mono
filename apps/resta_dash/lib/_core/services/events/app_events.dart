import 'package:equatable/equatable.dart';
import 'package:resta_dash/main.export.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class LoggedOutEv extends AppEvent {
  const LoggedOutEv([this.reason]);

  final String? reason;
}

class AppStateEvent extends AppEvent {
  const AppStateEvent(this.eventKey);

  final String? eventKey;

  AppState? get status => AppState.fromCode(eventKey);
}
