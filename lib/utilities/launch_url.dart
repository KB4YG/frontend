import 'package:url_launcher/url_launcher.dart';

// Wrapper for launching url, could add some error handling here?
void launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
