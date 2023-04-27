import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/category_icon.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_icon.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_item_type.dart';
import '../../../../../../custom_ui/item/list_with_filter/components/item/widgets/map_icon.dart';

class FilterNavItems extends StatefulWidget {
  const FilterNavItems({this.changeAppBarTitle});

  final Function? changeAppBarTitle;

  @override
  State<FilterNavItems> createState() => _FilterNavItemsState();
}

class _FilterNavItemsState extends State<FilterNavItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PsColors.baseColor,
      padding: const EdgeInsets.only(
        left: PsDimens.space16,
        top: PsDimens.space8,
        bottom: PsDimens.space12,
        right: PsDimens.space16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const CustomFilterProductItemTypeWidget(),
          Row(
            children: const <Widget>[
              CustomCategoryIconWidget(),
              SizedBox(width: PsDimens.space10),
              CustomFilterIconWidget(),
              SizedBox(width: PsDimens.space10),
              CustomMapIconWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
