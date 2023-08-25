import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_screen.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';
import 'package:survey_flutter/screens/splash/splash_view_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _logoOpacity = 0;
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _delayedLogoVisibility();
  }

  void _delayedLogoVisibility() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _logoOpacity = 1);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<bool>>(splashViewModelProvider, (_, next) {
      next.whenData((result) => _isLoggedIn = result);
    });
    return Scaffold(
      body: LayoutBuilder(builder: (_, __) {
        return Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.images.splashBackground.path,
              fit: BoxFit.cover,
            ),
            _buildAnimatedLogo(),
          ],
        );
      }),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedOpacity(
      opacity: _logoOpacity,
      duration: const Duration(seconds: 1),
      child: Assets.images.splashLogoWhite.image(),
      onEnd: () {
        if (_isLoggedIn == true) {
          context.go(routePathHomeScreen);
        } else {
          context.go(routePathLoginScreen);
        }
      },
    );
  }
}
