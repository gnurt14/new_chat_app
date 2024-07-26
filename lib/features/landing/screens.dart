import 'package:flutter/material.dart';
import 'package:new_chat_app/common/widgets/custom_button.dart';
import 'package:new_chat_app/core/assets/app_images.dart';
import 'package:new_chat_app/features/auth/screens/login_screen.dart';
import '../../core/configs/theme/app_colors.dart';

class LandingScreen extends StatelessWidget{
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              const Text(
                'Welcome to Whatsapp',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: size.height / 9,),
              Image.asset(
                AppImages.introBG,
                height: 340,
                width: 340,
                color: AppColors.tabColor,
              ),
              SizedBox(height: size.height / 9,),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service',
                  style: TextStyle(
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                  text: 'AGREE AND CONTINUE',
                  onPressed: (){
                    navigateToLoginScreen(context);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}