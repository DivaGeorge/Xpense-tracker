import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  // const CheckBox({super.key});
  final String text;
  const CheckBox(this.text, {super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child: Container(
            width: 20,
                
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black45),
            ),
            child:_isSelected ? const Icon(Icons.check,size: 15,color: Colors.green,): null,
          ),
        ),
        const SizedBox(width: 12),
        Text(widget.text),
      ],
    );
  }
}
