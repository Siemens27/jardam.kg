import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';

class AdsStartDateDropDownWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdsStartDateDropDownWidgetState();
  }
}

class AdsStartDateDropDownWidgetState
    extends State<AdsStartDateDropDownWidget> {
  TextEditingController startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemPromotionProvider>(
      builder: (BuildContext context,
          ItemPromotionProvider itemPaidHistoryProvider, Widget? child) {
        // ignore: unnecessary_null_comparison
        if (itemPaidHistoryProvider == null) {
          return const SizedBox();
        } else {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: PsDimens.space4),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: PsDimens.space44,
                    margin: const EdgeInsets.all(PsDimens.space16),
                    decoration: BoxDecoration(
                      color: PsColors.backgroundColor,
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                      border: Border.all(color: PsColors.mainDividerColor!),
                    ),
                    child: TextField(
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        controller: startDateController,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: PsColors.txtPrimaryColor),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () async {
                                await DatePicker.showDateTimePicker(context,
                                    minTime: DateTime.now(),
                                    onConfirm: (DateTime date) {
                                  itemPaidHistoryProvider.selectedDateTime =
                                      date;
                                }, locale: LocaleType.ru);
                                if (itemPaidHistoryProvider.selectedDateTime !=
                                    null) {
                                  itemPaidHistoryProvider.selectedDate =
                                      DateFormat.yMMMMd('ru_RU').format(
                                              itemPaidHistoryProvider
                                                  .selectedDateTime!) +
                                          ' ' +
                                          DateFormat.Hms('ru_RU').format(
                                              itemPaidHistoryProvider
                                                  .selectedDateTime!);
                                }
                                setState(() {
                                  startDateController.text =
                                      itemPaidHistoryProvider.selectedDate ??
                                          '';
                                });
                              },
                              child: Icon(
                                Icons.calendar_month_outlined,
                                size: PsDimens.space28,
                                color: PsColors.mainColor,
                              )),
                          contentPadding: const EdgeInsets.only(
                            top: PsDimens.space8,
                            left: PsDimens.space12,
                            right: PsDimens.space12,
                            bottom: PsDimens.space8,
                          ),
                          border: InputBorder.none,
                          hintText: '2020-10-2 3:00 PM',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: PsColors.txtPrimaryLightColor),
                        ))),
              ),
            ],
          );
        }
      },
    );
  }
}
