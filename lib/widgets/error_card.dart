import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb4yg/widgets/expanded_section.dart';

class ErrorCard extends StatefulWidget {
  final String title;
  final String body;
  final String? message;

  const ErrorCard(
      {Key? key,
      this.message,
      this.title = 'Error',
      this.body = 'An unexpected error occurred while processing your request.'
          '\nPlease try again later.'})
      : super(key: key);

  @override
  State<ErrorCard> createState() => _ErrorCardState();
}

class _ErrorCardState extends State<ErrorCard> {
  bool _viewMessage = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              dense: false,
              visualDensity: VisualDensity.comfortable,
              leading: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.error, color: Colors.red, size: 30),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(widget.title),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.body),
                  if (widget.message != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () =>
                                setState(() => _viewMessage = !_viewMessage),
                            child: Text(
                                '${_viewMessage ? 'Hide' : 'View'} Details')),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ExpandedSection(
                            expand: _viewMessage,
                            child: SelectableText(widget.message!),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
