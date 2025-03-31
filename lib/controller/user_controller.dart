import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/global.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';
import 'package:fuel_delivary_app_admin/services/user_service/user_service.dart';
import 'package:fuel_delivary_app_admin/view/data_source/user_datasource.dart';
import 'package:get/get.dart';

enum ControllerStates {
  success,
  loading,
  error,
}

class UserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsers();
  }

  RxList<UserModel> users = RxList<UserModel>();
  RxList<UserModel> filteredUsers = RxList<UserModel>();
  Rx<ControllerStates> state = Rx(ControllerStates.success);
  String? error = '';
  UserService userService = UserService();

  getUsers() async {
    state.value = ControllerStates.loading;
    try {
      users.value = await userService.getUsers();
      filteredUsers.value = List<UserModel>.from(users);
      state.value = ControllerStates.success;
    } catch (e) {
      error = e.toString();
      state.value = ControllerStates.error;
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
    }
  }

  deleteUser(String id) async {
    try {
      await userService.removeUser(id);
      state.value = ControllerStates.success;
      getUsers();
    } catch (e) {
      error = e.toString();
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
      state.value = ControllerStates.error;
    }
  }

  updateUser(UserModel agent) async {
    try {
      await userService.updateUser(agent);
      state.value = ControllerStates.success;
      getUsers();
    } catch (e) {
      error = e.toString();
      if (navigatorKey.currentContext != null) {
        CustomDialogs.error(navigatorKey.currentContext!, e.toString());
      }
      state.value = ControllerStates.error;
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users.toList(); // Ensure a new list is assigned
    } else {
      filteredUsers.value = users
          .where((user) => user.name != null
              ? user.name!.toLowerCase().contains(query.toLowerCase())
              : false)
          .toList();
    }
  }

  UserDatasource getDatasource() {
    return UserDatasource(
        onEdit: (p0) {}, users: filteredUsers.toList(), userController: this);
  }
}
