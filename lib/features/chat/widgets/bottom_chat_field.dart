import 'package:flutter/material.dart';
import '../../../core/configs/theme/app_colors.dart';

class BottomChatField extends StatefulWidget {
  TextEditingController chatController = TextEditingController();

  BottomChatField({super.key, required this.chatController});

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool isShowSendButton = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: TextField(
            onChanged: (value){
              if(value.isNotEmpty){
                setState(() {
                  isShowSendButton = true;
                });
              }
              else{
                setState(() {
                  isShowSendButton = false;
                });
              }
            },
            controller: widget.chatController,
            style: const TextStyle(
              color: AppColors.textColor,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.mobileChatBoxColor,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.gif,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              hintText: 'Type a message!',
              hintStyle: const TextStyle(color: AppColors.hintTextColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10.0),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.buttonColor,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  isShowSendButton ? Icons.send : Icons.mic,
                  color: AppColors.textColor,
                ),
              ),
            ))
      ],
    );
  }
}
