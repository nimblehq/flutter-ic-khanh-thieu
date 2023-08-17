enum SecureStorageKey {
  apiToken,
}

extension SecureStorageKeyExt on SecureStorageKey {
  String get string {
    switch (this) {
      case SecureStorageKey.apiToken:
        return 'API_TOKEN_KEY';
    }
  }
}

abstract class SecureStorageModel {}

enum SecureStorageError {
  failToRead,
  failToParse,
}

abstract class SecureStorage {
  Future<void> save<M extends SecureStorageModel>(
      {required M value, required SecureStorageKey key});
  Future<M> get<M extends SecureStorageModel>(
      {required String value, required SecureStorageKey key});
}
