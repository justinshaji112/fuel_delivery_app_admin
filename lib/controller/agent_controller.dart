import 'package:fuel_delivary_app_admin/view/data_source/agent_datasource.dart';
import 'package:fuel_delivary_app_admin/model/agent_model.dart';
import 'package:fuel_delivary_app_admin/services/agent_service/agent_service.dart';
import 'package:fuel_delivary_app_admin/services/common/upload_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum AgentControllerState {
  success,
  loading,
  error,
}

class AgentController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAgents();
  }

  RxList<AgentModel> agents = RxList<AgentModel>();
  RxList<AgentModel> filteredAgents = RxList<AgentModel>();
  Rx<AgentControllerState> state = Rx(AgentControllerState.success);
  String? error = '';
  AgentService agentService = AgentService();

  getAgents() async {
    state.value = AgentControllerState.loading;
    try {
      agents.value = await agentService.getAgents();
      filteredAgents.value = List<AgentModel>.from(agents);
      state.value = AgentControllerState.success;
    } catch (e) {
      error = e.toString();
      state.value = AgentControllerState.error;
    }
  }

  addAgent(
    XFile image,
    String name,
 
    String phone,
    String email,
    List<String> services,
  ) async {
    try {
      String imageUrl = await ImageService.uploadImageToStorage(image);

      await agentService.addAgent(AgentModel(
          id: null,
          image: imageUrl,
          name: name,
         
          email: email,
          phone: phone,
          status: true,
          services: services));
      state.value = AgentControllerState.success;
    } catch (e) {
      state.value = AgentControllerState.error;
      error = e.toString();
    }
  }

  deleteAgent(String id) async {
    try {
      await agentService.removeAgent(id);
      state.value = AgentControllerState.success;
    } catch (e) {
      error = e.toString();
      state.value = AgentControllerState.error;
    }
  }

  updateAgent(AgentModel agent, XFile? image) async {
    try {
      await agentService.updateAgent(agent, image);
      state.value = AgentControllerState.success;
    } catch (e) {
      error = e.toString();
      state.value = AgentControllerState.error;
    }
  }

  void filterAgents(String query) {
    if (query.isEmpty) {
      filteredAgents.value = agents.toList(); // Ensure a new list is assigned
    } else {
      filteredAgents.value = agents
          .where(
              (agent) => agent.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  AgentDataSource getDatasource() {


    return AgentDataSource(
        onEdit: (p0) {
        
        },
        agents: filteredAgents.toList(), agentController: this);
  }
}
