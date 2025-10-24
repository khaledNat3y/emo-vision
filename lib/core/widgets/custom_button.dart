import 'package:flutter/material.dart';

import '../theming/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({
    super.key,
    required this.formKey, required this.text,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        animationDuration: const Duration(milliseconds: 500),
        // padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
        elevation: 2.7,
        backgroundColor: AppColors.primary,
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // context.read<LoginCubit>().login();
        }
      },
      child: Text(text),
    );
  }
}
