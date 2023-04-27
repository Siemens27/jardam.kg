import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../ps_textfield_widget.dart';

class DetailMultiSelectionWidget extends StatelessWidget {
  const DetailMultiSelectionWidget({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;

  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = itemEntryFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PsTextFieldWidget(
          titleText: customField.name!,
          keyboardType: TextInputType.number,
          textAboutMe: false,
          hintText: customField.placeHolder ?? '',
          textEditingController: element.value.valueTextController,
          isStar: customField.isMandatory,
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return DetailMultiSelectItem(
              customField: customField,
            );
          }, childCount: itemEntryFieldProvider.dataLength),
        ),
      ],
    );
  }
}

class DetailMultiSelectItem extends StatelessWidget {
  const DetailMultiSelectItem({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: BeveledRectangleBorder(
          side: BorderSide(color: PsColors.primary50),
          borderRadius: const BorderRadius.all(Radius.circular(7.0))),
      child: Container(
        margin: const EdgeInsets.all(PsDimens.space4),
        padding: const EdgeInsets.only(
            left: PsDimens.space8, right: PsDimens.space8),
        child: Center(
          child: Text(
            customField.id!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: PsColors.mainColor),
          ),
        ),
      ),
    );
  }
}
