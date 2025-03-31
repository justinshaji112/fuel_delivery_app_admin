import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/agent_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/view/dialog/agent_dialogs.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AgentView extends StatefulWidget {
  const AgentView({super.key});

  @override
  _AgentViewState createState() => _AgentViewState();
}

class _AgentViewState extends State<AgentView> {
  final TextEditingController _searchController = TextEditingController();

  List<String> services = [
    "Car wash",
    "Deep clean",
    "Tire change",
    "EV charge",
  ];

  AgentController agentController = Get.put(AgentController());

  ImageController imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agents Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => AgentDialogs.addEditAgentDialog(context,
                agentController: agentController,
                imageController: imageController,
                services: services),
          ),
        ],
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
                hintText: 'Search agents...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (v) {
                agentController.filterAgents(v);
              },
            ),
            const SizedBox(height: 16),

            // Agents Data Table
            Obx(() {
              return Expanded(
                child: agentController.state.value ==
                        AgentControllerState.success
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
                            source: agentController.getDatasource(),
                            rowsPerPage: 13,
                            dataRowHeight: 50,
                          ),
                        ),
                      )
                    : agentController.state.value == AgentControllerState.error
                        ? Center(
                            child: Text(agentController.error!),
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
//