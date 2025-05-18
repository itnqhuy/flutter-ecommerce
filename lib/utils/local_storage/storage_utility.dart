import 'package:get_storage/get_storage.dart';

class MyLocalStorage {
  static MyLocalStorage? _instance;
  late final GetStorage _storage;

  factory MyLocalStorage.instance() {
    if (_instance == null) {
      throw Exception(
          'MyLocalStorage not initialized. Call MyLocalStorage.init() first.');
    }
    return _instance!;
  }

  MyLocalStorage._internal(this._storage);

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    final storage = GetStorage(bucketName);
    _instance = MyLocalStorage._internal(storage);
  }

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
