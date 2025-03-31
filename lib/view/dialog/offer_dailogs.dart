import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/offer_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/model/offer_model.dart';
import 'package:fuel_delivary_app_admin/utils/validators/form_validators.dart';
import 'package:fuel_delivary_app_admin/view/widgets/add_service_button.dart';
import 'package:fuel_delivary_app_admin/view/widgets/image_picker_widget.dart';

class OfferDialog {
  OfferDialog._();
  static Future<dynamic> addEditOfferDialog(
    BuildContext context, {
    OfferModel? offer,
    required OfferController offerController,
  }) {
    final nameController = TextEditingController(text: offer?.name ?? '');
    final offerPercentageController = TextEditingController(
        text: offer?.offerPercentage == null
            ? ""
            : offer!.offerPercentage.toString());
    final startingPriceController = TextEditingController(
        text: offer?.startingPrice == null
            ? ""
            : offer!.startingPrice.toString());
    final endingPriceController = TextEditingController(
        text: offer?.endingPrice == null ? "" : offer!.endingPrice.toString());
    final descriptionController =
        TextEditingController(text: offer?.description ?? "");

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? selectedStatus = offer?.status ?? false ? "Active" : "Inactive";

    BuildContext buildContext = context;

    return showDialog(
      context: buildContext,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(offer == null ? 'Add New Offer' : 'Edit Offer'),
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
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name of the offer',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid name"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid description"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: offerPercentageController,
                      decoration: const InputDecoration(
                        labelText: 'Offer percentage',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid number"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: startingPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Offer Starting form Rs',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid number"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: endingPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Offer applied till',
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
                // Save offer logic
                if (offer == null) {
                  if (formKey.currentState!.validate()) {
                    await offerController.addOffer(
                        nameController.text,
                        double.parse(startingPriceController.text),
                        double.parse(endingPriceController.text),
                        descriptionController.text,
                        double.parse(offerPercentageController.text));
                  }
                  Navigator.pop(context);
                } else {
                  if (formKey.currentState!.validate()) {
                    offer.name = nameController.text;
                    offer.endingPrice =
                        double.parse(endingPriceController.text);
                    offer.startingPrice =
                        double.parse(startingPriceController.text);
                    offer.offerPercentage =
                        double.parse(offerPercentageController.text);
                    offer.description = descriptionController.text;

                    offer.status = selectedStatus == "Active" ? true : false;

                    await offerController.updateOffer(offer);
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
