import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/controller/user_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/global.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';
import 'package:fuel_delivary_app_admin/view/dialog/user_dialogs.dart';

class UserDatasource extends DataTableSource {
  final List<UserModel> users;
  final UserController userController;
  final Function(UserModel) onEdit;

  UserDatasource(
      {required this.userController,
      required this.users,
      required this.onEdit});

  @override
  DataRow? getRow(
    int index,
  ) {
    // DataColumn(label: Text('ID')),
    //                         DataColumn(label: Text('Name')),
    //                         DataColumn(label: Text('User')),
    //                         DataColumn(label: Text('Price range')),
    //                         DataColumn(label: Text('Status')),
    //                         DataColumn(label: Text('Actions')),
    // Use the users list parameter instead of controller's filteredUsers directly
    if (index >= users.length) return null;

    UserModel user = users[index];
    return DataRow(cells: [
      DataCell(Text(user.id ?? '')),
      DataCell(Text(user.name ?? "guest")),
      DataCell(Text(user.email.toString())),
      DataCell(Text(user.phone ?? "")),
      DataCell(Chip(
        label: user.status == false
            ? const Text(
                "Blocked",
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                "Active",
                style: const TextStyle(color: Colors.white),
              ),
        color: MaterialStateProperty.all(
            user.status == false ? Colors.red : Colors.green),
      )),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              BuildContext? context = navigatorKey.currentContext;
              if (context != null) {
                UserDialog.addEditUserDialog(context,
                    userController: userController, user: user);
              }

              // Edit action
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              if (navigatorKey.currentContext != null) {
                bool? delete = await CustomDialogs.delete(
                    navigatorKey.currentContext!,
                    "Delete User",
                    "Are you sure you want to delete this user ?");
                if (delete != null && delete) {
                  userController.deleteUser(user.id!);
                }
              }
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length; // Use the passed users list length

  @override
  int get selectedRowCount => 0;
}
