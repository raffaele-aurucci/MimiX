import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/view/widget/input_field.dart';
import 'package:mimix_app/utils/view/widgets/buttons/primary_button.dart';
import 'package:mimix_app/user_management/logic/user_logic.dart';
import 'package:mimix_app/utils/view/widgets/alert_dialog.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool? _isRegistered;

  Future<void> _handleRegistration() async {
    final isRegistered = await registerUser(
      _formKey,
      _usernameController.text,
      _ageController.text,
    );

    // Verify that the widget is still mounted
    if (!mounted) return;

    setState(() {
      _isRegistered = isRegistered;
    });

    if (_isRegistered == false) {
      DialogUtils.showErrorDialog(
      context: context,
      title: "Registration Failed",
      message: "There was an issue registering your account. Please try again.",
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InputField(
          label: "Username",
          keyboardType: TextInputType.text,
          controller: _usernameController,
          validator: validateUsername,
        ),
        // const TextField(),
        const SizedBox(height: 10),
        InputField(
          label: "Age",
          keyboardType: TextInputType.number,
          controller: _ageController,
          validator: validateAge,
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          text: "Confirm",
          onPressed: _handleRegistration
        )
      ])
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}