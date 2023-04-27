import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../core/vendor/viewobject/product_relation.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final Product product = itemDetailProvider.product;
    const String itemContidionCustomId = 'ps-itm00004';
    final int index = product.productRelation!.indexWhere(
        (ProductRelation element) =>
            element.coreKeyId == itemContidionCustomId);
    final bool showCustomData = index >= 0 &&
        product.productRelation?.elementAt(index).selectedValues?[0].value !=
            '';

    const String itemAddress = 'ps-itm00009'; 
    final int index2 = product.productRelation!.indexWhere(
        (ProductRelation element) =>
            element.coreKeyId == itemAddress);
    // final bool showCustomDataAddress = index2 >= 0 &&
    //     product.productRelation?.elementAt(index).selectedValues?[0].value !=
    //         '';

    /** UI Section is here */
    return SliverToBoxAdapter(
      child: Consumer<ItemEntryFieldProvider>(builder: (BuildContext context,
          ItemEntryFieldProvider provider, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(
              top: PsDimens.space12,
              left: PsDimens.space16,
              right: PsDimens.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  if (psValueHolder.isUseGoogleMap!) {
                    await Navigator.pushNamed(context, RoutePaths.googleMapPin,
                        arguments: MapPinIntentHolder(
                            flag: PsConst.PIN_MAP,
                            mapLat: product.lat,
                            mapLng: product.lng));
                  } else {
                    await Navigator.pushNamed(context, RoutePaths.mapPin,
                        arguments: MapPinIntentHolder(
                            flag: PsConst.PIN_MAP,
                            mapLat: product.lat,
                            mapLng: product.lng));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          color: PsColors.iconColor,
                          size: 24,
                        ),
                        const SizedBox(
                          width: PsDimens.space8,
                        ),
                         Text(
                                    product.productRelation
                                    ?.elementAt(index2)
                                    .selectedValues?[0]
                                    .value ?? '',
                                    overflow: TextOverflow.ellipsis,                            
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: PsColors.textColor2,
                                          fontSize: 16,
                                        ),
                                      maxLines: 2,
                                  ),
                    
                        if ( product.productRelation
                              ?.elementAt(index2)
                              .selectedValues?[0]
                              .value == '' )
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.itemLocation!.name ?? ' ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: PsColors.textColor2,
                                    fontSize: 16,
                                  ),
                            ),
                            Text(
                              product.itemLocationTownship!.townshipName ?? ' ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: PsColors.textColor2,
                                    fontSize: 16,
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              if (showCustomData)
                Container(
                  decoration: BoxDecoration(
                    color: PsColors.primary50, //PsColors.primary50,
                    borderRadius: BorderRadius.circular(PsDimens.space6),
                  ),
                  height: 28,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Center(
                    child: Text(
                      product.productRelation
                              ?.elementAt(index)
                              .selectedValues?[0]
                              .value ??
                          '',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: PsColors.primary400,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  bool isPriceEmpty(String? price) {
    return price == null || price == '' || price == '0';
  }
}
