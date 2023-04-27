import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';

class SerachHistoryListViewAppBar extends StatefulWidget {
  const SerachHistoryListViewAppBar({
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    required this.items,
    required this.onItemSelected,
    //this.chatFlag
  }) : assert(items.length >= 2 && items.length <= 5);

  @override
  _SerachHistoryListViewAppBarState createState() {
    return _SerachHistoryListViewAppBarState(
        selectedIndexNo: selectedIndex,
        items: items,
        iconSize: iconSize,
        onItemSelected: onItemSelected);
  }

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final List<SerachHistoryListViewAppBarItem> items;
  final ValueChanged<int> onItemSelected;
  //final String? chatFlag;
}

class _SerachHistoryListViewAppBarState
    extends State<SerachHistoryListViewAppBar> {
  _SerachHistoryListViewAppBarState(
      {required this.items,
      this.iconSize,
      this.selectedIndexNo,
      required this.onItemSelected});

  final double? iconSize;
  List<SerachHistoryListViewAppBarItem> items;
  int? selectedIndexNo;

  ValueChanged<int> onItemSelected;

  Widget _buildItem(SerachHistoryListViewAppBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width / 4,
      height: double.maxFinite,
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                item.title + '  ',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isSelected ? item.mainColor : item.inmainColor,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(
            height: PsDimens.space16,
          ),
          if (isSelected)
            Divider(
              color: PsColors.mainColor,
              height: 1,
              thickness: 1.5,
            )
          else
            Divider(
              height: PsDimens.space1,
              color: PsColors.textPrimaryLightColorForLight,
              thickness: 0.2,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedIndexNo = widget.selectedIndex;
    return Container(
        margin: const EdgeInsets.only(
          top: PsDimens.space16,
        ),
        width: double.infinity,
        height: 52,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              final SerachHistoryListViewAppBarItem item = items[index];
              return InkWell(
                onTap: () {
                  onItemSelected(index);
                  setState(() {
                    selectedIndexNo = index;
                  });
                },
                child: _buildItem(item, selectedIndexNo == index),
              );
            }));
  }
}

class SerachHistoryListViewAppBarItem {
  SerachHistoryListViewAppBarItem(
      {required this.title,
      // required this.searchHistoryProvider,
      // required this.type,
      Color? mainColor,
      Color? activeBackgroundColor,
      Color? inmainColor,
      Color? inactiveBackgroundColor})
      : mainColor = mainColor ?? PsColors.mainColor,
        activeBackgroundColor = activeBackgroundColor ?? PsColors.primary50,
        inmainColor = inmainColor ?? PsColors.textColor3,
        inactiveBackgroundColor =
            inactiveBackgroundColor ?? PsColors.grey.withOpacity(0.2);

  final String title;
  // final SearchHistoryProvider? searchHistoryProvider;
  // final String type;
  final Color? mainColor;
  final Color? activeBackgroundColor;
  final Color? inmainColor;
  final Color inactiveBackgroundColor;
}
