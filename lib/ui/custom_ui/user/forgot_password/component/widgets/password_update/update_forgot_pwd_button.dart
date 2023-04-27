import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/user/forgot_password/component/widgets/password_update/update_forgot_pwd_button.dart';

class CustomUpdateForgotPasswordSaveButton extends StatelessWidget {
  const CustomUpdateForgotPasswordSaveButton(
      {required this.passwordController,
      required this.confirmPasswordController,
      required this.userId,
      this.goToLoginSelected});

  final TextEditingController passwordController, confirmPasswordController;
  final String userId;
  final Function? goToLoginSelected;

  @override
  Widget build(BuildContext context) {
    return UpdateForgotPasswordSaveButton(
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        goToLoginSelected: goToLoginSelected,
        userId: userId);
  }
}
