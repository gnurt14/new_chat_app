import 'package:flutter/material.dart';
import 'package:new_chat_app/features/select_contacts/screens/select_contacts_screen.dart';

import '../core/configs/theme/app_colors.dart';
import '../features/chat/widgets/contact_list.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        foregroundColor: AppColors.textColor,
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.greyColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.greyColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SelectContactsScreen.routeName);
        },
        backgroundColor: AppColors.buttonColor,
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
      body: ContactList(),
    );
  }
}
