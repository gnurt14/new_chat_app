import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/loader.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../auth/controller/auth_controller.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final controller = TextEditingController();

  MobileChatScreen({
    super.key,
    required this.uid,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userStreamProvider(uid));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        foregroundColor: AppColors.textColor,
        title: userStream.when(
          data: (user) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(
                  user.isOnline ? 'online' : 'offline',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
          loading: () => const Loader(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(receiverId: uid),
          ),
          BottomChatField(receiverId: uid),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
