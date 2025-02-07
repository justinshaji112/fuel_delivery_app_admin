import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/model/scrivce_model.dart';
import 'package:fuel_delivary_app_admin/services/service_mangement_services/service_mangement_service.dart';
import 'package:image_picker/image_picker.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  void _showServiceDialog({Service? service}) {
    final nameController = TextEditingController(text: service?.name ?? '');
    final descriptionController =
        TextEditingController(text: service?.description ?? '');
    String? selectedImageUrl;
    List<SubService> subServices = service?.subServices ?? [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(service == null ? 'Add New Service' : 'Edit Service'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    XFile? image;
                    final picker = ImagePicker();
                    try {
                      image =
                          await picker.pickImage(source: ImageSource.gallery);
                      print(image!.path);
                    } catch (e) {
                      print('Error picking image: $e');
                    }
                    if (image != null) {
                      final imageBytes = image;
                      selectedImageUrl = await ServiceMangementService()
                          .uploadImageToStorage(imageBytes);

                      print('Image URL: $selectedImageUrl');
                      setState(
                        () {},
                      );
                    } else {
                      print('No image selected.');
                    }
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImageUrl != null
                        ? Image.network(
                            selectedImageUrl!,
                            fit: BoxFit.cover,
                          )
                        : service?.imageUrl != null
                            ? Image.network(
                                service!.imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate, size: 50),
                                  Text('Tap to add image'),
                                ],
                              ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Service Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sub-Services',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Sub-Service'),
                  onPressed: () {
                    _showSubServiceDialog(
                      context: context,
                      onSave: (String name, String discription, String duration,
                          double price) {
                        setState(() {
                          subServices.add(SubService(
                              name: name,
                              price: price,
                              discription: discription,
                              duration: duration));
                        });
                      },
                    );
                  },
                ),
                ...subServices.map((subService) => ListTile(
                      title: Text(subService.name),
                      trailing: Text(subService.price.toStringAsFixed(2)),
                      leading: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            subServices.remove(subService);
                          });
                        },
                      ),
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (service == null) {
                  ServiceMangementService().addService(Service(
                      id: "",
                      name: nameController.text,
                      description: descriptionController.text,
                      imageUrl: selectedImageUrl,
                      subServices: subServices));
                } else {
                  ServiceMangementService().updateService(Service(
                      id: service.id,
                      name: nameController.text,
                      description: descriptionController.text,
                      imageUrl: selectedImageUrl ?? service.imageUrl,
                      subServices: subServices));
                }

                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSubServiceDialog({
    required BuildContext context,
    required Function(
      String,
      String,
      String,
      double,
    ) onSave,
  }) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final durationController = TextEditingController();
    final discriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Sub-Service'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Sub-Service Name',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: discriptionController,
              decoration: const InputDecoration(
                labelText: 'Sub-Service Discription',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Sub-Service Duration',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
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
              final name = nameController.text;
              final price = double.tryParse(priceController.text) ?? 0.0;
              final discription = discriptionController.text;
              final duration = durationController.text;

              if (name.isNotEmpty &&
                  duration.isNotEmpty &&
                  discription.isNotEmpty &&
                  price > 0) {
                onSave(
                  name,
                  discription,
                  duration,
                  price,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteService(Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete ${service.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ServiceMangementService().deleteService(service.id!);
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showServiceDialog(),
          ),
        ],
      ),
      body: StreamBuilder<List<Service>>(
        stream: ServiceMangementService().getServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No services available'));
          }

          final services = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  leading: service.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            service.imageUrl!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(width: 50, height: 50),
                  title: Text(
                    service.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(service.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showServiceDialog(service: service),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteService(service),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sub-Services',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          ...service.subServices.map((subService) => ListTile(
                                title: Text(subService.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Description: ${subService.discription}'),
                                    Text('Duration: ${subService.duration}'),
                                  ],
                                ),
                                trailing: const Text(
                                    '\${subService.price.toStringAsFixed(2)}'),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
