import 'dart:math';

import 'package:fuel_delivary_app_admin/model/user_model.dart';
import 'package:fuel_delivary_app_admin/services/user_service/user_service.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

class UserController extends GetxController {
  RxList<User> users = <User>[].obs;
  RxList<User> fileteredUsers = <User>[].obs;
  UserService userService = UserService();

  @override
  void onInit() {
    super.onInit();

    userService.getUsersStream().listen(
      (event) {
        users.assignAll(event);
        filterUser("");
      },
    );
  }

  changeUserStatus(User user) {}

  filterUser(String value) {
    if (value.isEmpty) {
      fileteredUsers.assignAll(users);
    } else {
      fileteredUsers.assignAll(users
          .where(
              (user) => user.name!.toLowerCase().contains(value.toLowerCase()))
          .toList());
    }
  }

  // List<User> filterUsers({
  //   String? name,
  //   String? email,
  //   String? phone,
  //   bool? status,
  //   String? city,
  //   String? state,
  //   String? country
  // }) {
  //   return users.where((user) {
  //     bool matches = true;

  //     if (name != null) {
  //       matches = matches && user.name.toLowerCase().contains(name.toLowerCase());
  //     }
  //     if (email != null) {
  //       matches = matches && user.email.toLowerCase().contains(email.toLowerCase());
  //     }
  //     if (phone != null) {
  //       matches = matches && user.phone.contains(phone);
  //     }
  //     if (status != null) {
  //       matches = matches && user.status == status;
  //     }
  //     if (city != null) {
  //       matches = matches && user.address.any((addr) =>
  //         addr.city.toLowerCase().contains(city.toLowerCase()));
  //     }
  //     if (state != null) {
  //       matches = matches && user.address.any((addr) =>
  //         addr.state.toLowerCase().contains(state.toLowerCase()));
  //     }
  //     if (country != null) {
  //       matches = matches && user.address.any((addr) =>
  //         addr.country.toLowerCase().contains(country.toLowerCase()));
  //     }

  //     return matches;
  //   }).toList();
  // }
}
