import 'package:get_storage/get_storage.dart';

class MyLocalStorage {
  // Singleton instance
  static final MyLocalStorage _instance = MyLocalStorage._internal();

  // Factory constructor to return the same instance
  factory MyLocalStorage() => _instance;

  // Private constructor
  MyLocalStorage._internal();

  // GetStorage instance
  final _storage = GetStorage();

  /// Save data (generic)
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Read data (generic)
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Remove specific data by key
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
