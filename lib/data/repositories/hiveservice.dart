import 'package:hive_flutter/adapters.dart';

class Hiveservice {
  final Box _box = Hive.box('authBox');

  void saveRole(String role) {
    _box.put('role', role);
  }

  String? getRole() {
    return _box.get('role');
  }

  void saveUserEmail(String email) {
    _box.put('userEmail', email);
  }

  String? getUserEmail() {
    return _box.get('userEmail');
  }

  void saveUserPassword(String password) {
    _box.put('userPassword', password);
  }

  String? getUserPassword() {
    return _box.get('userPassword');
  }

  void setLoggedIn(bool value) {
    _box.put('isLoggedIn', value);
  }

  bool isloggedIn() {
    return _box.get('isLoggedIn', defaultValue: false);
  }

  void loggout() {
    _box.clear();
  }
}
