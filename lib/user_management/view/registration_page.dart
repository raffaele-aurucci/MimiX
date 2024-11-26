import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/view/widget/form.dart';
import 'package:mimix_app/user_management/view/widget/input_field.dart';
import 'package:mimix_app/utils/view/widgets/buttons/primary_button.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                        child: Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const HeaderText(text: 'Hello Beautiful', size: 20),
                              const HeaderText(text: 'User Profile', size: HeaderText.H3),
                              const SizedBox(height: 30),
                              Image.asset('assets/images/welcome.png'),
                              const FormWidget(),
                            ],
                )
              )
            )
          )
        )
    ));
  }
}