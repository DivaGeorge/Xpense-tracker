import 'package:flutter/material.dart';

class ResetForm extends StatelessWidget {
  const ResetForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.lightBlueAccent,
          )
        ),
      ),
    );
  }
}