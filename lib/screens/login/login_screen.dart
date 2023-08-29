import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/app_route.dart';
import 'package:survey_flutter/screens/login/login_form.dart';
import 'package:survey_flutter/screens/login/login_view_model.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/uimodels/app_error.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';
import 'package:survey_flutter/widgets/alert_dialog.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
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
      child: Assets.images.splashLogoWhite.image(),
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

  _setUpListener(BuildContext context) {
    ref.listen<AsyncValue<void>>(loginViewModelProvider, (_, next) {
      next.maybeWhen(
        data: (_) => context.go(AppRoute.home.path),
        error: (error, _) {
          showAlertDialog(
            context: context,
            title: context.localizations.loginFailAlertTitle,
            message: (error as AppError?)?.description(context) ?? '',
            actions: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text(context.localizations.okText),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        },
        orElse: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _setUpListener(context);
    return GestureDetector(
      onTap: () => context.dismissKeyboard(),
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

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }
}
