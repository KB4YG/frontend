import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.wifi_off, color: Colors.red, size: 80),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: SelectableText(
            'Failed to retrieve map data.\n'
            'Check your internet connection and try again.',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
