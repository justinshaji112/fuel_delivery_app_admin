import 'package:flutter/material.dart';

class AddServiceButton extends StatelessWidget {
  final Function() onTap;
  final String label;
  final IconData? icon;
   const AddServiceButton({super.key, required this.onTap,required this.label,this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: onTap, label:Text(label) ,icon:icon!=null? Icon(icon):const Icon(Icons.add),);
  }
}