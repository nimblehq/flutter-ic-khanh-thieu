enum AppRoute {
  splash,
  login,
  home,
  survey,
  questions,
}

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.login:
        return '/login';
      case AppRoute.home:
        return '/home';
      case AppRoute.survey:
        return '/survey';
      case AppRoute.questions:
        return '/questions';
    }
  }
}
