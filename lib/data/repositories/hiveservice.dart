import 'package:hive_flutter/adapters.dart';

class Hiveservice {
  final Box _box = Hive.box('authBox');

  /// ROLE
  void saveRole(String role) {
    _box.put('role', role);
  }

  String? getRole() {
    return _box.get('role');
  }

  /// LOGIN STATUS
  void setLoggedIn(bool value) {
    _box.put('isLoggedIn', value);
  }

  bool isloggedIn() {
    return _box.get('isLoggedIn', defaultValue: false);
  }

  /// USER EMAIL
  void saveUserEmail(String email) {
    _box.put('userEmail', email);
  }

  String? getUserEmail() {
    return _box.get('userEmail');
  }

  /// PASSWORD
  void saveUserPassword(String password) {
    _box.put('userPassword', password);
  }

  String? getUserPassword() {
    return _box.get('userPassword');
  }

  /// VISITOR ID
  void saveVisitorId(int id) {
    _box.put('visitorId', id);
  }

  int getVisitorId() {
    return _box.get('visitorId', defaultValue: 0);
  }

  /// EXHIBITOR ID
  void saveExhibitorId(int id) {
    _box.put('exhibitorId', id);
  }

  int getExhibitorId() {
    return _box.get('exhibitorId', defaultValue: 0);
  }

  /// VISITOR inID
  void saveVisitorinId(int id) {
    _box.put('visitorinId', id);
  }

  int getVisitorinId() {
    return _box.get('visitorinId', defaultValue: 0);
  }

  /// EXHIBITOR inID
  void saveExhibitorinId(int id) {
    _box.put('exhibitorinId', id);
  }

  int getExhibitorinId() {
    return _box.get('exhibitorinId', defaultValue: 0);
  }

  void saveExhibitorEmailNotification(bool value) {
    _box.put('exhibitorEmailNotification', value);
  }

  bool getExhibitorEmailNotification() {
    return _box.get('exhibitorEmailNotification', defaultValue: true);
  }

  /// LOGOUT
  void logout() {
    _box.clear();
  }
}
