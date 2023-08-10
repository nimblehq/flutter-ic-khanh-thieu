import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoOpacity = 0;

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
        context.go(routePathLoginScreen);
      },
    );
  }
}
