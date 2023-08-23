import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey_flutter/model/api_token.dart';
import 'package:survey_flutter/storage/secure_storage.dart';

import '../di/provider/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((_) {
  return SecureStorageImpl(FlutterSecureStorageProvider().getStorage());
});

class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage _storage;
  SecureStorageImpl(this._storage);

  @override
  Future<M> getValue<M extends SecureStorageModel>(
      {required SecureStorageKey key}) async {
    final rawValue = await _storage.read(key: key.string);
    if (rawValue == null) {
      throw SecureStorageError.failToGetValue;
    }
    final jsonValue = await jsonDecode(rawValue);

    if (M == ApiToken) {
      return ApiToken.fromJson(jsonValue) as M;
    } else {
      throw ArgumentError('Invalid SecureStorageModel type');
    }
  }

  @override
  Future<void> save<M extends SecureStorageModel>(
      {required M value, required SecureStorageKey key}) async {
    final encodedValue = jsonEncode(value);
    await _storage.write(key: key.string, value: encodedValue);
  }
}
