
import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/controller/carousel_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/global.dart';
import 'package:fuel_delivary_app_admin/model/carousel_model.dart';
import 'package:fuel_delivary_app_admin/view/dialog/carousel_dialogs.dart';

class CarouselDatasource extends DataTableSource {
  final List<CarouselModel> carousels;
  final CarouselWidgetController carouselController;
  final Function(CarouselModel) onEdit;
  

  CarouselDatasource(
      {required this.carouselController,
      required this.carousels,
      required this.onEdit});

  @override
  DataRow? getRow(
    int index,
  ) {

    if (index >= carousels.length) return null;

    CarouselModel carousel = carousels[index];
    return DataRow(cells: [
      DataCell(Text(carousel.id ?? '')),
      DataCell(Image.network(carousel.image)),
      DataCell(Text(carousel.title)),
      DataCell(Text(carousel.subTitle)),
      DataCell(Text(carousel.weight.toString())),
      
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              BuildContext? context = navigatorKey.currentContext;
              if (context != null) {
                 ImageController imageController = ImageController();
                CarouselDialogs.addEditCarouselDialog(context,
                    carouselController: carouselController, carousel: carousel,imageController:imageController );
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
                    "Delete Carousel",
                    "Are you sure you want to delete this carousel ?");
                if (delete != null && delete) {
                  carouselController.deleteCarousel(carousel.id!);
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
  int get rowCount => carousels.length; // Use the passed carousels list length

  @override
  int get selectedRowCount => 0;
}
