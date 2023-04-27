import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../../custom_ui/chat/component/list/widgets/seller/chat_seller_list_data.dart';
import '../../../../../custom_ui/chat/component/list/widgets/seller/chat_seller_list_empty_box.dart';
import '../../../../common/ps_ui_widget.dart';

class ChatSellerListView extends StatefulWidget {
  const ChatSellerListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatSellerListViewState();
}

class _ChatSellerListViewState extends State<ChatSellerListView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SellerChatHistoryListProvider _provider =
        Provider.of<SellerChatHistoryListProvider>(context);
    animationController.forward();
    return Column(
      children: <Widget>[
        Flexible(
          child: RefreshIndicator(
              child: (_provider.hasData)
                  ? CustomChatSellerListData(
                      animationController: animationController,
                    )
                  : (_provider.currentStatus == PsStatus.SUCCESS &&
                          !_provider.hasData)
                      ? CustomChatSellerListEmptyBox()
                      : const SizedBox(),
              onRefresh: () {
                _provider.resetShowProgress();
                return _provider.loadDataList(reset: true);
              }),
        ),
        if (_provider.showProgress)
          PSProgressIndicator(_provider.currentStatus)
        else
          const PSProgressIndicator(PsStatus.NOACTION)
      ],
    );
  }
}
