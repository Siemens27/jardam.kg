import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../common/bluemark_icon.dart';
import '../../common/ps_hero.dart';
import '../../common/ps_ui_widget.dart';
import '../../common/shimmer_item.dart';

class ProductVeticalListItem extends StatelessWidget {
  const ProductVeticalListItem(
      {Key? key,
      required this.product,
      this.onTap,
      this.coreTagKey,
      required this.animationController,
      required this.animation,
      this.isLoading = false})
      : super(key: key);

  final Product product;
  final Function? onTap;
  final AnimationController animationController;
  final Animation<double> animation;
  final String? coreTagKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    //print("${PsConfig.ps_app_image_thumbs_url}${subCategory.defaultPhoto.imgPath}");
    animationController.forward();
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final bool showDiscount =
        valueHolder.isShowDiscount! && product.isDiscountedItem;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: animation,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - animation.value), 0.0),
                child: child));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: PsDimens.space4, vertical: PsDimens.space8),
        child: isLoading
            ? const ShimmerItem()
            : GestureDetector(
                onTap: () {
                  onDetailClick(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.isLightMode(context)
                        ? PsColors.secondary50
                        : PsColors.cardBackgroundColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(PsDimens.space8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity, //PsDimens.space180,
                              height: double.infinity,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(PsDimens.space6),
                                child: PsNetworkImage(
                                  photoKey:
                                      '$coreTagKey${product.id}${PsConst.HERO_TAG__IMAGE}',
                                  defaultPhoto: product.defaultPhoto,
                                  boxfit: BoxFit.cover,
                                  imageAspectRation: PsConst.Aspect_Ratio_2x,
                                  onTap: () {
                                    onDetailClick(context);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if (product.isSoldOutItem)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: PsDimens.space4,
                                          left: PsDimens.space4,
                                          right: PsDimens.space4),
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              PsDimens.space4),
                                          color: PsColors.mainColor),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text('dashboard__sold_out'.tr,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: PsColors.white))),
                                    ),
                                  if (product.paidStatus ==
                                      PsConst.PAID_AD_PROGRESS)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: PsDimens.space4,
                                          left: PsDimens.space4,
                                          right: PsDimens.space4),
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              PsDimens.space4),
                                          color: PsColors.cPaidAdsColor),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text(
                                              'dashboard__is_featured'.tr,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: PsColors.white))),
                                    ),
                                  if (product.isDiscountedItem)
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: PsDimens.space6,
                                          left: PsDimens.space6,
                                          right: PsDimens.space4),
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              PsDimens.space4),
                                          color: Colors.red),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4),
                                          child: Text(
                                              '${product.discountRate}% ${'dashboard__is_discount'.tr}',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: PsColors.white))),
                                    ),
                                ],
                              ),
                            ),
                            if (!Utils.isOwnerItem(valueHolder, product))
                              Positioned(
                                  top: PsDimens.space6,
                                  right: PsDimens.space6,
                                  child: GestureDetector(
                                      onTap: () {
                                        onDetailClick(context);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: PsDimens.space4,
                                              left: PsDimens.space4,
                                              right: PsDimens.space4,
                                              bottom: PsDimens.space4),
                                          decoration: BoxDecoration(
                                              color: PsColors.white,
                                              border: Border.all(
                                                  color: PsColors.white),
                                              shape: BoxShape.circle),
                                          child: product.isFavourited ==
                                                      PsConst.ZERO ||
                                                  Utils.isLoginUserEmpty(
                                                      valueHolder)
                                              ? Icon(Icons.favorite_border,
                                                  color: PsColors.secondary200,
                                                  size: 20)
                                              : Icon(Icons.favorite,
                                                  color: PsColors.mainColor,
                                                  size: 20)))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: PsDimens.space8,
                                  right: PsDimens.space8,
                                  left: PsDimens.space8),
                              child: Text(
                                product.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space8,
                            right: PsDimens.space8,
                            top: PsDimens.space4,
                            bottom: PsDimens.space4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    PsHero(
                                      tag:
                                          '$coreTagKey${product.id}$PsConst.HERO_TAG__UNIT_PRICE',
                                      flightShuttleBuilder:
                                          Utils.flightShuttleBuilder,
                                      child: Material(
                                          type: MaterialType.transparency,
                                          child: Text(
                                            !showDiscount
                                                ? product.originalPrice !=
                                                            '0' &&
                                                        product.originalPrice !=
                                                            ''
                                                    ? '${product.itemCurrency!.currencySymbol}${' '}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}'
                                                    : 'item_price_free'.tr
                                                : '${product.itemCurrency!.currencySymbol}${' '}${Utils.getPriceFormat(product.currentPrice!, valueHolder.priceFormat!)}',
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: PsColors.textColor1,
                                                    fontSize: 15),
                                          )),
                                    ),
                                    Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: showDiscount,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: PsDimens.space4),
                                              child: Text(
                                                '${product.itemCurrency!.currencySymbol}${Utils.getPriceFormat(product.originalPrice!, valueHolder.priceFormat!)}  ',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Utils
                                                                .isLightMode(
                                                                    context)
                                                            ? PsColors
                                                                .txtPrimaryLightColor
                                                            : PsColors
                                                                .primaryDarkGrey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 12,
                                  color: Colors.grey[400],
                                ),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: PsDimens.space4,
                                            right: PsDimens.space4),
                                        child: Text(
                                            valueHolder.isSubLocation ==
                                                    PsConst.ONE
                                                ? (product.itemLocationTownship!
                                                                .townshipName !=
                                                            '' &&
                                                        product.itemLocationTownship!
                                                                .townshipName !=
                                                            null)
                                                    ? // check optional township is empty
                                                    '${product.itemLocationTownship!.townshipName}'
                                                    : '${product.itemLocation!.name}'
                                                : '${product.itemLocation!.name}',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color:
                                                        PsColors.textColor3)))),
                              ],
                            ),
                            if (valueHolder.isShowOwnerInfo!)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: PsDimens.space4,
                                  right: PsDimens.space12,
                                  top: PsDimens.space8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Stack(children: <Widget>[
                                      Container(
                                        child: SizedBox(
                                          width: PsDimens.space40,
                                          height: PsDimens.space40,
                                          child: PsNetworkCircleImageForUser(
                                            photoKey: '',
                                            imagePath:
                                                product.user?.userCoverPhoto,
                                            // width: PsDimens.space40,
                                            // height: PsDimens.space40,
                                            boxfit: BoxFit.cover,
                                            onTap: () {
                                              onDetailClick(context);
                                            },
                                          ),
                                        ),
                                      ),
                                      if (product.user!.isVefifiedBlueMarkUser)
                                        const Positioned(
                                          right: -1,
                                          bottom: -1,
                                          child: BluemarkIcon(),
                                        ),
                                    ]),
                                    const SizedBox(width: PsDimens.space8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: PsDimens.space8,
                                            top: PsDimens.space8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                      product.user?.userName ==
                                                              ''
                                                          ? 'default__user_name'
                                                              .tr
                                                          : '${product.user?.userName}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                ),
                                              ],
                                            ),
                                            Text('${product.addedDateStr}',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: PsDimens.space6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> onDetailClick(BuildContext context) async {
    final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
        productId: product.id,
        heroTagImage: coreTagKey! + product.id! + PsConst.HERO_TAG__IMAGE,
        heroTagTitle: coreTagKey! + product.id! + PsConst.HERO_TAG__TITLE);
    await Navigator.pushNamed(context, RoutePaths.productDetail,
        arguments: holder);
    if (onTap != null) {
      onTap!();
    }
  }
}
