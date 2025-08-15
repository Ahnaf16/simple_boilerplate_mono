import 'package:resta_dash/main.export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class URLHelper {
  const URLHelper._();

  static FVoid url(String url) async {
    if (!url.startsWith(RegExp('(http(s)://.)'))) url = 'https://$url';

    await launchUrlString(url);
    return;
  }

  static FVoid call(String number) async {
    await launchUrl(Uri(scheme: 'tel', path: number));
    return;
  }

  static FVoid whatsApp(String number) async {
    final query = {'phone': number, 'type': 'phone_number', 'app_absent': '0'};
    final uri = Uri(scheme: 'https', host: 'api.whatsapp.com', path: 'send/', queryParameters: query);

    await launchUrl(uri);
    return;
  }

  static FVoid mail(String mail) async {
    if (mail.isValidEmail) {
      await launchUrl(Uri(scheme: 'mailto', path: mail));
    }
    return;
  }

  static FVoid sms(String number, String message) async {
    await launchUrl(
      Uri(scheme: 'sms', path: number, queryParameters: <String, String>{'body': Uri.encodeComponent(message)}),
    );
    return;
  }
}
