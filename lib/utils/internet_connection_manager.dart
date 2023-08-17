import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class InternetConnectionManager {
  Future<bool> hasConnection();
}

final internetConnectionManagerProvider =
    Provider<InternetConnectionManager>((_) {
  return InternetConnectionManagerImpl();
});

class InternetConnectionManagerImpl extends InternetConnectionManager {
  final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker();

  @override
  Future<bool> hasConnection() async =>
      _internetConnectionChecker.hasConnection;
}
