import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

class EmptyTransactionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            'You have no active package. \n Buy and create post'.tr,
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
