import 'package:hive/hive.dart';

class CacheService {
  final Box cacheBox = Hive.box('cacheBox');

  void save(String key, dynamic data) {
    cacheBox.put(key, data);
  }

  dynamic get(String key) {
    return cacheBox.get(key);
  }

  bool has(String key) {
    return cacheBox.containsKey(key);
  }

  void clear(String key) {
    cacheBox.delete(key);
  }

  void clearAll() {
    cacheBox.clear();
  }
}