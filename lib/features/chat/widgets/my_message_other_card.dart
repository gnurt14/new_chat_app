import 'package:flutter/material.dart';
import 'package:new_chat_app/core/configs/theme/app_colors.dart';
import 'package:new_chat_app/features/chat/widgets/display_text_image_gif.dart';

import '../../../common/enums/message_enum.dart';

class MyMessageOtherCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;

  MyMessageOtherCard(
      {super.key, required this.message, required this.date, required this.type,});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery
                .of(context)
                .size
                .width * 0.75,
          ),
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: DisplayTextImageGif(
                        message: message,
                        type:type,
                      )),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
