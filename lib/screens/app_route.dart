enum AppRoute {
  splash,
  login,
  home,
  survey,
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
    }
  }
}
