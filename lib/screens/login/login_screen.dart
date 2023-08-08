import 'package:flutter/material.dart';
import 'package:survey_flutter/screens/login/login_form.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';

const routePathLoginScreen = '/login';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginSrceenState();
}

class _LoginSrceenState extends State<LoginScreen> {
  late final _gradientOverlay = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.2),
          Colors.black,
        ],
      ),
    ),
  );

  late final _loginForm = const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Metrics.defaultHorizontalPadding,
    ),
    child: LoginForm(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardManager.dismiss(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            _gradientOverlay,
            _loginForm,
          ],
        ),
      ),
    );
  }
}
