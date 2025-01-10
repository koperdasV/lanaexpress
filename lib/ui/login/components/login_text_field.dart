import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/dimens.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    required this.label, super.key,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.keyboardType, this.validator,
  });
  final String label;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: AppSizes.sizeM, horizontal: AppSizes.sizeS),
              suffixIcon: suffixIcon,
              label: Text(label),
            ),
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText,
            onChanged: onChanged,
            keyboardType: keyboardType,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
