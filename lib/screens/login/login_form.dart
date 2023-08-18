import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/screens/login/login_view_model.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/theme/primary_button_style.dart';
import 'package:survey_flutter/theme/primary_text_field_decoration.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _fieldSpacing = 20.0;
const _loadingIndicatorSize = 28.0;

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isFormSubmitted = false;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: PrimaryTextFieldDecoration(
          hintText: context.localizations.emailInputHint,
          hintTextStyle: context.textTheme.bodyMedium,
        ),
        style: context.textTheme.bodyMedium,
        controller: _emailController,
        validator: _validateEmail,
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  TextFormField get _passwordTextField => TextFormField(
        autocorrect: false,
        obscureText: true,
        decoration: PrimaryTextFieldDecoration(
          hintText: context.localizations.passwordInputHint,
          hintTextStyle: context.textTheme.bodyMedium,
        ),
        style: context.textTheme.bodyMedium,
        controller: _passwordController,
        validator: _validatePassword,
        autovalidateMode: _isFormSubmitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: PrimaryButtonStyle(hintTextStyle: context.textTheme.labelMedium),
        onPressed: _submit,
        child: Consumer(
          builder: (_, widgetRef, __) {
            final loginVievModel = widgetRef.watch(loginViewModelProvider);
            return (loginVievModel.isLoading)
                ? const SizedBox(
                    width: _loadingIndicatorSize,
                    height: _loadingIndicatorSize,
                    child: CircularProgressIndicator(
                      color: Colors.black45,
                    ),
                  )
                : Text(context.localizations.loginButton);
          },
        ),
      );

  String? _validateEmail(String? email) {
    if (!ref.read(loginViewModelProvider.notifier).isValidEmail(email)) {
      return context.localizations.invalidEmailError;
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (!ref.read(loginViewModelProvider.notifier).isValidPassword(password)) {
      return context.localizations.invalidPasswordError;
    }
    return null;
  }

  void _submit() {
    setState(() => _isFormSubmitted = true);
    final isFormValidated = _formKey.currentState?.validate() ?? false;

    if (!isFormValidated) {
      return;
    }

    context.dismissKeyboard();
    ref.read(loginViewModelProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
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
