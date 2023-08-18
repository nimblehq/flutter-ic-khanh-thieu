import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageProvider {
  FlutterSecureStorage? _storage;

  FlutterSecureStorage getStorage() {
    _storage ??= _createStorage();
    return _storage!;
  }

  FlutterSecureStorage _createStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }
}
