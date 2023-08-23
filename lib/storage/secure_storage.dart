import 'package:survey_flutter/utils/serializer/serializable.dart';

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

enum SecureStorageError {
  failToGetValue,
}

abstract class SecureStorage {
  Future<void> save<M extends Serializable>(
      {required M value, required SecureStorageKey key});
  Future<M> getValue<M extends Serializable>(
      {required SecureStorageKey key, required Serializer<M> serializer});
}
