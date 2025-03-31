import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/controller/carousel_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/model/carousel_model.dart';
import 'package:fuel_delivary_app_admin/utils/validators/form_validators.dart';
import 'package:fuel_delivary_app_admin/view/widgets/add_service_button.dart';
import 'package:fuel_delivary_app_admin/view/widgets/image_picker_widget.dart';

class CarouselDialogs {
  CarouselDialogs._();
  static Future<dynamic> addEditCarouselDialog(
    BuildContext context, {
    CarouselModel? carousel,
    required ImageController imageController,
    required CarouselWidgetController carouselController,
  }) {
    final titleController = TextEditingController(text: carousel?.title ?? '');
    final subtitleController =
        TextEditingController(text: carousel?.subTitle ?? '');
    final weightController =
        TextEditingController(text: carousel?.weight.toString() ?? '');

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    BuildContext buildContext = context;

    return showDialog(
      context: buildContext,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(carousel == null ? 'Add New Carousel' : 'Edit Carousel'),
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
                      imageUrl: carousel?.image,
                      image: imageController,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter valid title"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: subtitleController,
                      decoration: const InputDecoration(
                        labelText: 'subtitle',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => FormValidators.textValidator(
                          value, "Enter a valid text"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
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
                // Save carousel logic
                if (carousel == null) {
                  bool validate = _formKey.currentState!.validate();
                  log("validate value $validate");
                  if (imageController.image != null && validate) {
                    await carouselController.addCarousel(
                        imageController.image!,
                        titleController.text,
                        subtitleController.text,
                        int.parse(weightController.text));
                  }
                  Navigator.pop(context);
                } else {
                  if (_formKey.currentState!.validate()) {
                    carousel.title = titleController.text;
                    carousel.subTitle = subtitleController.text;
                    carousel.weight = int.parse(weightController.text);

                    await carouselController.updateCarousel(
                        carousel, imageController.image);
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
