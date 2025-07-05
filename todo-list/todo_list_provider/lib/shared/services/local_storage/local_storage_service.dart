import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:todo_list_provider/shared/errors/local_storage_exceptions.dart';

class LocalStorageService {
  Future<void> set(String Key, String? data) async {
    const storage = Storage.FlutterSecureStorage();

    try {
      await storage.write(key: Key, value: data);
    } catch (error, st) {
      final errorMessage = "Error storing data: $data with key: $Key";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(errorMessage);
    }
  }

  Future<String?> get(String Key) async {
    const storage = Storage.FlutterSecureStorage();

    try {
      return await storage.read(key: Key);
    } catch (error, st) {
      final errorMessage = "Error reading key: $Key";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(errorMessage);
    }
  }

  Future<void> ClearStorage(String Key) async {
    const storage = Storage.FlutterSecureStorage();

    try {
      return await storage.deleteAll();
    } catch (error, st) {
      const errorMessage = "Error clearing storage";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(errorMessage);
    }
  }
}
