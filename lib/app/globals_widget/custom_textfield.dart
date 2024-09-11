import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/style.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;

  const CustomTextfield({
    super.key,
    this.controller,
    this.focusNode,
    this.maxLength,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              labelText!,
              style: bodyMedium.copyWith(
                color: CustomColors.wireframe700,
                height: 1,
              ),
            ),
          ),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          maxLength: maxLength,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColors.wireframe300,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColors.wireframe300,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColors.wireframe700,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            hintText: hintText,
            hintStyle: subtle.copyWith(
              color: CustomColors.wireframe400,
            ),
            suffixIcon: suffixIcon,
          ),
          onTapOutside: (_) => focusNode?.unfocus(),
          validator: validator,
        ),
      ],
    );
  }
}
