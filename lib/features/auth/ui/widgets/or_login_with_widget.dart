import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrLoginWith extends StatelessWidget {
  const OrLoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1, color: theme.dividerColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Or login with', style: theme.textTheme.titleSmall),
          ),
          Expanded(child: Divider(thickness: 1, color: theme.dividerColor)),
        ],
      ),
    );
  }
}
