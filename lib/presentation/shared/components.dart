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
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
  });

  final TextEditingController? controller;
  final int? maxline;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final String hint;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      focusNode: focusNode,
      validator: validator,
      controller: controller,
      maxLines: maxline,
      onTap: onTap,
      onChanged: onChanged,
      onSaved: onSaved,
      cursorColor: darkBlue,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: darkBlue),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: const TextStyle(
        color: darkBlue,
        fontSize: 18,
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

class ToDoTextFormFiled extends StatelessWidget {
  const ToDoTextFormFiled({
    super.key,
    this.controller,
    this.maxline,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.label,
    this.prefix,
    this.keyboardType,
    this.enabled,
    this.hint,
  });
  final String? label;
  final int? maxline;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final IconData? prefix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final bool? enabled;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
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
        hintText: hint,
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBlue),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBlue),
        ),
      ),
      style: const TextStyle(
        color: darkBlue,
        fontSize: 18,
      ),
    );
  }
}
