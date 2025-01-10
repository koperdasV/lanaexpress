import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {

  // Метод для отримання інстансу менеджера
  factory SecureStorageManager() {
    return _instance;
  }

  // Приватний конструктор
  SecureStorageManager._internal();
  // Ініціалізація singleton об'єкта
  static final SecureStorageManager _instance = SecureStorageManager._internal();

  // Ініціалізація FlutterSecureStorage
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Метод для зберігання даних
  Future<void> writeData(final String key, final String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Метод для отримання даних
  Future<String?> readData(final String key) async {
    return await _secureStorage.read(key: key);
  }

  // Метод для видалення даних
  Future<void> deleteData(final String key) async {
    await _secureStorage.delete(key: key);
  }

  // Метод для перевірки наявності ключа
  Future<bool> containsKey(final String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  // Метод для видалення всіх даних
  Future<void> deleteAllData() async {
    await _secureStorage.deleteAll();
  }
}
