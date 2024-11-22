import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl({required String link}) async {

  final Uri url = Uri.parse(link);

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}