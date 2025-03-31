import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/controller/agent_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/global.dart';
import 'package:fuel_delivary_app_admin/model/agent_model.dart';
import 'package:fuel_delivary_app_admin/view/dialog/agent_dialogs.dart';

class AgentDataSource extends DataTableSource {
  final List<AgentModel> agents;
  final AgentController agentController;
  final Function(AgentModel) onEdit;

  AgentDataSource(
      {required this.agentController,
      required this.agents,
      required this.onEdit});

  @override
  DataRow? getRow(
    int index,
  ) {
    // Use the agents list parameter instead of controller's filteredAgents directly
    if (index >= agents.length) return null;

    AgentModel agent = agents[index];
    return DataRow(cells: [
      DataCell(Text(agent.id ?? '')),
      DataCell(Text(agent.name)),
      DataCell(Text(agent.email)),
      DataCell(Text(agent.phone)),
      DataCell(Chip(
        label: agent.status == false
            ? const Text(
                "Blocked",
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                "Active",
                style: const TextStyle(color: Colors.white),
              ),
        color: MaterialStateProperty.all(
            agent.status == false ? Colors.red : Colors.green),
      )),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              BuildContext? context = navigatorKey.currentContext;
              if (context != null) {
                ImageController imageController = ImageController();
                List<String> services = [
                  "Car wash",
                  "Deep clean",
                  "Tire change",
                  "EV charge",
                ];
                AgentDialogs.addEditAgentDialog(context,
                    imageController: imageController,
                    agentController: agentController,
                    services: services,
                    agent: agent);
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
                    "Delete Agent",
                    "Are you sure you want to delete this agent ?");
                if (delete != null && delete) {
                  agentController.deleteAgent(agent.id!);
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
  int get rowCount => agents.length; // Use the passed agents list length

  @override
  int get selectedRowCount => 0;
}
