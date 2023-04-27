import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/dashboard/components/bottom_nav/widgets/chat_nav_item.dart';
import '../../../../custom_ui/dashboard/components/bottom_nav/widgets/selected_chat_nav_item.dart';
import '../../../../custom_ui/dashboard/components/bottom_nav/widgets/selected_nav_item_widget.dart';

class BottomNaviationWidget extends StatefulWidget {
  const BottomNaviationWidget(
      {required this.currentIndex,
      required this.updateSelectedIndexWithAnimation});
  final int? currentIndex;
  final Function updateSelectedIndexWithAnimation;
  @override
  BottomNavigationWidgetState<BottomNaviationWidget> createState() =>
      BottomNavigationWidgetState<BottomNaviationWidget>();
}

class BottomNavigationWidgetState<T extends BottomNaviationWidget>
    extends State<BottomNaviationWidget> {
  late PsValueHolder psValueHolder;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    if (isCorrectIndex())
      return Container(
        //  height: PsDimens.space120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32), topLeft: Radius.circular(32)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: PsColors.bottomNavigationColor,
            currentIndex: getBottonNavigationIndex(widget.currentIndex),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: PsColors.bottomNavigationSelectedColor,
            onTap: (int index) {
              final dynamic _returnValue =
                  getIndexFromBottonNavigationIndex(index);
              widget.updateSelectedIndexWithAnimation(
                  _returnValue[0], _returnValue[1]);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: CustomSelectedNavItemWidget(
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PsDimens.space4, vertical: 3),
                    child: SizedBox(
                      width: 16,
                      height: 18,
                      child: SvgPicture.asset(
                        'assets/images/home_bottom_selected.svg',
                        color: PsColors.mainColor,
                      ),
                    ),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PsDimens.space4, vertical: 3),
                  child: SizedBox(
                    width: 16,
                    height: 18,
                    child: SvgPicture.asset(
                      'assets/images/home_bottom.svg',
                      color: Utils.isLightMode(context)
                          ? PsColors.secondary500
                          : Colors.grey[320],
                    ),
                  ),
                ),
                label: ''.tr,
              ),
              BottomNavigationBarItem(
                activeIcon: CustomSelectedChatIconWithUnreadCount(
                    updateSelectedIndexWithAnimation:
                        widget.updateSelectedIndexWithAnimation),
                icon: CustomChatIconWithUnreadCount(
                    updateSelectedIndexWithAnimation:
                        widget.updateSelectedIndexWithAnimation),
                label: ''.tr,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: PsDimens.space44,
                  height: PsDimens.space44,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: PsColors.primary100,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: PsColors.mainTransparentColor!,
                            spreadRadius: 7)
                      ]),
                  child: Icon(
                    Icons.add,
                    color: Utils.isLightMode(context)
                        ? PsColors.primary500
                        : PsColors.black,
                  ),
                ),
                label: ''.tr,
              ),
              BottomNavigationBarItem(
                activeIcon: CustomSelectedNavItemWidget(
                    icon: Icon(
                  Icons.favorite,
                  size: 24,
                  color: PsColors.mainColor,
                )),
                icon: Icon(
                  Icons.favorite_border,
                  size: 24,
                  color: Utils.isLightMode(context)
                      ? PsColors.secondary500
                      : Colors.grey[360],
                ),
                label: ''.tr,
              ),
              BottomNavigationBarItem(
                activeIcon: CustomSelectedNavItemWidget(
                    icon: Icon(
                  Icons.account_circle,
                  size: 24,
                  color: PsColors.mainColor,
                )),
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 24,
                  color: Utils.isLightMode(context)
                      ? PsColors.secondary500
                      : Colors.grey[360],
                ),
                label: ''.tr,
              ),
            ],
          ),
        ),
      );
    else
      return const SizedBox();
  }

  int getBottonNavigationIndex(int? param) {
    int index = 0;
    switch (param) {
      case PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT:
        index = 0;
        break;
      // case PsConst.REQUEST_CODE__DASHBOARD_CATEGORY_FRAGMENT:
      case PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT:
        index = 1;
        break;
      // case PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT:
      case PsConst.REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT:
        index = 2;
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT:
        if (!Utils.isLoginUserEmpty(psValueHolder)) {
          index = 2;
        } else {
          index = 4;
        }
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT:
        if (!Utils.isLoginUserEmpty(psValueHolder)) {
          index = 2;
        } else {
          index = 4;
        }
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_VERIFY_FORGOT_PASSWORD_FRAGMENT:
        if (!Utils.isLoginUserEmpty(psValueHolder)) {
          index = 2;
        } else {
          index = 4;
        }
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT:
        if (!Utils.isLoginUserEmpty(psValueHolder)) {
          index = 2;
        } else {
          index = 4;
        }
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT:
        if (!Utils.isLoginUserEmpty(psValueHolder)) {
          index = 2;
        } else {
          index = 4;
        }
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT:
        index = 2;
        break;
      // case PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT:
      case PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT:
        index = 2;
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT:
        index = 2;
        break;
      case PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT:
        index = 2;
        break;
      // case PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT:
      case PsConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT:
        index = 3;
        break;
      //case PsConst.REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT:
      case PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT:
        index = 4;
        break;
      default:
        index = 0;
        break;
    }
    return index;
  }

  dynamic getIndexFromBottonNavigationIndex(int param) {
    int index = PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT;
    String title;
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    switch (param) {
      case 0:
        index = PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT;
        title = 'app_name'.tr;
        break;
      case 1:
        index = PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT;
        title = Utils.isLoginUserEmpty(psValueHolder)
            ? 'home_login'.tr
            : 'dashboard__bottom_navigation_message'.tr;
        break;
      case 2:
        index = PsConst.REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT;
        title = Utils.isLoginUserEmpty(psValueHolder)
            ? 'home_login'.tr
            : 'item_entry__listing_entry'.tr;
        break;
      case 3:
        index = PsConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT;
        title = Utils.isLoginUserEmpty(psValueHolder)
            ? 'home_login'.tr
            : 'home__menu_drawer_favourite'.tr;
        break;
      case 4:
        index = PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT;
        title = Utils.isLoginUserEmpty(psValueHolder)
            ? 'home_login'.tr
            : 'home__bottom_app_bar_login'.tr;
        break;

      default:
        index = 0;
        title = ''; //Utils.getString(context, 'app_name');
        break;
    }
    return <dynamic>[title, index];
  }

  bool isCorrectIndex() {
    return widget.currentIndex == PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT ||
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_CATEGORY_FRAGMENT ||
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT ||
        widget.currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT || //go to profile
        widget.currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT || //go to forgot password
        widget.currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_VERIFY_FORGOT_PASSWORD_FRAGMENT || //go to verify forgot password
        widget.currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT || //go to update forgot password
        widget.currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT || //go to register
        widget.currentIndex ==
            PsConst
                .REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT || //go to email verify
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT ||
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT ||
        widget.currentIndex == PsConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT ||
        widget.currentIndex == PsConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT ||
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT ||
        widget.currentIndex ==
            PsConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT;
  }
}
