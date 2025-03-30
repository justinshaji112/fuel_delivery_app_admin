import 'package:flutter/widgets.dart';
import 'package:fuel_delivary_app_admin/common/dialogs/dialogs.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(BuildContext context)async{
                    XFile? image;
                    final picker = ImagePicker();
                    try {
                      image =
                          await picker.pickImage(source: ImageSource.gallery);
                      print(image!.path);
                    } catch (e) {
                      CustomDialogs.error(context, e.toString());
                    }
                    return image;
                  }