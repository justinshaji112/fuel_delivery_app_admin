import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/user_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/controller/user_controller.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';
import 'package:fuel_delivary_app_admin/utils/validators/form_validators.dart';
import 'package:fuel_delivary_app_admin/view/widgets/add_service_button.dart';
import 'package:fuel_delivary_app_admin/view/widgets/image_picker_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final TextEditingController _searchController = TextEditingController();

  UserController userController = Get.put(UserController());

  ImageController imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (v) {
                userController.filterUsers(v);
              },
            ),
            const SizedBox(height: 16),

            // Users Data Table
            Obx(() {
              return Expanded(
                child: userController.state.value == ControllerStates.success
                    ? Card(
                        elevation: 4,
                        child: SingleChildScrollView(
                          child: PaginatedDataTable(
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            source: userController.getDatasource(),
                            rowsPerPage: 13,
                            dataRowHeight: 50,
                          ),
                        ),
                      )
                    : userController.state.value == ControllerStates.error
                        ? Center(
                            child: Text(userController.error!),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
