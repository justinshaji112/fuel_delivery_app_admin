import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/global.dart';
import 'package:fuel_delivary_app_admin/model/offer_model.dart';
import 'package:fuel_delivary_app_admin/services/offer_service/offer_service.dart';
import 'package:fuel_delivary_app_admin/view/data_source/offer_datasource.dart';
import 'package:get/get.dart';

enum ControllerStates {
  success,
  loading,
  error,
}

class OfferController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOffers();
  }

  RxList<OfferModel> offers = RxList<OfferModel>();
  RxList<OfferModel> filteredOffers = RxList<OfferModel>();
  Rx<ControllerStates> state = Rx(ControllerStates.success);
  String? error = '';
  OfferService offerService = OfferService();

  getOffers() async {
    state.value = ControllerStates.loading;
    try {
      offers.value = await offerService.getOffers();
      filteredOffers.value = List<OfferModel>.from(offers);
      state.value = ControllerStates.success;
    } catch (e) {
      error = e.toString();
      state.value = ControllerStates.error;
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
    }
  }

  addOffer(String name, double startingPrice, double endingPrice,
      String description, double offerPercentage) async {
    try {
      String id = await offerService.addOffer(OfferModel(
          id: null,
          name: name,
          startingPrice: startingPrice,
          endingPrice: endingPrice,
          description: description,
          offerPercentage: offerPercentage,
          status: true));
      await offerService.updateOffer(OfferModel(
          id: id,
          name: name,
          startingPrice: startingPrice,
          endingPrice: endingPrice,
          description: description,
          offerPercentage: offerPercentage,
          status: true));
      state.value = ControllerStates.success;
    } catch (e) {
      state.value = ControllerStates.error;
      error = e.toString();
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
    }
  }

  deleteOffer(String id) async {
    try {
      await offerService.removeOffer(id);
      state.value = ControllerStates.success;
      getOffers();
    } catch (e) {
      error = e.toString();
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
      state.value = ControllerStates.error;
    }
  }

  updateOffer(OfferModel agent) async {
    try {
      await offerService.updateOffer(agent);
      state.value = ControllerStates.success;
      getOffers();
    } catch (e) {
      error = e.toString();
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
      state.value = ControllerStates.error;
    }
  }

  void filterOffers(String query) {
    if (query.isEmpty) {
      filteredOffers.value = offers.toList(); // Ensure a new list is assigned
    } else {
      filteredOffers.value = offers
          .where(
              (agent) => agent.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  OfferDatasource getDatasource() {
    return OfferDatasource(
        onEdit: (p0) {},
        offers: filteredOffers.toList(),
        offerController: this);
  }
}
