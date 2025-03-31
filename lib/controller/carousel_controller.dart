import 'package:fuel_delivary_app_admin/model/carousel_model.dart';
import 'package:fuel_delivary_app_admin/services/carousel_service/carousel_service.dart';
import 'package:fuel_delivary_app_admin/services/common/upload_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fuel_delivary_app_admin/view/data_source/carousel_datasource.dart';

enum CarouselWidgetControllerState {
  success,
  loading,
  error,
}

class CarouselWidgetController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCarousels();
  }

  RxList<CarouselModel> carousels = RxList<CarouselModel>();
  RxList<CarouselModel> filteredCarousels = RxList<CarouselModel>();
  Rx<CarouselWidgetControllerState> state =
      Rx(CarouselWidgetControllerState.success);
  String? error = '';
  CarouselService carouselService = CarouselService();
  getCarousels() async {
    state.value = CarouselWidgetControllerState.loading;
    try {
      carousels.value = await carouselService.getCarousels();
      filteredCarousels.value = List<CarouselModel>.from(carousels);
      state.value = CarouselWidgetControllerState.success;
    } catch (e) {
      error = e.toString();
      state.value = CarouselWidgetControllerState.error;
    }
  }

  addCarousel(
    XFile image,
    String title,
    String subtitle,
    int weight,
  ) async {
    try {
      String imageUrl = await ImageService.uploadImageToStorage(image);

      String id = await carouselService.addCarousel(CarouselModel(
          id: null,
          image: imageUrl,
          title: title,
          subTitle: subtitle,
          weight: weight));
      await carouselService.updateCarousel(
          CarouselModel(
              id: id,
              image: imageUrl,
              title: title,
              subTitle: subtitle,
              weight: weight),
          image);

      state.value = CarouselWidgetControllerState.success;
    } catch (e) {
      state.value = CarouselWidgetControllerState.error;
      error = e.toString();
    }
  }

  deleteCarousel(String id) async {
    try {
      await carouselService.removeCarousel(id);
      state.value = CarouselWidgetControllerState.success;
      getCarousels();
    } catch (e) {
      error = e.toString();
      state.value = CarouselWidgetControllerState.error;
    }
  }

  updateCarousel(CarouselModel carousel, XFile? image) async {
    try {
      await carouselService.updateCarousel(carousel, image);
      state.value = CarouselWidgetControllerState.success;
      getCarousels();
    } catch (e) {
      error = e.toString();
      state.value = CarouselWidgetControllerState.error;
    }
  }

  void filterCarousels(String query) {
    if (query.isEmpty) {
      filteredCarousels.value =
          carousels.toList(); // Ensure a new list is assigned
    } else {
      filteredCarousels.value = carousels
          .where((carousel) =>
              carousel.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  CarouselDatasource getDatasource() {
    return CarouselDatasource(
        onEdit: (p0) {},
        carousels: filteredCarousels.toList(),
        carouselController: this);
  }
}
