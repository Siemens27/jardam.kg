import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class ResetAndApplyWidget extends StatelessWidget {
  const ResetAndApplyWidget({
    Key? key,
    required this.handleApply,
    required this.handleReset,
  }) : super(key: key);
  final Function handleReset;
  final Function handleApply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PsDimens.space16, vertical: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                handleReset();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: PsColors.secondary50,
                  border: Border.all(
                    color: PsColors.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(PsDimens.space4),
                ),
                alignment: Alignment.center,
                height: 40,
                width: double.infinity,
                child: Text(
                  'Сброс'.tr,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: PsColors.secondary800,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                handleApply();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: PsColors.mainColor,
                  borderRadius: BorderRadius.circular(PsDimens.space4),
                ),
                alignment: Alignment.center,
                height: 40,
                width: double.infinity,
                child: Text(
                  'Применить'.tr,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: PsColors.secondary50, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
