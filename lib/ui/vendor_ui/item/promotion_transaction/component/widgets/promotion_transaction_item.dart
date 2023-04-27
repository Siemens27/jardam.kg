import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/promotion_transaction.dart';

class PromotionTransactionItem extends StatefulWidget {
  const PromotionTransactionItem({
    Key? key,
    required this.transaction,
    required this.isSelected,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final PromotionTransaction transaction;
  final bool isSelected;
  final Function onLongPress;
  final Function onTap;

  @override
  State<PromotionTransactionItem> createState() =>
      _PromotionTransactionItemState();
}

class _PromotionTransactionItemState extends State<PromotionTransactionItem> {
  @override
  Widget build(BuildContext context) {
    final Widget _dividerWidget = Divider(
      height: PsDimens.space1,
      color: Theme.of(context).iconTheme.color,
    );

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      onLongPress: () {
        setState(() {
          widget.onLongPress();
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: widget.isSelected
                ? Utils.isLightMode(context)
                    ? PsColors.primary50
                    : PsColors.secondary700
                : PsColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (widget.isSelected)
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        color: PsColors.mainColor,
                        borderRadius: BorderRadius.circular(PsDimens.space4)),
                    child: Icon(
                      Icons.check,
                      color: PsColors.white,
                      size: PsDimens.space20,
                    ),
                  ),
                Expanded(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space16,
                            top: PsDimens.space14,
                            bottom: PsDimens.space14,
                            right: PsDimens.space2),
                        child: Text(
                          'You purchased a',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Utils.isLightMode(context)
                                        ? PsColors.secondary800
                                        : PsColors.baseColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        width: PsDimens.space4,
                      ),
                      Text('${widget.transaction.promotedDays} days promotion.',
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: PsColors.mainColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                    ],
                  ),
                ),
                Text(widget.transaction.addedDateStr!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.txtPrimaryColor
                              : PsColors.baseColor,
                        )),
                const SizedBox(
                  width: PsDimens.space16,
                ),
              ],
            ),
          ),
          _dividerWidget
        ],
      ),
    );
  }
}
