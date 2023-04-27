import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

class EmptyPromotionTransactionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            'У вас нет активного Продвижения. \n Купить и создать продвижение'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: PsColors.txtPrimaryLightColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
