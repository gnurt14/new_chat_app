import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/features/auth/repository/auth_repository.dart';

import '../../../models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserData();
});

final userStreamProvider = StreamProvider.autoDispose.family((ref, String uid) {
  return ref.read(authControllerProvider).userDataById(uid);
});


class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getCurrentUserData() async{
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) {
    return authRepository.signInWithPhone(context, phoneNumber);
  }


  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationId, userOTP: userOTP);
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
        name: name, profilePic: profilePic, ref: ref, context: context);
  }

  Stream<UserModel> userDataById(String userId){
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) async{
    authRepository.setUserState(isOnline);
  }
}
