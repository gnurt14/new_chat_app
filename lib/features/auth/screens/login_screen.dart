import 'package:flutter/material.dart';
import 'package:new_chat_app/common/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import '../../../core/configs/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'WhatsApp will need to verify your phone number',
              style: TextStyle(
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: pickCountry,
                child: const Text('Pick country')
                ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                if (country != null)
                  Text(
                    '+${country!.phoneCode}',
                    style: const TextStyle(
                      color: AppColors.textColor,
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    style: const TextStyle(
                      // <-- const added
                      color: AppColors.textColor,
                    ),
                    decoration: const InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          color: AppColors.textColor,
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
              child: CustomButton(onPressed: () {}, text: 'NEXT'),
            )
          ],
        ),
      ),
    );
  }
}
