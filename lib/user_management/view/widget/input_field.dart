import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class InputField extends StatefulWidget {

  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final FocusNode focusNode;

  const InputField({super.key, required this.label, required this.keyboardType,
  required this.controller, required this.validator, required this.focusNode});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField>{

  // final FocusNode _focusNode = FocusNode();
  bool _isSelected = false;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        setState(() {
          _isSelected = true;
        });
      } else {
        setState(() {
          _isSelected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _isValid ? PaletteColor.darkBlue : PaletteColor.errorMessage,
            fontWeight: _isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16
          ),
          errorStyle: const TextStyle(color: PaletteColor.errorMessage),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF003659)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: PaletteColor.darkBlue,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: PaletteColor.errorMessage),
            ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: PaletteColor.errorMessage,
              width: 2.0,
            )),
        ),
        validator: (value) {
          String? message = widget.validator(value);
          if (message == null) {
            setState(() {
            _isValid = true;
            });
          }
          else {
            setState(() {
            _isValid = false;
            });
          }
          return message;
      }
    );
  }
}