import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/agent_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/model/agent_model.dart';
import 'package:fuel_delivary_app_admin/utils/validators/form_validators.dart';
import 'package:fuel_delivary_app_admin/view/widgets/add_service_button.dart';
import 'package:fuel_delivary_app_admin/view/widgets/image_picker_widget.dart';

class AgentDialogs {
  AgentDialogs._();
  static Future<dynamic> addEditAgentDialog(BuildContext context,
      {AgentModel? agent,
      required ImageController imageController,
      required AgentController agentController,
      required List<String> services}) {
    final nameController = TextEditingController(text: agent?.name ?? '');
    final emailController = TextEditingController(text: agent?.email ?? '');
    final phoneController = TextEditingController(text: agent?.phone ?? '');

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    List<String> agentServices = agent?.services ?? [];

    String? selectedStatus = agent?.status ?? false ? "Active" : "Inactive";

    BuildContext buildContext = context;

    return showDialog(
      context: buildContext,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(agent == null ? 'Add New Agent' : 'Edit Agent'),
          content: SizedBox(
            width: 400,
            height: 600,
            child: StatefulBuilder(builder: (context, setState) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagePickerWidget(
                      imageUrl: agent?.image,
                      image: imageController,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid name"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormValidators.emailValidator,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: FormValidators.phoneValidator,
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
                    AddServiceButton(
                        onTap: () {
                          _selectServicesDialog(
                                  context, agentServices, services)
                              .then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                        label: "Add Service"),
                    Expanded(
                      child: ListView(
                        children: agentServices
                            .map((e) => Text(
                                  e,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ))
                            .toList(),
                      ),
                    ),
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
                // Save agent logic
                if (agent == null) {
                  if (imageController.image != null &&
                      agentServices.isNotEmpty &&
                      _formKey.currentState!.validate()) {
                    await agentController.addAgent(
                        imageController.image!,
                        nameController.text,
                        phoneController.text,
                        emailController.text,
                        agentServices);
                  }
                  Navigator.pop(context);
                } else {
                  if (_formKey.currentState!.validate() &&
                      services.isNotEmpty) {
                    agent.name = nameController.text;
                    agent.email = emailController.text;
                    agent.phone = phoneController.text;
                    agent.services = agentServices;
                    agent.status = selectedStatus == "Active" ? true : false;

                    await agentController.updateAgent(
                        agent, imageController.image);
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

  static Future<dynamic> _selectServicesDialog(
      BuildContext context, List<String> agentServices, List<String> services) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
            width: 500,
            height: 400,
            child: StatefulBuilder(
              builder: (context, setState) {
                return ListView.separated(
                  itemCount: services.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(services[index]),
                    trailing: IconButton(
                        onPressed: () {
                          if (agentServices.contains(services[index])) {
                            agentServices.removeAt(index);
                          } else {
                            agentServices.add(services[index]);
                          }
                          setState(
                            () {},
                          );
                        },
                        icon: agentServices.contains(services[index])
                            ? Icon(Icons.remove)
                            : Icon(Icons.add)),
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                );
              },
            )),
      ),
    );
  }
}
