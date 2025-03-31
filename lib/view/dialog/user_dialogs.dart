import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/user_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';
import 'package:fuel_delivary_app_admin/utils/validators/form_validators.dart';
import 'package:fuel_delivary_app_admin/view/widgets/add_service_button.dart';
import 'package:fuel_delivary_app_admin/view/widgets/image_picker_widget.dart';

class UserDialog {
  UserDialog._();
  static Future<dynamic> addEditUserDialog(
    BuildContext context, {
    UserModel? user,
    required UserController userController,
  }) {
    final nameController = TextEditingController(text: user?.name ?? '');
    final phoneController = TextEditingController(
        text: user?.phone == null
            ? ""
            : user!.phone.toString());
    final emailController = TextEditingController(
        text: user?.email == null
            ? ""
            : user!.email.toString());


    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? selectedStatus = user?.status ?? false ? "Active" : "Inactive";

    BuildContext buildContext = context;

    return showDialog(
      context: buildContext,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(user == null ? 'Add New User' : 'Edit User'),
          content: SizedBox(
            width: 400,
            height: 600,
            child: StatefulBuilder(builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name of the user',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid name"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid Email"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid number"),
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedStatus,
                      items: ['Active', 'Inactive']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save user logic
               if(user!=null) {
                  if (formKey.currentState!.validate()) {
                   

                    user.status = selectedStatus == "Active" ? true : false;

                    await userController.updateUser(user);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      }),
    );
  }
}
