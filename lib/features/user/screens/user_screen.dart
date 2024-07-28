import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/core/configs/constants/is_dark.dart';
import 'package:new_chat_app/features/landing/screens.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../them_notifier.dart';

class UserScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-screen';

  const UserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScreenState();
}


class _UserScreenState extends ConsumerState<UserScreen>{
  @override
  Widget build(BuildContext context) {
    late bool  _enable = context.isDarkMode;
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Dark mode',
                      style: TextStyle(
                        color: context.isDarkMode
                            ? AppColors.textColor
                            : AppColors.darkTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CupertinoSwitch(
                      value: _enable,
                      onChanged: (value) {
                        themeNotifier.updateTheme(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const LandingScreen(),
                    ),
                        (route) => false,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.logout,
                    color: context.isDarkMode
                        ? AppColors.textColor
                        : AppColors.darkTextColor,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Log out',
                    style: TextStyle(
                      color: context.isDarkMode
                          ? AppColors.textColor
                          : AppColors.darkTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

