import 'package:get/get.dart';

import '../../api/api_service.dart';
import '../../place/model/place.dart';

class HomeController extends GetxController {
  final String title = 'Home Page';

  var isLoading = true.obs;
  var placeList = <Place>[].obs;

  @override
  void onInit() {
    fetchPlaces();
    super.onInit();
  }

  Future<void> fetchPlaces() async {
    try {
      isLoading(true);
      var place = await ApiService.fetchPlaces();
      if (place != null) {
        placeList.assignAll(place);
      }
    } finally {
      isLoading(false);
      update();
    }
  }
}
