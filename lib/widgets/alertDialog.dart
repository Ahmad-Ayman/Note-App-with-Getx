import 'package:flutter/material.dart';

class AlertDialoooog extends StatelessWidget {
  final String? contentText;
  final Function confirmFunction;
  final Function declineFunction;

  AlertDialoooog({this.contentText, required this.confirmFunction, required this.declineFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(contentText!),
      actions: [
        TextButton(
          onPressed: () {
            confirmFunction();
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            declineFunction();
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
