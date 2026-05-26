import 'package:elecrama/data/model/visitor_fav_model.dart';
import 'package:elecrama/data/repositories/visitor_fav_service.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FavoriteService service = FavoriteService();

  RxBool isLoading = false.obs;
  RxList<VisitorFavoriteModel> favoriteList = <VisitorFavoriteModel>[].obs;
  RxList<int> favoriteIds = <int>[].obs;

  int visitorId = 7669;

  @override
  void onInit() {
    super.onInit();
    getFavoriteList();
  }

  Future<void> getFavoriteList() async {
    try {
      isLoading.value = true;

      final result = await service.getFavoriteList(visitorId: visitorId);

      favoriteList.assignAll(result);
      favoriteIds.assignAll(result.map((e) => e.exhibitorId).toList());
    } catch (e) {
      print(e);
      favoriteList.clear();
      favoriteIds.clear();
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(int exhibitorId) {
    return favoriteIds.contains(exhibitorId);
  }

  Future<void> toggleFavorite(int exhibitorId) async {
    try {
      final success = await service.toggleFavorite(
        exhibitorId: exhibitorId,
        visitorId: visitorId,
      );

      if (!success) {
        return;
      }

      if (favoriteIds.contains(exhibitorId)) {
        favoriteIds.remove(exhibitorId);
        favoriteList.removeWhere((e) => e.exhibitorId == exhibitorId);
      } else {
        favoriteIds.add(exhibitorId);
      }

      favoriteIds.refresh();
      favoriteList.refresh();
      update();
    } catch (e) {
      print('Toggle Favorite Error : $e');
    }
  }
}
