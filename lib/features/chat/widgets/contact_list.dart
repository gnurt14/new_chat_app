import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:new_chat_app/core/configs/constants/is_dark.dart';
import 'package:new_chat_app/features/chat/controller/chat_controller.dart';
import 'package:new_chat_app/features/chat/screen/mobile_chat_screen.dart';
import 'package:new_chat_app/models/chat_contact.dart';
import '../../../core/configs/theme/app_colors.dart';

class ContactList extends ConsumerWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<List<ChatContact>>(
        stream: ref.watch(chatControllerProvider).chatContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'An error occurred, please try again',
                style: TextStyle(
                  color: context.isDarkMode
                      ? AppColors.textColor
                      : AppColors.darkTextColor,
                ),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var chatContactData = snapshot.data![index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MobileChatScreen.routeName,
                          arguments: {
                            'name': chatContactData.name,
                            'uid': chatContactData.contactId,
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          chatContactData.name,
                          style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.textColor
                                : AppColors.darkTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            chatContactData.lastMessage,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? AppColors.textColor
                                  : AppColors.greyColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            chatContactData.profilePic,
                          ),
                        ),
                        trailing: Text(
                          DateFormat.Hm().format(chatContactData.timeSent),
                          style: TextStyle(
                            color: context.isDarkMode
                                ? AppColors.textColor
                                : AppColors.greyColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
