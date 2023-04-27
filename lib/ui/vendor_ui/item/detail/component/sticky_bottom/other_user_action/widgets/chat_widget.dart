import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/intent_holder/chat_history_intent_holder.dart';
import '../../../../../../common/ps_button_widget.dart';

class ChatWidget extends StatefulWidget {
  @override
  ChatWidgetState<ChatWidget> createState() => ChatWidgetState<ChatWidget>();
}

class ChatWidgetState<T extends ChatWidget> extends State<ChatWidget> {
  late ItemDetailProvider provider;
  late GetChatHistoryProvider getChatHistoryProvider;
  late PsValueHolder psValueHolder;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemDetailProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: PSButtonWithIconWidget(
          hasShadow: false,
          colorData: PsColors.buttonColor,
          icon: Icons.chat,
          textColor: PsColors.textColor5,
          iconColor: PsColors.textColor5,
          titleText: 'item_detail__chat'.tr,
          onPressed: () {
            onChatClick();
          },
        ),
      ),
    );
  }

  Future<void> onChatClick() async {
    if (await Utils.checkInternetConnectivity()) {
      Utils.navigateOnUserVerificationView(context, () async {
        Navigator.pushNamed(context, RoutePaths.chatView,
            arguments: ChatHistoryIntentHolder(
              chatFlag: PsConst.CHAT_FROM_SELLER,
              itemId: provider.product.id,
              buyerUserId: psValueHolder.loginUserId,
              sellerUserId: provider.product.addedUserId,
              userCoverPhoto: provider.product.user!.userCoverPhoto,
              userName: provider.product.user!.userName,
              itemDetail: provider.product,
            ));
      });
    }
  }
}
