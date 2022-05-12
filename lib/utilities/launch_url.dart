import 'package:url_launcher/url_launcher.dart';

// Wrapper for launching url, could add some error handling here?
void launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
