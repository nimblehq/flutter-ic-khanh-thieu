import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, void>((_) {
  return LoginViewModel();
});

class LoginViewModel extends StateNotifier<void> {
  LoginViewModel() : super([]);

  bool validateEmail(String? email) {
    // Just use a simple rule, no fancy Regex!
    return !(email == null || email.isEmpty || !email.contains('@'));
  }

  bool validatePassword(String? password) {
    return !(password == null || password.isEmpty || password.length < 8);
  }
}
