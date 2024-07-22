import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/common/utils/utils.dart';
import 'package:new_chat_app/core/configs/constants/app_urls.dart';
import 'package:new_chat_app/features/auth/controller/auth_controller.dart';

import '../../../core/configs/theme/app_colors.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';

  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.clear();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      print('Storing user data: $name');
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    } else {
      print('Name is empty');
      showSnackBar(context: context, content: "Name cannot be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(AppUrls.defaultAvatar),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      style: const TextStyle(
                        color: AppColors.textColor,
                      ),
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(
                            color: AppColors.textColor,
                          )),
                    ),
                  ),
                  IconButton(
                    onPressed: storeUserData,
                    icon: const Icon(Icons.done),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
