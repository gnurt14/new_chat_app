import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:new_chat_app/features/chat/widgets/my_message_card.dart';
import 'package:new_chat_app/features/chat/controller/chat_controller.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../models/message.dart';
import 'my_message_other_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverId;

  const ChatList({super.key, required this.receiverId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose(){
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatStream = ref.watch(chatControllerProvider).chatStream(widget.receiverId);

    return StreamBuilder<List<Message>>(
      stream: chatStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Text(
              'An error occurred, please try again',
              style: TextStyle(
                color: AppColors.textColor,
              ),
            ),
          );
        }

        SchedulerBinding.instance.addPostFrameCallback((_){
          messageController.jumpTo(messageController.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: messageController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var messages = snapshot.data![index];
            if (messages.senderId == FirebaseAuth.instance.currentUser!.uid) {
              return MyMessageCard(
                message: messages.text,
                date: DateFormat.Hm().format(messages.timeSent),
                type: messages.type,
              );
            } else {
              return MyMessageOtherCard(
                message: messages.text,
                date: DateFormat.Hm().format(messages.timeSent),
                type: messages.type,
              );
            }
          },
        );
      },
    );
  }
}
