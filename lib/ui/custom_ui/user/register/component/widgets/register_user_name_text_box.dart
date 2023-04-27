import 'package:flutter/material.dart';

import '../../../../../vendor_ui/user/register/component/widgets/register_user_name_text_box.dart';

class CustomRegisterUserNameTextBox extends StatelessWidget {
  const CustomRegisterUserNameTextBox({
    required this.nameController,
  });

  final TextEditingController? nameController;
  @override
  Widget build(BuildContext context) {
    return RegisterUserNameTextBox(nameController: nameController);
  }
}
