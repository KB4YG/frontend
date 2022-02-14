import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  // TODO: add error handling
  if (!await launch(url)) throw 'Could not launch $url';
}