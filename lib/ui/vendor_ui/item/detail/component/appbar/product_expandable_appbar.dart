import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/paid_ad_status_widget.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/pop_up_menu_widget.dart';
import '../../../../../custom_ui/item/detail/component/appbar/widgets/product_detail_gallery_view.dart';
import '../../../../common/ps_back_button_with_circle_bg_widget.dart';

class ProductExpandableAppbar extends StatelessWidget {
  const ProductExpandableAppbar({required this.isReadyToShowAppBarIcons});
  final bool isReadyToShowAppBarIcons;

  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
    final Product product = provider.product;
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);

    /**UI Section is here */
    return SliverAppBar(
      automaticallyImplyLeading: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      expandedHeight: PsDimens.space300,
      iconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: PsColors.primaryDarkWhite),
      leading: PsBackButtonWithCircleBgWidget(
          isReadyToShow: isReadyToShowAppBarIcons),
      floating: false,
      pinned: false,
      stretch: true,
      actions: <Widget>[
        Visibility(
          visible: isReadyToShowAppBarIcons,
          child: const CustomPopUpMenuWidget(),
        ),
      ],
      backgroundColor: PsColors.primaryDarkDark,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: PsColors.backgroundColor,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              const CustomProductDetailGalleryView(),
              Container(
                margin: const EdgeInsets.only(
                    left: PsDimens.space4,
                    right: PsDimens.space4,
                    bottom: PsDimens.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if (Utils.isOwnerItem(psValueHolder, product))
                      CustomPaidAdStatusWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
