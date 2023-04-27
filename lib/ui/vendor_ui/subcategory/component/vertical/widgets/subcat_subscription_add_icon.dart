import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class SubscriptionAddIcon extends StatelessWidget {
  const SubscriptionAddIcon(
      {required this.subCategoryProvider, required this.changeMode});
  final SubCategoryProvider subCategoryProvider;
  final Function changeMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.notification_add_outlined, color: PsColors.iconColor),
      onPressed: () async {
        if (await Utils.checkInternetConnectivity()) {
          Utils.navigateOnUserVerificationView(context, () {
            changeMode();
            subCategoryProvider.loadDataList(
              reset: true,
            );
          });
        }
      },
    );
  }
}
