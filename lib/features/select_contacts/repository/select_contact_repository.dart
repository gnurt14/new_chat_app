import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:new_chat_app/common/utils/utils.dart';
import 'package:new_chat_app/models/user_model.dart';
import 'package:new_chat_app/features/chat/screen/mobile_chat_screen.dart';
import 'package:riverpod/riverpod.dart';

final selectContactsRepositoryProvider = Provider(
    (ref) => SelectContactRepository(
        firestore: FirebaseFirestore.instance
    ),
);

class SelectContactRepository{
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async{
    List<Contact> contacts = [];
    try{
      if(await FlutterContacts.requestPermission()) {
       contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch(e){
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context)async{
    try{
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData =UserModel.fromMap(document.data());
        var modifiedUserDataPhoneNumber = userData.phoneNumber.replaceAll('+84', '0');
        String selectedPhoneNumber = selectedContact.phones[0].number.replaceAll(' ', '');

        if (selectedPhoneNumber.toLowerCase() == modifiedUserDataPhoneNumber.toLowerCase()) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName, arguments: {
            'name': userData.name,
            'uid': userData.uid,
          });
        }
      }

      if (!isFound) {
        showSnackBar(context: context, content: 'This number does not exist on the app.');
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}