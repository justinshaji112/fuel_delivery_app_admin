import 'package:flutter/material.dart';

class Agent {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final String specialization;

  Agent({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.specialization,
  });
}

class AgentView extends StatefulWidget {
  const AgentView({super.key});

  @override
  _AgentViewState createState() => _AgentViewState();
}

class _AgentViewState extends State<AgentView> {
  final TextEditingController _searchController = TextEditingController();

  final List<Agent> _agents = [
    Agent(
      id: '1',
      name: 'Mike Johnson',
      email: 'mike@example.com',
      phone: '+1 (555) 123-4567',
      status: 'Active',
      specialization: 'Car Wash',
    ),
    Agent(
      id: '2',
      name: 'Sarah Williams',
      email: 'sarah@example.com',
      phone: '+1 (555) 987-6543',
      status: 'Inactive',
      specialization: 'Tire Change',
    ),
    // Add more sample agents
  ];

  List<Agent> _filteredAgents = [];
  int _currentPage = 0;
  final int _rowsPerPage = 5;

  // Specialization options
  final List<String> _specializations = [
    'Car Wash',
    'Tire Change',
    'Oil Change',
    'Battery Charging',
    'General Maintenance'
  ];

  @override
  void initState() {
    super.initState();
    _filteredAgents = _agents;
  }

  void _filterAgents(String query) {
    setState(() {
      _filteredAgents = _agents
          .where((agent) =>
              agent.name.toLowerCase().contains(query.toLowerCase()) ||
              agent.email.toLowerCase().contains(query.toLowerCase()) ||
              agent.phone.contains(query) ||
              agent.specialization.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _currentPage = 0;
    });
  }

  void _showAgentDialog({Agent? agent}) {
    final nameController = TextEditingController(text: agent?.name ?? '');
    final emailController = TextEditingController(text: agent?.email ?? '');
    final phoneController = TextEditingController(text: agent?.phone ?? '');

    String? selectedSpecialization = agent?.specialization;
    String? selectedStatus = agent?.status;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(agent == null ? 'Add New Agent' : 'Edit Agent'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Specialization Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Specialization',
                  border: OutlineInputBorder(),
                ),
                value: selectedSpecialization,
                items: _specializations
                    .map((spec) => DropdownMenuItem(
                          value: spec,
                          child: Text(spec),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSpecialization = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              // Status Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                value: selectedStatus ?? 'Active',
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save agent logic
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteAgent(Agent agent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Agent'),
        content: Text('Are you sure you want to delete ${agent.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _agents.removeWhere((a) => a.id == agent.id);
                _filteredAgents = _agents;
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  List<Agent> _getPaginatedAgents() {
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex = startIndex + _rowsPerPage;
    return _filteredAgents.length > endIndex
        ? _filteredAgents.sublist(startIndex, endIndex)
        : _filteredAgents.sublist(startIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agents Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAgentDialog(),
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
              onChanged: _filterAgents,
            ),
            const SizedBox(height: 16),

            // Agents Data Table
            Expanded(
              child: Card(
                elevation: 4,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Specialization')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _getPaginatedAgents().map((agent) {
                      return DataRow(
                        cells: [
                          DataCell(Text(agent.id)),
                          DataCell(Text(agent.name)),
                          DataCell(Text(agent.email)),
                          DataCell(Text(agent.phone)),
                          DataCell(Text(agent.specialization)),
                          DataCell(
                            Chip(
                              label: Text(agent.status),
                              backgroundColor: agent.status == 'Active'
                                  ? Colors.green[100]
                                  : Colors.red[100],
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () =>
                                      _showAgentDialog(agent: agent),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteAgent(agent),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Pagination
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _currentPage > 0
                      ? () {
                          setState(() {
                            _currentPage--;
                          });
                        }
                      : null,
                ),
                Text('Page ${_currentPage + 1}'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed:
                      (_currentPage + 1) * _rowsPerPage < _filteredAgents.length
                          ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
