import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/noti/component/appbar_noti_icon.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    required this.appBarTitle,
    required this.appBarTitleName,
    required this.currentIndex,
  });
  final String appBarTitle;
  final String appBarTitleName;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    final bool hideAppbar = (Utils.showFavoriteProduct(currentIndex) &&
            !Utils.isLoginUserEmpty(valueHolder)) ||
        Utils.showPopularProductView(currentIndex) ||
        Utils.showFeaturedProductView(currentIndex) ||
        Utils.showProfileView(currentIndex, valueHolder);

    if (hideAppbar) {
      return const SizedBox();
    }
    return AppBar(
      backgroundColor: PsColors.baseColor,
      title: Text(
        appBarTitleName == '' ? appBarTitle : appBarTitleName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold, color: PsColors.appBarTitleColor),
      ),
      titleSpacing: 0,
      elevation: 0,
      iconTheme: IconThemeData(
          color: (appBarTitle == 'home__verify_email'.tr ||
                  appBarTitle == 'home_verify_phone'.tr)
              ? PsColors.mainColor
              : PsColors.buttonColor),
      titleTextStyle: const TextStyle(
          fontFamily: PsConst.ps_default_font_family,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      actions: Utils.showHomeDashboardView(currentIndex)
          ? <Widget>[
              IconButton(
                icon: Icon(Icons.location_on_outlined,
                    color: PsColors.buttonColor),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.itemLocationList,
                  );
                },
              ),
              CustomAppbarNotiIcon(),
              const SizedBox(
                width: 8,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
