import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';

class TermsAndPolicyCheckbox extends StatefulWidget {
  const TermsAndPolicyCheckbox();

  @override
  BusinessModeCheckboxState<TermsAndPolicyCheckbox> createState() =>
      BusinessModeCheckboxState<TermsAndPolicyCheckbox>();
}

class BusinessModeCheckboxState<T extends TermsAndPolicyCheckbox>
    extends State<TermsAndPolicyCheckbox> {
  late ItemEntryProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemEntryProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: PsDimens.space1),
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.grey,
            ),
            child: Checkbox(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(1)),
              // side: BorderSide(color: PsColors.primary500),
              checkColor: PsColors.baseColor,
              activeColor: PsColors.mainColor,
              value: provider.isAggreTermsAndPolicy,
              onChanged: (bool? value) {
                updateCheckBox(context);
              },
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.privacyPolicy);
              },
              child: Container(
                padding: const EdgeInsets.only(left: PsDimens.space4),
                height: PsDimens.space24,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Directionality.of(context) == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text(
                    'Я согласен с условиями и политикой.'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateCheckBox(BuildContext context) {
    setState(() {
      if (provider.isAggreTermsAndPolicy) {
        provider.isAggreTermsAndPolicy = false;
      } else {
        provider.isAggreTermsAndPolicy = true;
      }
    });
  }
}
