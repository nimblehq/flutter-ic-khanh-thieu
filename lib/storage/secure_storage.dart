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
  failToGetValue,
}

abstract class SecureStorage {
  Future<void> save<M extends SecureStorageModel>(
      {required M value, required SecureStorageKey key});
  Future<M> getValue<M extends SecureStorageModel>(
      {required SecureStorageKey key});
}
