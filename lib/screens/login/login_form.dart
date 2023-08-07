import 'package:flutter/material.dart';
import 'package:survey_flutter/screens/widgets/primary_button_style.dart';
import 'package:survey_flutter/screens/widgets/primary_text_field_decoration.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextTheme get _textTheme => Theme.of(context).textTheme;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: PrimaryTextFieldDecoration(
          hintText: 'Email',
          hintTextStyle: _textTheme.bodyMedium,
        ),
        style: _textTheme.bodyMedium,
      );

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: PrimaryTextFieldDecoration(
          hintText: 'Password',
          hintTextStyle: _textTheme.bodyMedium,
        ),
        style: _textTheme.bodyMedium,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: PrimaryButtonStyle(hintTextStyle: _textTheme.labelMedium),
        onPressed: _submit,
        child: const Text('Log in'),
      );

  void _submit() {
    // TODO: Integrate with API
  }

  @override
  Widget build(BuildContext context) {
    const fieldSpacing = 20.0;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField,
          const SizedBox(
            height: fieldSpacing,
          ),
          _passwordTextField,
          const SizedBox(
            height: fieldSpacing,
          ),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: _loginButton,
          ),
        ],
      ),
    );
  }
}
