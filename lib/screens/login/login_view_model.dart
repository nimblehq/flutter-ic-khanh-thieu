import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, void>((_) {
  return LoginViewModel();
});

class LoginViewModel extends StateNotifier<void> {
  LoginViewModel() : super([]);

  bool isValidEmail(String? email) {
    // Just use a simple rule, no fancy Regex!
    return !(email == null || !email.contains('@'));
  }

  bool isValidPassword(String? password) {
    return !(password == null || password.length < 8);
  }
}
