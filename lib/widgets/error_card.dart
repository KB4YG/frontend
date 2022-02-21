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
      child: Card(
        elevation: 4,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 150),
          child: ListTile(
              // tileColor: Colors.orangeAccent,
              dense: false,
              visualDensity: VisualDensity.comfortable,
              leading: const SizedBox(
                height: double.infinity,
                child: Icon(Icons.error, color: Colors.red, size: 30),
              ),
              title: Text(widget.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.body),
                  ),
                  if (widget.message != null)
                    TextButton(
                        onPressed: () => setState(() {
                              _viewMessage = !_viewMessage;
                            }),
                        child: Text(
                          '${_viewMessage ? 'Hide' : 'View'} Details',
                        )),
                  if (widget.message != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ExpandedSection(
                          expand: _viewMessage,
                          child: Text('Error Message: "${widget.message}"')),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
