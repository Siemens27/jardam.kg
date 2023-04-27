import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/register_button.dart';

class CustomRegisterButton extends StatelessWidget {
  const CustomRegisterButton(
      {required this.nameTextEditingController,
      required this.emailTextEditingController,
      required this.passwordTextEditingController,
      this.onRegisterSelected,
      required this.callBackAfterLoginSuccess});
  final Function? onRegisterSelected, callBackAfterLoginSuccess;
  final TextEditingController? nameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;

  @override
  Widget build(BuildContext context) {
    return RegisterButton(
        nameTextEditingController: nameTextEditingController,
        emailTextEditingController: emailTextEditingController,
        passwordTextEditingController: passwordTextEditingController,
        onRegisterSelected: onRegisterSelected,
        callBackAfterLoginSuccess: callBackAfterLoginSuccess,);
  }
}
