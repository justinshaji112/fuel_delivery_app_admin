import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/offer_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/controller/offer_controller.dart';
import 'package:fuel_delivary_app_admin/model/offer_model.dart';
import 'package:fuel_delivary_app_admin/utils/validators/form_validators.dart';
import 'package:fuel_delivary_app_admin/view/dialog/offer_dailog.dart';
import 'package:fuel_delivary_app_admin/view/widgets/add_service_button.dart';
import 'package:fuel_delivary_app_admin/view/widgets/image_picker_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OfferView extends StatefulWidget {
  const OfferView({super.key});

  @override
  _OfferViewState createState() => _OfferViewState();
}

class _OfferViewState extends State<OfferView> {
  final TextEditingController _searchController = TextEditingController();


  OfferController offerController = Get.put(OfferController());

  ImageController imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => OfferDialog.addEditOfferDialog(context,
                offerController: offerController,
                ),
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
                hintText: 'Search offers...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (v) {
                offerController.filterOffers(v);
              },
            ),
            const SizedBox(height: 16),

            // Offers Data Table
            Obx(() {
              return Expanded(
                child: offerController.state.value ==
                        ControllerStates.success
                    ? Card(
                        elevation: 4,
                        child: SingleChildScrollView(
                          child: PaginatedDataTable(
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Offer')),
                              DataColumn(label: Text('Price range')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            source: offerController.getDatasource(),
                            rowsPerPage: 13,
                            dataRowHeight: 50,
                          ),
                        ),
                      )
                    : offerController.state.value == ControllerStates.error
                        ? Center(
                            child: Text(offerController.error!),
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
