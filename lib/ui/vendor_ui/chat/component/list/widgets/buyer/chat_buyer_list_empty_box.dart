import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/item_entry_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/ps_button_widget.dart';

class ChatBuyerListEmptyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: PsDimens.space145,
              ),
              SvgPicture.asset(
                'assets/images/chat_list_empty_photo.svg',
              ),
              const SizedBox(
                height: PsDimens.space16,
              ),
              Text('У вас нет сообщений'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Utils.isLightMode(context)
                          ? PsColors.secondary800
                          : PsColors.textColor2)),
              const SizedBox(
                height: PsDimens.space8,
              ),
              Text('Загружайте свои товары и легко продавайте их.'.tr,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.secondary500
                          : PsColors.textColor3)),
              Container(
                margin: const EdgeInsets.all(PsDimens.space16),
                child: PSButtonWidget(
                  titleText: 'Начать продавать'.tr,
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.itemEntry,
                        arguments: ItemEntryIntentHolder(
                            flag: PsConst.ADD_NEW_ITEM, item: Product()));
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
