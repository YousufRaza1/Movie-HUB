import 'package:flutter/material.dart';
import '../ViewModel/AuthViewModel.dart';

Future<void> displayTextInputDialog(BuildContext context) async {
  String? valueText;
  final TextEditingController _textFieldController = TextEditingController();
  final AuthViewModel = AuthService();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          onChanged: (value) {
            valueText = value;
          },
          controller: _textFieldController,
          decoration: const InputDecoration(
            hintText: "Enter your email where link will be sent",
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            color: Colors.green,
            textColor: Colors.white,
            child: const Text('OK'),
            onPressed: () {
              AuthViewModel.resetPassword(_textFieldController.text.trim(), context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}