import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/theme/primary_button_style.dart';
import 'package:survey_flutter/theme/primary_text_field_decoration.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _fieldSpacing = 20.0;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormSubmitted = false;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: PrimaryTextFieldDecoration(
          hintText: context.localizations?.emailInputHint,
          hintTextStyle: context.textTheme.bodyMedium,
        ),
        style: context.textTheme.bodyMedium,
        validator: _validateEmail,
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: PrimaryTextFieldDecoration(
          hintText: context.localizations?.passwordInputHint,
          hintTextStyle: context.textTheme.bodyMedium,
        ),
        style: context.textTheme.bodyMedium,
        validator: _validatePassword,
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: PrimaryButtonStyle(hintTextStyle: context.textTheme.labelMedium),
        onPressed: _submit,
        child: Text(context.localizations?.loginButton ?? ''),
      );

  String? _validateEmail(String? email) {
    // Just use a simple rule, no fancy Regex!
    if (email == null || email.isEmpty || !email.contains('@')) {
      return context.localizations?.invalidEmailError;
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty || password.length < 8) {
      return context.localizations?.invalidPasswordError;
    }
    return null;
  }

  void _submit() {
    setState(() => _isFormSubmitted = true);
    if (_formKey.currentState?.validate() == true) {
      context.dismissKeyboard();
      // TODO: Integrate with API
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField,
          const SizedBox(
            height: _fieldSpacing,
          ),
          _passwordTextField,
          const SizedBox(
            height: _fieldSpacing,
          ),
          SizedBox(
            height: Metrics.formFieldHeight,
            width: double.infinity,
            child: _loginButton,
          ),
        ],
      ),
    );
  }
}
