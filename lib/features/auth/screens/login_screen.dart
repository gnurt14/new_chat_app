import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_chat_app/common/utils/utils.dart';
import 'package:new_chat_app/common/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:new_chat_app/core/configs/constants/is_dark.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  bool isLoading = false;
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.clear();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() async {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        await ref
            .read(authControllerProvider)
            .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
      } catch (e) {
        showSnackBar(context: context, content: e.toString());
      }
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enter your phone number',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.textColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'WhatsApp will need to verify your phone number',
                style: TextStyle(
                  color:context.isDarkMode ? Colors.white : AppColors.darkTextColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: pickCountry, child: const Text('Pick country')),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if (country != null)
                    Text(
                      '+${country!.phoneCode}',
                      style: TextStyle(
                        color:context.isDarkMode ? Colors.white : AppColors.darkTextColor,
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : AppColors.darkTextColor,
                      ),
                      decoration: InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: TextStyle(
                            color: context.isDarkMode ? Colors.white : AppColors.darkTextColor,
                            fontWeight: FontWeight.w300,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.6,
              ),
              SizedBox(
                width: 90,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(onPressed: sendPhoneNumber, text: 'NEXT'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
