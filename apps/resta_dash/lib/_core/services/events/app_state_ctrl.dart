import 'package:resta_dash/main.export.dart';

final eventCtrlProvider = NotifierProvider<EventCtrlNotifier, AppState>(EventCtrlNotifier.new);

class EventCtrlNotifier extends Notifier<AppState> {
  FVoid updateWithCode(String? code) async {
    final status = AppState.fromCode(code);
    await update(status);
  }

  FVoid update(AppState? status) async {
    cat('AppState updated: $state -> $status', 'AppStateCtrl');
    if (status == null) return;
    if (status == state) return;
    state = status;
    cat('AppState updated: $state', 'AppStateCtrl');
    // await ref.read(homeDataCtrlProvider.notifier).refresh(false);
  }

  Future<void> retry() async {
    // await ref.read(guestConfigCtrlProvider.notifier).refresh();
  }

  FVoid forceActivate() => update(AppState.active);

  @override
  AppState build() {
    const AppState status = AppState.active;
    return status;
  }
}

enum AppState {
  active,
  noKyc,
  businessUnavailable,
  noSubscription,
  featureUnavailability;

  String? get path => switch (this) {
    AppState.active => null,
    AppState.noKyc => RPaths.needKycVerification.path,
    AppState.businessUnavailable => RPaths.needKycVerification.path,
    AppState.noSubscription => RPaths.needSubscription.path,
    AppState.featureUnavailability => RPaths.featureUnavailable.path,
  };

  factory AppState.fromCode(String? code) => switch (code) {
    'unverified_kyc' => AppState.noKyc,
    'unavailable_business' => AppState.businessUnavailable,
    'no_subscription' => AppState.noSubscription,
    'feature_unavailability' => AppState.featureUnavailability,
    _ => AppState.active,
  };

  bool get isActive => this == AppState.active;
  bool get isNoKyc => this == AppState.noKyc;
  bool get isBusinessUnavailable => this == AppState.businessUnavailable;
  bool get isNoSubscription => this == AppState.noSubscription;
  bool get isFeatureUnavailability => this == AppState.featureUnavailability;
}
