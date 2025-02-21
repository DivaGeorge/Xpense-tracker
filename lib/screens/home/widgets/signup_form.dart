import 'package:flutter/material.dart';

class SignupFrom extends StatefulWidget {
  const SignupFrom({super.key});

  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('First Name', false),
        buildInputForm('Last Name', false),
        buildInputForm('Email', false),
        buildInputForm('Phone No', false),
        buildInputForm('Password', true),
        buildInputForm('Confirm Password', true),
      ],
    );
  }

  Padding buildInputForm(String hint, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            border: const OutlineInputBorder(),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure ? const Icon(Icons.visibility_off) :const Icon(Icons.visibility),
                  )
                : null
                ),
      ),
    );
  }
}
