import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:fuel_delivary_app_admin/controller/offer_controller.dart';
import 'package:fuel_delivary_app_admin/controller/image_controller.dart';
import 'package:fuel_delivary_app_admin/global.dart';
import 'package:fuel_delivary_app_admin/model/offer_model.dart';
import 'package:fuel_delivary_app_admin/view/dialog/offer_dailog.dart';

class OfferDatasource extends DataTableSource {
  final List<OfferModel> offers;
  final OfferController offerController;
  final Function(OfferModel) onEdit;

  OfferDatasource(
      {required this.offerController,
      required this.offers,
      required this.onEdit});

  @override
  DataRow? getRow(
    int index,
  ) {
    // DataColumn(label: Text('ID')),
    //                         DataColumn(label: Text('Name')),
    //                         DataColumn(label: Text('Offer')),
    //                         DataColumn(label: Text('Price range')),
    //                         DataColumn(label: Text('Status')),
    //                         DataColumn(label: Text('Actions')),
    // Use the offers list parameter instead of controller's filteredOffers directly
    if (index >= offers.length) return null;

    OfferModel offer = offers[index];
    return DataRow(cells: [
      DataCell(Text(offer.id ?? '')),
      DataCell(Text(offer.name)),
      DataCell(Text(offer.offerPercentage.toString())),
      DataCell(Text(
          "${offer.startingPrice.toString()} - ${offer.endingPrice.toString()}")),
      DataCell(Chip(
        label: offer.status == false
            ? const Text(
                "Blocked",
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                "Active",
                style: const TextStyle(color: Colors.white),
              ),
        color: MaterialStateProperty.all(
            offer.status == false ? Colors.red : Colors.green),
      )),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              BuildContext? context = navigatorKey.currentContext;
              if (context != null) {
            
                OfferDialog.addEditOfferDialog(context,
                    offerController: offerController, offer: offer);
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
                    "Delete Offer",
                    "Are you sure you want to delete this offer ?");
                if (delete != null && delete) {
                  offerController.deleteOffer(offer.id!);
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
  int get rowCount => offers.length; // Use the passed offers list length

  @override
  int get selectedRowCount => 0;
}
