import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isLogoVisible = false;
  bool _shouldStartAnimate = false;

  @override
  void initState() {
    super.initState();
    _delayedLogoVisibility();
  }

  void _delayedLogoVisibility() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLogoVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.images.splashBackground.path,
              fit: BoxFit.cover,
            ),
            _buildAnimatedLogo(constraints),
          ],
        );
      }),
    );
  }

  Widget _buildAnimatedLogo(BoxConstraints constraints) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      top: _shouldStartAnimate ? 153.0 : constraints.maxHeight / 2.0,
      child: AnimatedOpacity(
        opacity: _isLogoVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Image.asset(
          Assets.images.splashLogoWhite.path,
        ),
        onEnd: () {
          setState(() {
            _shouldStartAnimate = true;
          });
        },
      ),
    );
  }
}
