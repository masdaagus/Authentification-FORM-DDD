import 'package:flutter/material.dart';
import '../../core/constant/constant.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.onChanged,
    this.validator,
    this.label,
    this.iconData,
    this.controller,
    this.isNum = false,
  }) : super(key: key);

  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final String? label;
  final TextEditingController? controller;
  final IconData? iconData;
  final bool isNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        keyboardType: isNum ? TextInputType.number : null,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          label: Text(label ?? ''),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: Icon(
            iconData ?? Icons.person_outline_outlined,
          ),
          labelStyle: const TextStyle(color: cGrey, fontSize: 14),
        ),
      ),
    );
  }
}
