import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/common/widgets/error.dart';
import 'package:new_chat_app/common/widgets/loader.dart';
import 'package:new_chat_app/core/configs/constants/is_dark.dart';
import 'package:new_chat_app/features/select_contacts/controller/select_contact_controller.dart';

import '../../../core/configs/theme/app_colors.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';

  const SelectContactsScreen({super.key});

  void selectContact(WidgetRef ref, Contact contact, BuildContext context){
    ref.read(selectContactControllerProvider).selectContact(contact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Data'),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
          data: (contactList) => ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              final contact = contactList[index];
              return InkWell(
                onTap: () => selectContact(ref, contact, context),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      contact.displayName,
                      style: TextStyle(
                        color: context.isDarkMode ? AppColors.textColor:  AppColors.darkTextColor,
                        fontSize: 18,
                      ),
                    ),
                    leading: contact.photo == null
                        ? null
                        : CircleAvatar(
                      backgroundImage: MemoryImage(contact.photo!),
                      radius: 30,
                    ),
                  ),
                ),
              );
            },
          ),
          error: (err, trace) => ErrorScreen(error: err.toString(),),
          loading: () => const Loader()),
    );
  }
}
