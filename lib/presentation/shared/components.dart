import 'package:flutter/material.dart';
import 'package:notes/styles/colors.dart';

class DefaultTextFormFiled extends StatelessWidget {
  const DefaultTextFormFiled({
    super.key,
    this.controller,
    this.maxline,
    this.onSaved,
    this.onChanged,
    this.onTap,
    required this.hint,
  });

  final TextEditingController? controller;
  final int? maxline;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'this filed is required';
        } else {
          return null;
        }
      },
      controller: controller,
      maxLines: maxline,
      onTap: onTap,
      onChanged: onChanged,
      onSaved: onSaved,
      cursorColor: darkBlue,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: beige),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}

class ToDoTextFormFiled extends StatelessWidget {
  const ToDoTextFormFiled(
      {super.key,
      this.controller,
      this.maxline,
      this.onSaved,
      this.onChanged,
      this.onTap,
      this.label,
      this.prefix,
      this.keyboardType});
  final String? label;
  final int? maxline;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final IconData? prefix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'this filed is required';
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      onSaved: onSaved,
      cursorColor: darkBlue,
      maxLines: maxline,
      decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: darkBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: darkBlue),
          )),
    );
  }
}
