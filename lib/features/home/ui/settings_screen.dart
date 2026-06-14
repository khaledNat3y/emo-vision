import 'package:facial_emotional_detection_graduation_project/core/di/dependency_injection.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/functions.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/app_colors.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/cubit/theme_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/core/theming/font_weight_helper.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/logic/delete_account_cubit/delete_account_cubit.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/ui/widgets/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.color?.withValues(alpha: 0.9),
                  fontSize: 24.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              Text(
                "Personalize your EmoVision experience",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.regular,
                  color: AppColors.grey.withValues(alpha: 0.9),
                ),
              ),
              verticalSpace(30.h),
              Text(
                "General Settings",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeightHelper.regular,
                  color: AppColors.primary,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    SettingsSection(
                      title: "Visit Our Website",
                      leading: const Icon(
                        Icons.language,
                        color: AppColors.primary,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primary,
                        size: 14,
                      ),
                      onTap: () async {
                        await launchUrlToEmoVisionWebsite();
                      },
                    ),
                    Divider(color: AppColors.grey.withValues(alpha: 0.3)),
                    SettingsSection(
                      title: "Dark Mode",
                      leading: Icon(
                        Icons.dark_mode,
                        color: isDarkMode ? AppColors.primary : AppColors.grey,
                      ),
                      // toggle between dark and light mode
                      trailing: Switch(
                        value: ThemeCubit.get(context).state == ThemeMode.dark,

                        onChanged: (value) {
                          ThemeCubit.get(context).toggleTheme(value);
                        },
                        activeThumbColor: AppColors.primary,
                        inactiveThumbColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withValues(
                          alpha: 0.3,
                        ),
                        inactiveTrackColor: AppColors.grey.withValues(
                          alpha: 0.15,
                        ),
                      ),
                    ),
                    Divider(color: AppColors.grey.withValues(alpha: 0.3)),
                    BlocListener<DeleteAccountCubit, DeleteAccountState>(
                      listener: (context, state) {
                        if (state is DeleteAccountSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account deleted successfully"),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        }
                        if (state is DeleteAccountError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              duration: const Duration(seconds: 5),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }

                        if (state is DeleteAccountLoading) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Deleting account..."),
                              duration: Duration(seconds: 8),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      },
                      child: SettingsSection(
                        title: "Delete Account",
                        titleColor: AppColors.error,
                        leading: const Icon(
                          Icons.person_off_outlined,
                          color: AppColors.error,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.error,
                          size: 14,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete Account"),
                                content: const Text(
                                  "Are you sure you want to delete your account? This action cannot be undone.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<DeleteAccountCubit>()
                                          .deleteAccount();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.3189,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      SvgPicture.asset("assets/svgs/question_mark.svg"),
                      Text(
                        "Need help?",
                        style: isDarkMode
                            ? Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeightHelper.regular,
                              )
                            : Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeightHelper.regular,
                              ),
                      ),
                      Text(
                        "Our support team is available 24/7 to help you optimize your emotion tracking experience.",
                        style: isDarkMode
                            ? Theme.of(context).textTheme.titleMedium
                            : Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.black.withValues(alpha: 0.5),
                                fontSize: 17.sp,
                              ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: const Text(
                          "Contact Support",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(80),
            ],
          ),
        ),
      ),
    );
  }
}
