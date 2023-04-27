import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/item_currency.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_button_widget_with_round_corner.dart';
import '../../../../../common/ps_ui_widget.dart';

class ChatMakeOfferDialog extends StatefulWidget {
  const ChatMakeOfferDialog({
    Key? key,
    required this.itemDetail,
    required this.onMakeOfferTap,
    required this.getChatHistoryProvider,
  }) : super(key: key);

  final Product? itemDetail;
  final Function onMakeOfferTap;
  final GetChatHistoryProvider? getChatHistoryProvider;

  @override
  _ChatMakeOfferDialogState createState() => _ChatMakeOfferDialogState();
}

class _ChatMakeOfferDialogState extends State<ChatMakeOfferDialog> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController currencySymbolController =
      TextEditingController();
  bool bindDataFirstTime = true;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space16,
    );
    if (bindDataFirstTime) {
      currencySymbolController.text = valueHolder.defaultCurrency;
      bindDataFirstTime = false;
    }

    final Widget _headerWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: PsDimens.space16,
                right: PsDimens.space16,
                top: PsDimens.space16),
            child: Text('make_offer_entry__title_name'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600)),
          ),
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: PsDimens.space16,
                    right: PsDimens.space16,
                    top: PsDimens.space16),
                child: Icon(Icons.clear, color: PsColors.secondary400)),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ]);

    final Widget _imageAndTextWidget = Card(
      child: Container(
        width: 310,
        color: Utils.isLightMode(context)
            ? PsColors.secondary50
            : PsColors.secondary800,
        padding: const EdgeInsets.all(PsDimens.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            PsNetworkImage(
              photoKey: '',
              defaultPhoto: widget.itemDetail?.defaultPhoto,
              width: PsDimens.space76,
              height: PsDimens.space76,
              boxfit: BoxFit.cover,
              imageAspectRation: PsConst.Aspect_Ratio_1x,
              onTap: () {
                // Navigator.pushNamed(context, RoutePaths.userDetail, arguments: data);
              },
            ),
            const SizedBox(
              height: PsDimens.space8,
            ),
            Text(widget.itemDetail?.title ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: PsColors.mainColor, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: PsDimens.space4,
            ),
            Text(widget.itemDetail?.category?.catName ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w400)),
            const SizedBox(height: PsDimens.space8),
            Text(
              widget.itemDetail != null &&
                      widget.itemDetail!.originalPrice != '0' &&
                      widget.itemDetail!.originalPrice != ''
                  ? '${widget.itemDetail!.itemCurrency!.currencySymbol} ${Utils.getPriceFormat(widget.itemDetail!.originalPrice!, valueHolder.priceFormat!)}'
                  : 'item_price_free'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: PsColors.secondary500),
            ),
            const SizedBox(
              height: PsDimens.space8,
            ),
          ],
        ),
      ),
    );

    final Widget _priceInputEditText = Container(
      height: PsDimens.space44,
      margin: const EdgeInsets.only(
          top: PsDimens.space12,
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PsDimens.space4),
        border: Border.all(color: PsColors.txtPrimaryLightColor!),
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());

              final dynamic itemCurrencySymbolResult =
                  await Navigator.pushNamed(
                      context, RoutePaths.itemCurrencySymbol,
                      arguments: currencySymbolController.text);

              if (itemCurrencySymbolResult != null &&
                  itemCurrencySymbolResult is ItemCurrency) {
                widget.getChatHistoryProvider!.itemCurrency =
                    itemCurrencySymbolResult.currencySymbol!;

                currencySymbolController.text =
                    itemCurrencySymbolResult.currencySymbol!;
              }
            },
            child: Container(
              width: PsDimens.space40,
              height: PsDimens.space44,
              margin: const EdgeInsets.symmetric(horizontal: PsDimens.space12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      child: Ink(
                        // color: PsColors.backgroundColor,
                        child: Text(
                          currencySymbolController.text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: PsColors.textPrimaryDarkColorForLight,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: PsColors.txtPrimaryLightColor,
            width: PsDimens.space1,
          ),
          Expanded(
            child: TextField(
                keyboardType: TextInputType.number,
                maxLines: null,
                textAlign: TextAlign.center,
                controller: priceController,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: PsDimens.space12,
                    bottom: PsDimens.space8,
                  ),
                  border: InputBorder.none,
                  hintText: 'chat_view__offer_price_hint_text'.tr,
                )),
          ),
        ],
      ),
    );
    final Widget _makeOfferButtonWidget =
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space8,
            left: PsDimens.space12,
            right: PsDimens.space12,
            bottom: PsDimens.space16),
        child: PSButtonWidgetRoundCorner(
          colorData: PsColors.secondary50,
          titleTextColor: PsColors.textColor3,
          hasShadow: false,
          width: 80,
          titleText: 'rating_entry__cancel'.tr,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space8,
            left: PsDimens.space16,
            right: PsDimens.space18,
            bottom: PsDimens.space16),
        child: PSButtonWidgetRoundCorner(
          colorData: PsColors.buttonColor,
          hasShadow: false,
          width: 80,
          titleText: 'make_offer_dialog__make_offer_btn_name'.tr,
          onPressed: () async {
            if (priceController.text == '') {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'chat_view__offer_price_request'.tr,
                    );
                  });
            } else {
              Navigator.of(context).pop();
              widget.onMakeOfferTap(priceController.text);
            }
          },
        ),
      ),
    ]);
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headerWidget,
            _spacingWidget,
            _imageAndTextWidget,
            if (widget.itemDetail!.originalPrice != '0')
              Visibility(
                visible: true,
                child: _priceInputEditText,
              ),
            _makeOfferButtonWidget
          ],
        ),
      ),
    );
  }
}
