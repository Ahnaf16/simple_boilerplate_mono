import 'package:resta_dash/routes/logic/app_route.dart';

export 'package:go_router/go_router.dart';

class RPaths {
  const RPaths._();

  static const underMaintenance = RPath('/under-maintenance');
  static const needKycVerification = RPath('/kyc-verification');
  static const needSubscription = RPath('/no-subscription');
  static const featureUnavailable = RPath('/feature-unavailability');

  // auth
  static const login = RPath('/login');
  static final signUp = login + const RPath('/sign-up');

  // onboarding
  static const onboarding = RPath('/onboarding');

  // home
  static const home = RPath('/home');
  static const profile = RPath('/profile');
  static RPath itemDetails(dynamic id) => RPath('/item/$id');

  static RPath cartSummary = const RPath('/order-summary');

  // profile
  static const settings = RPath('/settings');
  static const language = RPath('/language');
}
