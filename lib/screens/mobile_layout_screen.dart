import 'package:flutter/material.dart';
import 'package:new_chat_app/features/select_contacts/screens/select_contacts_screen.dart';

import '../core/configs/theme/app_colors.dart';

class MobileLayoutScreen extends StatelessWidget{
  const MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, SelectContactsScreen.routeName);
        },
        backgroundColor: AppColors.buttonColor,
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
    );
  }

}