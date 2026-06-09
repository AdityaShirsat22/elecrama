import 'package:elecrama/data/model/exhibitor_fav_model.dart';
import 'package:elecrama/data/model/visitor_fav_model.dart';
import 'package:elecrama/data/repositories/fav_service.dart';
import 'package:elecrama/view_model/controller/authController.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FavoriteService service = FavoriteService();

  final authController = Get.find<AuthController>();

  RxBool isLoading = false.obs;

  /// =========================================
  /// VISITOR FAVORITES
  /// =========================================

  RxList<VisitorFavoriteModel> visitorFavoriteList =
      <VisitorFavoriteModel>[].obs;

  RxList<int> visitorFavoriteIds = <int>[].obs;

  /// GET VISITOR FAVORITES
  Future<void> getVisitorFavoriteList() async {
    try {
      isLoading.value = true;

      final result = await service.getVisitorFavoriteList(
        visitorId: authController.visitorId.value,
      );

      visitorFavoriteList.assignAll(result);

      visitorFavoriteIds.assignAll(result.map((e) => e.exhibitorId).toList());
    } catch (e) {
      print(e);

      visitorFavoriteList.clear();
      visitorFavoriteIds.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// CHECK VISITOR FAVORITE
  bool isVisitorFavorite(int exhibitorId) {
    return visitorFavoriteIds.contains(exhibitorId);
  }

  /// TOGGLE VISITOR FAVORITE
  Future<void> toggleVisitorFavorite(int exhibitorId) async {
    try {
      final success = await service.toggleVisitorFavorite(
        exhibitorId: exhibitorId,
        visitorId: authController.visitorId.value,
      );

      if (!success) return;

      await getVisitorFavoriteList();
    } catch (e) {
      print('Toggle Visitor Favorite Error : $e');
    }
  }

  /// =========================================
  /// EXHIBITOR FAVORITES
  /// =========================================

  RxList<ExhibitorFavouriteModel> exhibitorFavoriteList =
      <ExhibitorFavouriteModel>[].obs;

  RxList<int> exhibitorFavoriteIds = <int>[].obs;

  /// GET EXHIBITOR FAVORITES
  Future<void> getExhibitorFavoriteList() async {
    try {
      isLoading.value = true;

      final result = await service.getExhibitorFavoriteList(
        exhibitorUserId: authController.exhibitorUserId.value,
      );

      exhibitorFavoriteList.assignAll(result);

      exhibitorFavoriteIds.assignAll(result.map((e) => e.inid).toList());
    } catch (e) {
      print(e);

      exhibitorFavoriteList.clear();
      exhibitorFavoriteIds.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// CHECK EXHIBITOR FAVORITE
  bool isExhibitorFavorite(int exhibitorId) {
    return exhibitorFavoriteIds.contains(exhibitorId);
  }

  /// TOGGLE EXHIBITOR FAVORITE
  Future<void> toggleExhibitorFavorite(int exhibitorId) async {
    try {
      final success = await service.toggleExhibitorFavorite(
        exhibitorId: exhibitorId,
        exhibitorUserId: authController.exhibitorUserId.value,
      );

      if (!success) return;

      await getExhibitorFavoriteList();
    } catch (e) {
      print('Toggle Exhibitor Favorite Error : $e');
    }
  }


}
