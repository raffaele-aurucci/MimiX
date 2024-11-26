import 'package:flutter/material.dart';

class InputField extends StatefulWidget {

  final String label;

  const InputField({super.key, required this.label});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField>{

  final FocusNode _focusNode = FocusNode();
  bool _selectField = false;

  final TextEditingController _controller = TextEditingController(); // Aggiungi il controller
  bool _isTextFilled = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _selectField = true;
        });
      } else {
        setState(() {
          _selectField = false;
        });
      }
    });

    _controller.addListener(() {
      setState(() {
        _isTextFilled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: _focusNode,
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _selectField ? const Color(0xFF003659)
                  : _isTextFilled ? const Color(0xFF003659)
                  : const Color(0xFF97CADB),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _isTextFilled ? const Color(0xFF003659) : const Color(0xFF97CADB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF003659)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _selectField ? const Color(0xFF003659)
                : _isTextFilled ? const Color(0xFF003659)
                : const Color(0xFF97CADB),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _selectField ? const Color(0xFF003659) : _isTextFilled ? const Color(0xFF003659) : const Color(0xFF97CADB),
            )),
          errorStyle: const TextStyle(
            color: Color(0xFFEB5858)
          ),
        ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'The field ${widget.label} cannot empty';
        }
        if (value.length < 3) return 'The field ${widget.label} must contain at least 3 characters';
        return null;
      }
    );
  }
}