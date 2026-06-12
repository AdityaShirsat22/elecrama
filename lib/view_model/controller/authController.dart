import 'package:dio/dio.dart';
import 'package:elecrama/Api/api_constants.dart';
import 'package:elecrama/Api/dio_client.dart';
import 'package:elecrama/data/model/exhibitormodel.dart';
import 'package:elecrama/data/repositories/auth_service.dart';
import 'package:elecrama/data/repositories/cache_service.dart';
import 'package:elecrama/data/repositories/hiveservice.dart';
import 'package:elecrama/data/model/visitormodel.dart';
import 'package:elecrama/data/repositories/network_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _service = Get.find<AuthService>();
  final Hiveservice _hive = Get.find<Hiveservice>();
  var exhibitor = Rxn<ExhibitorRecord>();
  var visitor = Rxn<VisitorRecord>();
  Rx<ExhibitorRecord?> exhibitordetails = Rx<ExhibitorRecord?>(null);
  final Dio _dio = DioClient.dio;

  var isLoading = false.obs;

  RxInt visitorId = 0.obs;
  RxInt exhibitorId = 0.obs;
  RxInt exhibitorUserId = 0.obs;
  RxInt visitorinId = 0.obs;

  @override
  void onInit() {
    super.onInit();

    loadSavedUser();
  }

  bool isLoggedIn() {
    return _hive.isloggedIn();
  }

  String getRole() {
    return _hive.getRole() ?? '';
  }

  void setLoggedInUser(String role) {
    _hive.saveRole(role);
    _hive.setLoggedIn(true);
  }

  void saveUserEmail(String email) {
    _hive.saveUserEmail(email);
  }

  String? getUserEmail() {
    return _hive.getUserEmail();
  }

  void logout() {
    _hive.logout();
  }

  Future<void> loadSavedUser() async {
    if (!_hive.isloggedIn()) return;
    final role = _hive.getRole();
    final email = _hive.getUserEmail();

    if (role == 'visitor' && email != null) {
      await getVisitorDetails(email);
      visitorId.value = _hive.getVisitorId();

      await Future.wait([
        getExhitorsList(),
        getHallList(),
        getCountryList(),
        getProductCategoryList(),
      ]);
    }
    if (role == 'exhibitor' && email != null) {
      await getExhibitorDetails(email);
      exhibitorId.value = _hive.getExhibitorId();

      await Future.wait([
        getExhitorsList(),
        getHallList(),
        getCountryList(),
        getProductCategoryList(),
      ]);
    }
  }

  Future<bool> visitorlogin(String user, String pass) async {
    try {
      isLoading.value = true;
      final response = await _service.visitorLogin(
        userId: user.trim(),
        password: pass.trim(),
      );
      final data = response.data;
      print("LOGIN RESPONSE");
      print(response.data);
      final code = data["Code"];
      final isSuccess = code == 1 || code == "1" || code == true;

      if (isSuccess) {
        saveUserEmail(user.trim());

        _hive.saveUserPassword(pass.trim());

        setLoggedInUser('visitor');

        await getVisitorDetails(user.trim());

        print("Visitor Value = ${visitor.value}");
        print("Visitor InID = ${visitor.value?.inId}");

        if (visitor.value != null) {
          visitorId.value = visitor.value!.inId ?? 0;
          _hive.saveVisitorinId(visitorId.value);

          visitorinId.value =
              int.tryParse(data["InID"]?.toString() ?? "0") ?? 0;
          _hive.saveVisitorinId(visitorinId.value);
          print("Hive Visitor ID = ${_hive.getVisitorinId()}");
        }

        return true;
      } else {
        final message =
            data["Message"] ?? data["message"] ?? "Enter valid id and password";
        Get.snackbar(
          "",
          message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: const Color.fromARGB(221, 182, 89, 89),
          colorText: Colors.white,
          icon: const Icon(Icons.error_outline, color: Colors.white),
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
          animationDuration: Duration(milliseconds: 300),
          duration: Duration(seconds: 1),
        );
        return false;
      }
    } catch (e) {
      final message = e is DioException
          ? e.response?.data?.toString() ?? e.message
          : 'Network or server error';
      Get.snackbar(
        "",
        message!,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: const Color.fromARGB(221, 192, 92, 92),
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        borderRadius: 10,
        margin: const EdgeInsets.all(16),
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 1),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  //visitor details
  Future<bool> getVisitorDetails(String userId) async {
    try {
      isLoading.value = true;

      final password = _hive.getUserPassword() ?? '';

      final data = await _service.fetchVisitorDetails(userId, password);

      if (data != null) {
        visitor.value = data;
        final inId = data.inId ?? 0;

        print("Saving Visitor InID = $inId");

        _hive.saveVisitorinId(inId);
        return true;
      }

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  //exhibitor details
  Future<bool> getExhibitorDetails(String email) async {
    try {
      isLoading.value = true;

      final data = await _service.fetchExhibitorDetails(email);

      print("FETCHED DATA : $data");
      print("NAME : ${data?.stName}");

      if (data != null) {
        exhibitor.value = data;
        exhibitorUserId.value = int.tryParse(data.exhibitorUserId ?? '0') ?? 0;

        final inId = int.tryParse(data.exhibitorUserId ?? '0') ?? 0;

        print("Saving Exhibitor InID = $inId");

        _hive.saveExhibitorinId(inId);

        print("CONTROLLER DATA : ${exhibitor.value?.stName}");

        return true;
      }

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  //RxList<ExhibitorLists> exhibitorList = <ExhibitorLists>[].obs;
  RxInt totalExhibitorCount = 0.obs;

  //FILTER DATA
  RxList exhibitorList = [].obs;
  RxList originalExhibitorList = [].obs;
  RxList hallList = [].obs;
  RxList countryList = [].obs;
  RxList productCategoryList = [].obs;

  //SELECTED FILTERS
  RxSet<String> selectedHalls = <String>{}.obs;
  RxSet<String> selectedCountries = <String>{}.obs;
  RxSet<String> selectedProductIds = <String>{}.obs;

  //product category search
  RxString productCategorySearch = ''.obs;

  //exhibitor list
  Future<void> getExhitorsList({String search = ""}) async {
    try {
      final data = await _service.fetchExhibitorLists(searchText: search);

      exhibitorList.assignAll(data);

      if (search.isEmpty) {
        originalExhibitorList.assignAll(data);
        totalExhibitorCount.value = data.length;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getCachedList({
    required String cacheKey,
    required String url,
  }) async {
    final cache = CacheService();

    try {
      final isOnline = await NetworkService.isConnected();

      if (isOnline) {
        final response = await _dio.get(url);

        cache.save(cacheKey, response.data);

        return response.data;
      }

      return cache.get(cacheKey) ?? [];
    } catch (e) {
      return cache.get(cacheKey) ?? [];
    }
  }

  //hall list
  Future<void> getHallList() async {
    hallList.assignAll(
      await getCachedList(
        cacheKey: 'hall_list',
        url: ApiConstants.exhibitorhalllist,
      ),
    );
  }

  //country list
  Future<void> getCountryList() async {
    countryList.assignAll(
      await getCachedList(
        cacheKey: 'country_list',
        url: ApiConstants.countrylist,
      ),
    );
  }

  //product category list
  Future<void> getProductCategoryList() async {
    productCategoryList.assignAll(
      await getCachedList(
        cacheKey: 'product_category_list',
        url: ApiConstants.subcategorylist,
      ),
    );
  }

  //APPLY FILTERS
  void applyFilters() {
    List filtered = List.from(originalExhibitorList);

    /// HALL FILTER
    if (selectedHalls.isNotEmpty) {
      filtered = filtered.where((e) {
        return selectedHalls.contains(e.hallNo);
      }).toList();
    }

    /// COUNTRY FILTER
    if (selectedCountries.isNotEmpty) {
      filtered = filtered.where((e) {
        return selectedCountries.contains(e.txtcountry);
      }).toList();
    }

    /// PRODUCT CATEGORY FILTER
    if (selectedProductIds.isNotEmpty) {
      filtered = filtered.where((e) {
        final ids = (e.productListCatId ?? '')
            .split(',')
            .map((id) => id.trim())
            .toList();

        return selectedProductIds.any((selectedId) => ids.contains(selectedId));
      }).toList();
    }

    exhibitorList.assignAll(filtered);
  }

  //clear filter
  void clearFilters() {
    selectedHalls.clear();
    selectedCountries.clear();
    selectedProductIds.clear();

    exhibitorList.assignAll(originalExhibitorList);
  }
}
