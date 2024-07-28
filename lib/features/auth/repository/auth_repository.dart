import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/common/repositories/common_firebase_storage_repository.dart';
import 'package:new_chat_app/common/utils/utils.dart';
import 'package:new_chat_app/features/auth/screens/otp_screen.dart';
import 'package:new_chat_app/features/auth/screens/user_information_screen.dart';
import 'package:new_chat_app/models/user_model.dart';

import '../../../core/configs/constants/app_urls.dart';
import '../../../screens/mobile_layout_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) {
    return auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        throw Exception(e.message);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        Navigator.pushNamed(context, OTPScreen.routeName,
            arguments: verificationId);
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }


  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );

      // Sign in with the credential
      UserCredential userCredential = await auth.signInWithCredential(credential);
      String uid = userCredential.user!.uid;

      // Check if the user exists in the database
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      print("User document: ${userDoc.data()}");
      print("User exists: ${userDoc.exists}");

      if (userDoc.exists) {
        // User exists, navigate to the home screen
        print("User already exists in the database: $uid");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const MobileLayoutScreen()),
              (route) => false,
        );
      } else {
        // User does not exist, save user info and navigate to user information screen
        print("User does not exist in the database, creating new user: $uid");
        Navigator.pushNamedAndRemoveUntil(
          context,
          UserInformationScreen.routeName,
              (route) => false,
        );
      }
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.message}");
      showSnackBar(context: context, content: e.message!);
    } catch (e) {
      print("Exception: $e");
    }
  }


  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      if (auth.currentUser == null) {
        throw Exception("User not logged in");
      }

      String uid = auth.currentUser!.uid;
      String photoUrl = AppUrls.defaultAvatar;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePic/$uid', profilePic);
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser!.phoneNumber ?? '',
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const MobileLayoutScreen()),
          (route) => false);
    } catch (e) {
      print("Error saving user data to Firebase: $e");
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }
}
