import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/user/forgot_password/component/widgets/password_update/update_forgot_pwd_back_widget.dart';
import '../../../../custom_ui/user/forgot_password/component/widgets/password_update/update_forgot_pwd_button.dart';
import '../../../common/ps_header_icon_and_dynamic_text_widget.dart';
import '../../../common/ps_textfield_widget.dart';

class UpdateForgotPasswordView extends StatefulWidget {
  const UpdateForgotPasswordView(
      {Key? key,
      required this.userId,
      this.goToLoginSelected,
      this.goToVerifyPasswordSelected})
      : super(key: key);

  final String userId;
  final Function? goToLoginSelected;
  final Function? goToVerifyPasswordSelected;

  @override
  _UpdateForgotPasswordViewState createState() =>
      _UpdateForgotPasswordViewState();
}

class _UpdateForgotPasswordViewState extends State<UpdateForgotPasswordView> {
  UserRepository? userRepo;
  PsValueHolder? psValueHolder;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    userRepo = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return ChangeNotifierProvider<UserProvider>(
        lazy: false,
        create: (BuildContext context) {
          final UserProvider provider =
              UserProvider(repo: userRepo, psValueHolder: psValueHolder);
          return provider;
        },
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider provider, Widget? child) {
          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PsHeaderIconAndDynamicTextWidget(
                      text: 'forgot_psw__update_password_title'.tr),
                  PsTextFieldPasswordWidget(
                      height: 40,
                      titleText: 'change_password__password'.tr,
                      textAboutMe: false,
                      hintText: 'Введите пароль',
                      textEditingController: passwordController),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: PsDimens.space16,
                      right: PsDimens.space16,
                    ),
                    child: Text(
                      'Ваш пароль должен состоять не менее чем из 6 символов'.tr,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.secondary400
                              : PsColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: PsDimens.space8,
                  ),
                  PsTextFieldPasswordWidget(
                      height: 40,
                      titleText: 'change_password__confirm_password'.tr,
                      textAboutMe: false,
                      hintText: 'Введите пароль',
                      textEditingController: confirmPasswordController),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: PsDimens.space16, right: PsDimens.space16),
                    child: Text(
                      'Ваш пароль должен состоять не менее чем из 6 символов'.tr,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.secondary400
                              : PsColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomUpdateForgotPasswordSaveButton(
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    userId: widget.userId,
                    goToLoginSelected: widget.goToLoginSelected,
                  ),
                  CustomUpdateForgotPasswordBackWidget(
                      goToVerifyPasswordSelected:
                          widget.goToVerifyPasswordSelected),
                ]),
          );
        }));
  }
}
