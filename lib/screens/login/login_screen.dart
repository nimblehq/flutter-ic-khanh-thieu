import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/login/login_form.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/keyboard_manager.dart';

const routePathLoginScreen = '/login';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginSrceenState();
}

class _LoginSrceenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _animationDuration = const Duration(milliseconds: 600);

  // - Animation

  late final AnimationController _logoAnimationController = AnimationController(
    duration: _animationDuration,
    vsync: this,
  )..forward();

  late final AnimationController _formAnimationController = AnimationController(
    duration: _animationDuration,
    vsync: this,
  )..forward();

  late final Animation<double> _logoScaleAnimation = Tween(
    begin: 1.0,
    end: 0.8,
  ).animate(CurvedAnimation(
    parent: _logoAnimationController,
    curve: Curves.easeIn,
  ));

  late final Animation<Offset> _logoOffetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.3),
  ).animate(
    CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeIn,
    ),
  );

  late final Animation<double> _opacityAnimation = CurvedAnimation(
    parent: _formAnimationController,
    curve: Curves.easeIn,
  );

  // - Widgets

  late final _background = TweenAnimationBuilder(
    tween: Tween<double>(begin: 0, end: 25),
    duration: _animationDuration,
    curve: Curves.easeIn,
    builder: (_, value, __) {
      return ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: value,
          sigmaY: value,
        ),
        child: Image.asset(
          Assets.images.splashBackground.path,
          fit: BoxFit.cover,
        ),
      );
    },
  );

  late final _gradientOverlay = FadeTransition(
    opacity: _opacityAnimation,
    child: Container(
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
    ),
  );

  late final _logo = SlideTransition(
    position: _logoOffetAnimation,
    child: ScaleTransition(
      scale: _logoScaleAnimation,
      child: Image.asset(
        Assets.images.splashLogoWhite.path,
      ),
    ),
  );

  late final _loginForm = FadeTransition(
    opacity: _opacityAnimation,
    child: const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Metrics.defaultHorizontalPadding,
      ),
      child: LoginForm(),
    ),
  );

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }

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
            _background,
            _gradientOverlay,
            _logo,
            _loginForm,
          ],
        ),
      ),
    );
  }
}
