import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/features/auth/controller/auth_controller.dart';
import 'package:new_chat_app/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:new_chat_app/features/user/screens/user_screen.dart';

import '../core/configs/theme/app_colors.dart';
import '../features/chat/widgets/contact_list.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textColor,
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, UserScreen.routeName);
            },
            icon: const Icon(
              Icons.person,
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
      body: const ContactList(),
    );
  }
}
