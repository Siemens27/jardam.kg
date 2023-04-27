import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';

class PriceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final Product product = itemDetailProvider.product;
    final String? currencySymbol = product.itemCurrency?.currencySymbol ?? '';
    //check whether to show original price or discounted price
    final String? currentPrice =
        product.isDiscountedItem && psValueHolder.isShowDiscount!
            ? product.currentPrice
            : product.originalPrice;

    /** UI Section is here */
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
            top: PsDimens.space8,
            left: PsDimens.space16,
            right: PsDimens.space16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    isPriceEmpty(currentPrice)
                        ? 'item_price_free'.tr
                        : '$currencySymbol ${Utils.getPriceFormat(currentPrice!, psValueHolder.priceFormat!)}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: PsColors.mainColor,
                        fontSize: 21,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: PsDimens.space10,
                ),
                Text(
                  product.addedDateStr!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: PsColors.textColor2,
                        fontSize: 13,
                      ),
                )
              ],
            ),
            if (psValueHolder.isShowDiscount! && product.isDiscountedItem)
              Row(
                children: <Widget>[
                  Text(
                    //original price
                    '$currencySymbol ${Utils.getPriceFormat(product.originalPrice ?? '', psValueHolder.priceFormat!)}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.txtPrimaryLightColor
                            : PsColors.primaryDarkGrey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12),
                  ),
                  const SizedBox(width: PsDimens.space6),
                  Text(
                    '-${product.discountRate}%',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.txtPrimaryLightColor
                            : PsColors.primaryDarkGrey,
                        fontSize: 12),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  bool isPriceEmpty(String? price) {
    return price == null || price == '' || price == '0';
  }
}
