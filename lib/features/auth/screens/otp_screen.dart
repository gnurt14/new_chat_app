import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/core/configs/constants/is_dark.dart';
import 'package:new_chat_app/core/configs/theme/app_colors.dart';
import 'package:new_chat_app/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'We have sent an SMS with a code',
              style: TextStyle(
                color: context.isDarkMode ? Colors.white : AppColors.darkTextColor,
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : AppColors.darkTextColor,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    color: context.isDarkMode ? Colors.white : AppColors.darkTextColor,
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
