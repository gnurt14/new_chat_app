import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app/common/enums/message_enum.dart';
import 'package:new_chat_app/features/chat/widgets/video_player_item.dart';

import '../../../core/configs/theme/app_colors.dart';

class DisplayTextImageGif extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGif({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : CachedNetworkImage(imageUrl: message);
  }
}
