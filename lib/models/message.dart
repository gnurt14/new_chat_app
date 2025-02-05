import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chat_app/common/enums/message_enum.dart';

class Message{
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap(){
    return{
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': type.type,
      'timeSent': timeSent,
      'messageId': messageId,
      'isSeen': isSeen,
    };
}

  factory Message.fromMap(Map<String ,dynamic> map){
    return Message(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: map['timeSent'] is Timestamp
          ? (map['timeSent'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}