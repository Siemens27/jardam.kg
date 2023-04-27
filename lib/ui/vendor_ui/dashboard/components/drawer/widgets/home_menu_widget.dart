import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({this.updateSelectedIndexWithAnimation});
  final Function? updateSelectedIndexWithAnimation;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: PsColors.baseColor,
      child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: SizedBox(
              width: 16,
              height: 18,
              child: SvgPicture.asset(
                'assets/images/home_bottom.svg',
                color: Utils.isLightMode(context)
                    ? PsColors.secondary800
                    : PsColors.primaryDarkWhite,
              ),
            ),
          ),
          minLeadingWidth: 0,
          title: Text(
            'home__drawer_menu_home'.tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.pop(context);
            if (updateSelectedIndexWithAnimation != null) {
              updateSelectedIndexWithAnimation!('home__drawer_menu_home'.tr,
                  PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT);
            }
          }),
    );
  }
}
