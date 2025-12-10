import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? isLoading;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading == true,  // Prevents clicking while loading
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          animationDuration: const Duration(milliseconds: 500),
          elevation: 2.7,
          backgroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          isLoading! ? "Loading..." : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

