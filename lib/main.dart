import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/app_route.dart';
import 'package:survey_flutter/screens/home/home_screen.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';
import 'package:survey_flutter/screens/splash/splash_screen.dart';
import 'package:survey_flutter/screens/survey/survey_detail_screen.dart';
import 'package:survey_flutter/screens/survey/survey_screen.dart';
import 'package:survey_flutter/storage/survey_storage.dart';
import 'package:survey_flutter/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await setupHive();
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRoute.splash.path,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        pageBuilder: (_, __) => const NoTransitionPage<void>(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoute.home.path,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoute.survey.path,
        builder: (_, state) => SurveyDetailScreen(
          survey: state.extra as SurveyModel,
        ),
      ),
      GoRoute(
        path: AppRoute.questions.path,
        builder: (_, __) => SurveyScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
