import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../custom_ui/item/list_item/product_horizontal_list_widget.dart';
import '../../../../common/ps_list_header_widget.dart';

class RelatedProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RelatedProductProvider relatedProductProvider =
        Provider.of<RelatedProductProvider>(context);
    if (relatedProductProvider.hasData)
      return SliverToBoxAdapter(
        child: Column(
          children: <Widget>[
            PsListHeaderWidget(
              headerName: 'related_product_tile__related_product'.tr,
              headerDescription: '',
              viewAllClicked: () {
                viewAllRelatedItemsClicked(context);
              },
            ),
            CustomProductHorizontalListWidget(
              tagKey: relatedProductProvider.hashCode.toString(),
              productList: relatedProductProvider.relatedProductList.data,
              isLoading: relatedProductProvider.currentStatus ==
                  PsStatus.BLOCK_LOADING,
            ),
          ],
        ),
      );
    else
      return const SliverToBoxAdapter(
        child: SizedBox(),
      );
  }

  void viewAllRelatedItemsClicked(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    Navigator.pushNamed(context, RoutePaths.relatedProductList,
        arguments: RequestPathHolder(
            categoryId: itemDetailProvider.product.catId,
            productId: itemDetailProvider.product.id));
  }
}
