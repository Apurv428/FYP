import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color prefixIconColor = const Color(0xFF494949);
  final Color? suffixIconColor = const Color(0xFF494949);
  final VoidCallback? onSuffixIconPressed;

  MyTextField({
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                    color: prefixIconColor), // Set the color of the prefix icon
                child: prefixIcon!,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: IconTheme(
                  data: IconThemeData(
                      color:
                          suffixIconColor), // Set the color of the suffix icon
                  child: suffixIcon!,
                ),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF001F3F)),
        ),
        filled: true,
        fillColor: const Color(0xFFEEEEEE),
      ),
    );
  }
}
