import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/storage/secure_storage.dart';

import '../di/provider/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((_) {
  return SecureStorageImpl(FlutterSecureStorageProvider().getStorage());
});

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage _storage;
  SecureStorageImpl(this._storage);

  @override
  Future<M> get<M extends SecureStorageModel>(
      {required String value, required SecureStorageKey key}) async {
    final rawValue = await _storage.read(key: key.string);
    if (rawValue == null) {
      throw SecureStorageError.failToRead;
    }

    final decodedValue = await jsonDecode(rawValue);
    if (decodedValue == null) {
      throw SecureStorageError.failToParse;
    }

    return decodedValue;
  }

  @override
  Future<void> save<M extends SecureStorageModel>(
      {required M value, required SecureStorageKey key}) async {
    final encodedValue = jsonEncode(value);
    await _storage.write(key: key.string, value: encodedValue);
  }
}
