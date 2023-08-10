import 'package:flutter/material.dart';
import 'package:survey_flutter/screens/widgets/primary_button_style.dart';
import 'package:survey_flutter/screens/widgets/primary_text_field_decoration.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _fieldSpacing = 20.0;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: PrimaryTextFieldDecoration(
          hintText: context.localizations?.emailInputHint,
          hintTextStyle: context.textTheme.bodyMedium,
        ),
        style: context.textTheme.bodyMedium,
      );

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: PrimaryTextFieldDecoration(
          hintText: context.localizations?.passwordInputHint,
          hintTextStyle: context.textTheme.bodyMedium,
        ),
        style: context.textTheme.bodyMedium,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: PrimaryButtonStyle(hintTextStyle: context.textTheme.labelMedium),
        onPressed: _submit,
        child: Text(context.localizations?.loginButton ?? ''),
      );

  void _submit() {
    KeyboardManager.dismiss(context);
    // TODO: Integrate with API
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailTextField,
          SizedBox(
            height: _fieldSpacing,
          ),
          _passwordTextField,
          SizedBox(
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
