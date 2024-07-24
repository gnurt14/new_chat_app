import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/features/auth/controller/auth_controller.dart';

import '../../../common/widgets/loader.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget{
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        foregroundColor: AppColors.textColor,
        title: StreamBuilder(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Loader();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(
                  snapshot.data!.isOnline ? 'online' : 'offline',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ChatList(),
            ),
            BottomChatField(chatController: controller,),
          ],
        ),
      ),
    );
  }

}