// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/common/notification_provider.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../core/vendor/provider/clear_all/clear_all_data_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/language/language_provider.dart';
import '../../../../core/vendor/provider/mobile_color/mobile_color_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../core/vendor/repository/app_info_repository.dart';
import '../../../../core/vendor/repository/clear_all_data_repository.dart';
import '../../../../core/vendor/repository/language_repository.dart';
import '../../../../core/vendor/repository/mobile_color_repository.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/language.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/app_info_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/intent_holder/version_update_intent_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/mobile_color.dart';
import '../../../../core/vendor/viewobject/ps_app_info.dart';
import '../../../custom_ui/app_loading/component/loading_ui.dart';
import '../../common/dialog/version_update_dialog.dart';
import '../../common/dialog/warning_dialog_view.dart';

// ignore: must_be_immutable
class AppLoadingView extends StatelessWidget {
  Future<dynamic> callDateFunction(
      AppInfoProvider provider,
      ClearAllDataProvider? clearAllDataProvider,
      LanguageProvider languageProvider,
      BuildContext context) async {
    // String? realStartDate = '0';
    // String realEndDate = '0';
    if (await Utils.checkInternetConnectivity()) {
      final MobileColorProvider mobileColorsProvider =
          Provider.of<MobileColorProvider>(context, listen: false);

      final AppInfoParameterHolder appInfoParameterHolder =
          AppInfoParameterHolder(
              languageCode: langProvider.currentLocale.languageCode,
              countryCode: langProvider.currentLocale.countryCode);

      final PsResource<PSAppInfo> _psAppInfo = await provider.postData(
          requestBodyHolder: appInfoParameterHolder,
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(provider.psValueHolder!)));

      if (_psAppInfo.status == PsStatus.SUCCESS) {
        if (_psAppInfo.data != null &&
            (_psAppInfo.data!.packageInAppPurchaseKeyInAndroid != null ||
                _psAppInfo.data!.packageInAppPurchaseKeyInIOS != null)) {
          await provider.replacePackageIAPKeys(
              _psAppInfo.data!.packageInAppPurchaseKeyInAndroid ?? '',
              _psAppInfo.data!.packageInAppPurchaseKeyInIOS ?? '');
        }
        if (_psAppInfo.data!.appSetting!.isSubLocation != null &&
            _psAppInfo.data!.appSetting!.isSubLocation == PsConst.ONE) {
          provider.isSubLocation = true;
        } else {
          provider.isSubLocation = false;
        }
        // await provider.replaceDate(realStartDate!, realEndDate);

        if (_psAppInfo.data!.defaultCurrency != null) {
          await provider.replaceDefaultCurrency(
              _psAppInfo.data!.defaultCurrency!.id!,
              _psAppInfo.data!.defaultCurrency!.currencySymbol!);
        }

        if (_psAppInfo.data!.defaultPhoneCountryCode != null) {
          await provider.replaceDefaultPhoneCountryCode(
              _psAppInfo.data!.defaultPhoneCountryCode!.countryCode!,
              _psAppInfo.data!.defaultPhoneCountryCode!.countryName!);
        }

          if (_psAppInfo.data!.appSetting!.latitude != null && _psAppInfo.data!.appSetting!.longitude != null) {
          await provider.replaceDefaultLatLng(
              _psAppInfo.data!.appSetting!.latitude!,
              _psAppInfo.data!.appSetting!.longitude!);
        }

        if (_psAppInfo.data!.psMobileConfigSetting!.includedLanguages != null) {
          await langProvider.setSupportedLocales(
              Language.getLanguageCodeStringList(
                  _psAppInfo.data!.psMobileConfigSetting!.includedLanguages!));
        }

        if (_psAppInfo.data!.psMobileConfigSetting != null) {
          await provider.replaceMobileConfigSetting(
              _psAppInfo.data!.psMobileConfigSetting!);

          if (_psAppInfo.data!.psMobileConfigSetting!.clolorChangeCode !=
              valueHolder!.colorChangeCode) {
            mobileColorsProvider.loadData(
              dataConfig:
                  DataConfiguration(dataSourceType: DataSourceType.FULL_CACHE),
              requestPathHolder: RequestPathHolder(
                loginUserId: valueHolder!.loginUserId,
              ),
            ); // Call From Server
          } else {
            mobileColorProvider.loadColorFromDB(); // Call From DB
          }

          if (!languageProvider.isUserChangesLocalLanguage() &&
              _psAppInfo.data!.psMobileConfigSetting!.defaultLanguage != null) {
            final Language languageFromApi =
                _psAppInfo.data!.psMobileConfigSetting!.defaultLanguage!;

            await langProvider.setLocale(languageFromApi.toLocale(),
                languageFromApi.code!, languageFromApi.id!);
            await languageProvider.addLanguage(languageFromApi);
          }
        }

        await provider.replacePackageIAPKeys(
            _psAppInfo.data!.packageInAppPurchaseKeyInAndroid ?? '',
            _psAppInfo.data!.packageInAppPurchaseKeyInIOS ?? '');

        if (_psAppInfo.data!.appSetting != null) {
          if (_psAppInfo.data!.appSetting!.isBlockedDisabled != null) {
            await provider.replaceIsBlockeFeatureDisabled(
                _psAppInfo.data!.appSetting!.isBlockedDisabled!);
          }

          if (_psAppInfo.data!.appSetting!.isPaidApp != null) {
            await provider
                .replaceIsPaidApp(_psAppInfo.data!.appSetting!.isPaidApp!);
          }

          if (_psAppInfo.data!.appSetting!.isSubCatSubscribe != null) {
            await provider.replaceIsSubCatSubscribe(
                _psAppInfo.data!.appSetting!.isSubCatSubscribe!);
          }

          if (_psAppInfo.data!.appSetting!.isSubLocation != null) {
            await provider.replaceIsSubLocation(
                _psAppInfo.data!.appSetting!.isSubLocation!);
          }

          if (_psAppInfo.data!.appSetting!.maxImageCount != null) {
            await provider.replaceMaxImageCount(
                int.parse(_psAppInfo.data!.appSetting!.maxImageCount!));
          }
        }

        print('dialog__cancel'.tr);
        print('app_info__update_button_name'.tr);

        if (_psAppInfo.data!.userInfo!.userStatus == PsConst.USER_BANNED) {
          callLogout(
              provider, PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT, context);
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return WarningDialog(
                  message: 'user_status__banned'.tr,
                  onPressed: () {
                    checkVersionNumber(context, _psAppInfo.data!, provider,
                        clearAllDataProvider);
                  },
                );
              });
        } else if (_psAppInfo.data!.userInfo!.userStatus ==
            PsConst.USER_DELECTED) {
          callLogout(
              provider, PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT, context);
        } else if (_psAppInfo.data!.userInfo!.userStatus ==
            PsConst.USER_UN_PUBLISHED) {
          callLogout(
              provider, PsConst.REQUEST_CODE__MENU_HOME_FRAGMENT, context);
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return WarningDialog(
                  message: 'user_status__unpublished'.tr,
                  onPressed: () {
                    checkVersionNumber(context, _psAppInfo.data!, provider,
                        clearAllDataProvider);
                    // realStartDate = realEndDate;
                  },
                );
              });
        } else {
          checkVersionNumber(
              context, _psAppInfo.data!, provider, clearAllDataProvider);
        }
      } else if (_psAppInfo.status == PsStatus.ERROR) {
        final PsValueHolder valueHolder =
            Provider.of<PsValueHolder>(context, listen: false);

        if (valueHolder.isToShowIntroSlider) {
          Navigator.pushReplacementNamed(context, RoutePaths.introSlider,
              arguments: false);
        } else if (valueHolder.isForceLogin! &&
            Utils.checkUserLoginId(valueHolder) == 'nologinuser') {
          Navigator.pushReplacementNamed(context, RoutePaths.login_container);
        } else if (valueHolder.isLanguageConfig! &&
            valueHolder.showOnboardLanguage) {
          Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
        } else {
          if (provider.isSubLocation && valueHolder.locationId != null) {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.home,
            );
          } else if (!provider.isSubLocation &&
              valueHolder.locationId != null) {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.home,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.itemLocationList,
            );
          }
        }
      }
    } else {
      final PsValueHolder valueHolder =
          Provider.of<PsValueHolder>(context, listen: false);

      if (valueHolder.isToShowIntroSlider == true) {
        Navigator.pushReplacementNamed(context, RoutePaths.introSlider,
            arguments: false);
      } else if (valueHolder.isForceLogin == true &&
          Utils.checkUserLoginId(valueHolder) == 'nologinuser') {
        Navigator.pushReplacementNamed(context, RoutePaths.login_container);
      } else if (valueHolder.isLanguageConfig == true &&
          valueHolder.showOnboardLanguage) {
        Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
      } else {
        if (provider.isSubLocation &&
            provider.psValueHolder!.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else if (!provider.isSubLocation &&
            provider.psValueHolder!.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.itemLocationList,
          );
        }
      }
    }
  }

  void replaceColor(MobileColor color) {
    // Common Theme
    PsColors.mainLightColorWithBlack = Utils.hexToColor(
        color.mainLightColorWithBlack!, PsColors.mainLightColorWithBlack);
    PsColors.mainShadowColor =
        Utils.hexToColor(color.mainShadowColor!, PsColors.mainShadowColor)
            .withOpacity(0.5);
    PsColors.mainLightShadowColor = Utils.hexToColor(
            color.mainLightShadowColor!, PsColors.mainLightShadowColor)
        .withOpacity(0.5);

    PsColors.cPrimary50 =
        Utils.hexToColor(color.primary50!, PsColors.cPrimary50);
    PsColors.cPrimary100 =
        Utils.hexToColor(color.primary100!, PsColors.cPrimary100);
    PsColors.cPrimary200 =
        Utils.hexToColor(color.primary200!, PsColors.cPrimary200);
    PsColors.cPrimary300 =
        Utils.hexToColor(color.primary300!, PsColors.cPrimary300);
    PsColors.cPrimary400 =
        Utils.hexToColor(color.primary400!, PsColors.cPrimary400);
    PsColors.cPrimary500 =
        Utils.hexToColor(color.primary500!, PsColors.cPrimary500);
    PsColors.cPrimary600 =
        Utils.hexToColor(color.primary600!, PsColors.cPrimary600);
    PsColors.cPrimary700 =
        Utils.hexToColor(color.primary700!, PsColors.cPrimary700);
    PsColors.cPrimary800 =
        Utils.hexToColor(color.primary800!, PsColors.cPrimary800);
    PsColors.cPrimary900 =
        Utils.hexToColor(color.primary900!, PsColors.cPrimary900);

    PsColors.cPrimaryDarkDark =
        Utils.hexToColor(color.primaryDarkDark!, PsColors.cPrimaryDarkDark);
    PsColors.cPrimaryDarkAccent =
        Utils.hexToColor(color.primaryDarkAccent!, PsColors.cPrimaryDarkAccent);
    PsColors.cPrimaryDarkWhite =
        Utils.hexToColor(color.primaryDarkWhite!, PsColors.cPrimaryDarkWhite);
    PsColors.cPrimaryDarkGrey =
        Utils.hexToColor(color.primaryDarkGrey!, PsColors.cPrimaryDarkGrey);

    PsColors.cSecondary50 =
        Utils.hexToColor(color.secondary50!, PsColors.cSecondary50);
    PsColors.cSecondary100 =
        Utils.hexToColor(color.secondary100!, PsColors.cSecondary100);
    PsColors.cSecondary200 =
        Utils.hexToColor(color.secondary200!, PsColors.cSecondary200);
    PsColors.secondary300 =
        Utils.hexToColor(color.secondary300!, PsColors.cSecondary300);
    PsColors.cSecondary400 =
        Utils.hexToColor(color.secondary400!, PsColors.cSecondary400);
    PsColors.cSecondary500 =
        Utils.hexToColor(color.secondary500!, PsColors.cSecondary500);
    PsColors.cSecondary600 =
        Utils.hexToColor(color.secondary600!, PsColors.cSecondary600);
    PsColors.cSecondary700 =
        Utils.hexToColor(color.secondary700!, PsColors.cSecondary700);
    PsColors.cSecondary800 =
        Utils.hexToColor(color.secondary800!, PsColors.cSecondary800);
    PsColors.cSecondary900 =
        Utils.hexToColor(color.secondary900!, PsColors.cSecondary900);

    PsColors.cSecondaryDarkDark =
        Utils.hexToColor(color.secondaryDarkDark!, PsColors.cSecondaryDarkDark);
    PsColors.cSecondaryDarkAccent = Utils.hexToColor(
        color.secondaryDarkAccent!, PsColors.cSecondaryDarkAccent);
    PsColors.cSecondaryDarkWhite = Utils.hexToColor(
        color.secondaryDarkWhite!, PsColors.cSecondaryDarkWhite);
    PsColors.cSecondaryDarkGrey =
        Utils.hexToColor(color.secondaryDarkGrey!, PsColors.cSecondaryDarkGrey);

    PsColors.cWhiteColor = Utils.hexToColor(color.white!, PsColors.cWhiteColor);
    PsColors.cBlackColor = Utils.hexToColor(color.black!, PsColors.cBlackColor);
    PsColors.cGreyColor = Utils.hexToColor(color.grey!, PsColors.cGreyColor);

    PsColors.cFacebookLoginColor = Utils.hexToColor(
        color.facebookLoginButtonColor!, PsColors.cFacebookLoginColor);
    PsColors.cGoogleLoginColor = Utils.hexToColor(
        color.googleLoginButtonColor!, PsColors.cGoogleLoginColor);
    PsColors.cPhoneLoginColor = Utils.hexToColor(
        color.phoneLoginButtonColor!, PsColors.cPhoneLoginColor);
    PsColors.cAppleLoginColor = Utils.hexToColor(
        color.appleLoginButtonColor!, PsColors.cAppleLoginColor);
    PsColors.cPaypalColor =
        Utils.hexToColor(color.paypalColor!, PsColors.cPaypalColor);
    PsColors.cStripeColor =
        Utils.hexToColor(color.stripeColor!, PsColors.cStripeColor);
    PsColors.cCardBackgroundColor =
        Utils.hexToColor(color.primaryDarkDark!, PsColors.cCardBackgroundColor);

    PsColors.cBlueColor = Utils.hexToColor(color.blue!, PsColors.cBlueColor);
    PsColors.cRatingColor =
        Utils.hexToColor(color.ratingColor!, PsColors.cRatingColor);
    PsColors.cSoldOutColor =
        Utils.hexToColor(color.soldOutUIColor!, PsColors.cSoldOutColor);
    PsColors.cItemTypeColor =
        Utils.hexToColor(color.itemTypeColor!, PsColors.cItemTypeColor);
    PsColors.cPaidAdsColor =
        Utils.hexToColor(color.lightGreen!, PsColors.cPaidAdsColor);
    PsColors.cBlueColor = Utils.hexToColor(color.blue!, PsColors.cBlueColor);

    PsColors.cWatingForApprovalColor = Utils.hexToColor(
        color.watingForApprovalColor!, PsColors.cWatingForApprovalColor);
    PsColors.cNotYetStartColor =
        Utils.hexToColor(color.notYetStartColor!, PsColors.cNotYetStartColor);
    PsColors.cAdInFinishColor =
        Utils.hexToColor(color.adInFinishColor!, PsColors.cAdInFinishColor);
    PsColors.cAdInRejectColor =
        Utils.hexToColor(color.adInRejectColor!, PsColors.cAdInRejectColor);
    PsColors.cAdInProgressColor =
        Utils.hexToColor(color.adInProgressColor!, PsColors.cAdInProgressColor);
    PsColors.cWarningColor =
        Utils.hexToColor(color.warningColor!, PsColors.cWarningColor);

    PsColors.cOfflineIconColor =
        Utils.hexToColor(color.offlineIconColor!, PsColors.cOfflineIconColor);
    PsColors.cSenderTextMsgColor = Utils.hexToColor(
        color.senderTextMsgColor!, PsColors.cSenderTextMsgColor);
    PsColors.cReceiverTextMsgColor = Utils.hexToColor(
        color.receiverTextMsgColor!, PsColors.cSenderTextMsgColor);
    PsColors.cButtonBorderColor =
        Utils.hexToColor(color.buttonBorderColor!, PsColors.cButtonBorderColor);
    PsColors.cBorderColor =
        Utils.hexToColor(color.borderColor!, PsColors.cBorderColor);

    // Light Theme

    PsColors.lMainColor =
        Utils.hexToColor(color.lMainColor!, PsColors.lMainColor);
    PsColors.lBaseColor =
        Utils.hexToColor(color.lbaseColor!, PsColors.lBaseColor);
    PsColors.lbaseLightColor =
        Utils.hexToColor(color.lbaseLightColor!, PsColors.lbaseLightColor);
    PsColors.lbaseDarkColor =
        Utils.hexToColor(color.lbaseDarkColor!, PsColors.lbaseDarkColor);

    PsColors.lTextPrimaryColor =
        Utils.hexToColor(color.lTextPrimaryColor!, PsColors.lTextPrimaryColor);
    PsColors.lTextPrimaryLightColor = Utils.hexToColor(
        color.lTextPrimaryLightColor!, PsColors.lTextPrimaryLightColor);
    PsColors.lTextPrimaryDarkColor = Utils.hexToColor(
        color.lTextPrimaryDarkColor!, PsColors.lTextPrimaryDarkColor);
    PsColors.lTextColor4 =
        Utils.hexToColor(color.lTextColor4!, PsColors.lTextColor4);

    PsColors.lIconColor =
        Utils.hexToColor(color.lIconColor!, PsColors.lIconColor);
    PsColors.lIconRejectColor =
        Utils.hexToColor(color.lIconRejectColor!, PsColors.lIconRejectColor);
    PsColors.lIconSuccessColor =
        Utils.hexToColor(color.lIconSuccessColor!, PsColors.lIconSuccessColor);
    PsColors.lIconInfoColor =
        Utils.hexToColor(color.lIconInfoColor!, PsColors.lIconInfoColor);

    PsColors.lDividerColor =
        Utils.hexToColor(color.lDividerColor!, PsColors.lDividerColor);
    PsColors.lMainTransparentColor = Utils.hexToColor(
        color.lMainTransparentColor!, PsColors.lMainTransparentColor);
    PsColors.lAppBarTitleColor =
        Utils.hexToColor(color.lAppBarTitleColor!, PsColors.lAppBarTitleColor);
    PsColors.lBottomNavigationColor = Utils.hexToColor(
        color.lBottomNavigationColor!, PsColors.lBottomNavigationColor);
    PsColors.lCardBackgroundColor = Utils.hexToColor(
        color.lCardBackgroundColor!, PsColors.lCardBackgroundColor);
    PsColors.lButtonColor =
        Utils.hexToColor(color.lMainColor!, PsColors.lButtonColor);

    // Dark Theme

    PsColors.dMainColor =
        Utils.hexToColor(color.dMainColor!, PsColors.dMainColor);
    PsColors.dBaseColor =
        Utils.hexToColor(color.dBaseColor!, PsColors.dBaseColor);
    PsColors.dBaseDarkColor =
        Utils.hexToColor(color.dBaseDarkColor!, PsColors.dBaseDarkColor);
    PsColors.dBaseLightColor =
        Utils.hexToColor(color.dBaseLightColor!, PsColors.dBaseLightColor);
    PsColors.dTextPrimaryLightColor = Utils.hexToColor(
        color.dTextPrimaryColor!, PsColors.dTextPrimaryLightColor);
    PsColors.dTextPrimaryLightColor = Utils.hexToColor(
        color.dTextPrimaryLightColor!, PsColors.dTextPrimaryLightColor);
    PsColors.dTextPrimaryDarkColor = Utils.hexToColor(
        color.dTextPrimaryDarkColor!, PsColors.dTextPrimaryDarkColor);
    PsColors.dTextColor3 =
        Utils.hexToColor(color.dTextColor3!, PsColors.dTextColor3);
    PsColors.dIconColor =
        Utils.hexToColor(color.dIconColor!, PsColors.dIconColor);
    PsColors.dDividerColor =
        Utils.hexToColor(color.dDividerColor!, PsColors.dDividerColor);
    PsColors.dMainTransparentColor = Utils.hexToColor(
        color.dMainTransparentColor!, PsColors.dMainTransparentColor);
    PsColors.dCardBackgroundColor = Utils.hexToColor(
        color.dCardBackgroundColor!, PsColors.dCardBackgroundColor);
    PsColors.dButtonColor =
        Utils.hexToColor(color.dMainColor!, PsColors.dButtonColor);
  }

  dynamic callLogout(
      AppInfoProvider appInfoProvider, int index, BuildContext context) async {
    // updateSelectedIndex( index);
    await appInfoProvider.replaceLoginUserId('');
    await appInfoProvider.replaceLoginUserName('');
    // await deleteTaskProvider.deleteTask();
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  dynamic checkVersionNumber(
      BuildContext context,
      PSAppInfo psAppInfo,
      AppInfoProvider appInfoProvider,
      ClearAllDataProvider? clearAllDataProvider) async {
    if (PsConfig.app_version != psAppInfo.psMobileConfigSetting!.versionNo) {
      if (psAppInfo.psMobileConfigSetting!.versionNeedClearData ==
          PsConst.ONE) {
        await clearAllDataProvider!.clearAllData();
        checkForceUpdate(context, psAppInfo, appInfoProvider);
      } else {
        checkForceUpdate(context, psAppInfo, appInfoProvider);
      }
    } else {
      await appInfoProvider.replaceVersionForceUpdateData(false);

      final PsValueHolder valueHolder =
          Provider.of<PsValueHolder>(context, listen: false);

      if (valueHolder.isToShowIntroSlider == true) {
        Navigator.pushReplacementNamed(context, RoutePaths.introSlider,
            arguments: false);
      } else if (valueHolder.isForceLogin == true &&
          Utils.checkUserLoginId(valueHolder) == 'nologinuser') {
        Navigator.pushReplacementNamed(context, RoutePaths.login_container);
      } else if (valueHolder.isLanguageConfig == true &&
          valueHolder.showOnboardLanguage) {
        Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
      } else {
        if (appInfoProvider.isSubLocation && valueHolder.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else if (!appInfoProvider.isSubLocation &&
            valueHolder.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.itemLocationList,
          );
        }
      }
    }
  }

  dynamic checkForceUpdate(BuildContext context, PSAppInfo psAppInfo,
      AppInfoProvider appInfoProvider) async {
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    if (psAppInfo.psMobileConfigSetting!.versionForceUpdate == PsConst.ONE) {
      await appInfoProvider.replaceAppInfoData(
          psAppInfo.psMobileConfigSetting!.versionNo!,
          true,
          psAppInfo.psMobileConfigSetting!.versionTitle!,
          psAppInfo.psMobileConfigSetting!.versionMessage!);

      Navigator.pushReplacementNamed(
        context,
        RoutePaths.force_update,
        arguments: VersionIntentHolder(
            versionTitle: psAppInfo.psMobileConfigSetting!.versionTitle,
            versionMessage: psAppInfo.psMobileConfigSetting!.versionMessage),
      );
    } else if (psAppInfo.psMobileConfigSetting!.versionForceUpdate ==
        PsConst.ZERO) {
      await appInfoProvider.replaceVersionForceUpdateData(false);
      callVersionUpdateDialog(context, psAppInfo, appInfoProvider);
    } else {
      if (valueHolder.isToShowIntroSlider == true) {
        Navigator.pushReplacementNamed(context, RoutePaths.introSlider,
            arguments: false);
      } else if (valueHolder.isForceLogin == true &&
          Utils.checkUserLoginId(valueHolder) == 'nologinuser') {
        Navigator.pushReplacementNamed(context, RoutePaths.login_container);
      } else if (valueHolder.isLanguageConfig == true &&
          valueHolder.showOnboardLanguage) {
        Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
      } else {
        if (appInfoProvider.isSubLocation && valueHolder.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else if (!appInfoProvider.isSubLocation &&
            valueHolder.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.itemLocationList,
          );
        }
      }
    }
  }

  dynamic callVersionUpdateDialog(BuildContext context, PSAppInfo psAppInfo,
      AppInfoProvider appInfoProvider) {
    showDialog<dynamic>(
        barrierDismissible: false,
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return VersionUpdateDialog(
            title: psAppInfo.psMobileConfigSetting!.versionTitle,
            description: psAppInfo.psMobileConfigSetting!.versionMessage,
            leftButtonText: 'app_info__cancel_button_name'.tr,
            rightButtonText: 'app_info__update_button_name'.tr,
            onCancelTap: () {
              final PsValueHolder valueHolder =
                  Provider.of<PsValueHolder>(context, listen: false);

              if (valueHolder.isToShowIntroSlider == true) {
                Navigator.pushReplacementNamed(context, RoutePaths.introSlider,
                    arguments: false);
              } else if (valueHolder.isForceLogin == true &&
                  Utils.checkUserLoginId(valueHolder) == 'nologinuser') {
                Navigator.pushReplacementNamed(
                    context, RoutePaths.login_container);
              } else if (valueHolder.isLanguageConfig == true &&
                  valueHolder.showOnboardLanguage) {
                Navigator.pushReplacementNamed(
                    context, RoutePaths.languagesetting);
              } else {
                if (appInfoProvider.isSubLocation &&
                    valueHolder.locationId != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.home,
                  );
                } else if (!appInfoProvider.isSubLocation &&
                    valueHolder.locationId != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.home,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.itemLocationList,
                  );
                }
              }
            },
            onUpdateTap: () async {
              final PsValueHolder valueHolder =
                  Provider.of<PsValueHolder>(context, listen: false);

              if (valueHolder.isToShowIntroSlider == true) {
                Navigator.pushReplacementNamed(context, RoutePaths.introSlider,
                    arguments: false);
              } else if (valueHolder.isForceLogin == true &&
                  Utils.checkUserLoginId(valueHolder) == 'nologinuser') {
                Navigator.pushReplacementNamed(
                    context, RoutePaths.login_container);
              } else if (valueHolder.isLanguageConfig == true &&
                  valueHolder.showOnboardLanguage) {
                Navigator.pushReplacementNamed(
                    context, RoutePaths.languagesetting);
              } else {
                if (appInfoProvider.isSubLocation &&
                    valueHolder.locationId != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.home,
                  );
                } else if (!appInfoProvider.isSubLocation &&
                    valueHolder.locationId != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.home,
                  );
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.itemLocationList,
                  );
                }
              }

              if (Platform.isIOS) {
                Utils.launchAppStoreURL(iOSAppId: valueHolder.iosAppStoreId);
              } else if (Platform.isAndroid) {
                Utils.launchURL();
              }
            },
          );
        });
  }

  late AppInfoRepository repo1;
  late AppInfoProvider provider;
  late ClearAllDataRepository clearAllDataRepository;
  late ClearAllDataProvider? clearAllDataProvider;
  late LanguageRepository languageRepository;
  late LanguageProvider languageProvider;
  late MobileColorProvider mobileColorProvider;
  late MobileColorRepository mobileColorRepo;
  late PsValueHolder? valueHolder;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<AppInfoRepository>(context);
    clearAllDataRepository = Provider.of<ClearAllDataRepository>(context);
    languageRepository = Provider.of<LanguageRepository>(context);
    mobileColorRepo = Provider.of<MobileColorRepository>(context);
    valueHolder = Provider.of<PsValueHolder?>(context);
    langProvider = Provider.of<AppLocalization>(context, listen: false);

    if (valueHolder == null) {
      return Container();
    }

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<ClearAllDataProvider?>(
              lazy: false,
              create: (BuildContext context) {
                clearAllDataProvider = ClearAllDataProvider(
                    repo: clearAllDataRepository, psValueHolder: valueHolder);

                return clearAllDataProvider;
              }),
          ChangeNotifierProvider<LanguageProvider>(
            lazy: false,
            create: (BuildContext context) {
              languageProvider = LanguageProvider(repo: languageRepository);

              return languageProvider;
            },
          ),
          ChangeNotifierProvider<MobileColorProvider?>(
              lazy: false,
              create: (BuildContext context) {
                mobileColorProvider =
                    MobileColorProvider(repo: mobileColorRepo);

                return mobileColorProvider;
              }),
          ChangeNotifierProvider<UserProvider>(
            lazy: false,
            create: (BuildContext context) {
              final UserProvider provider = UserProvider(
                  repo: Provider.of<UserRepository>(context, listen: false),
                  psValueHolder: valueHolder);
              if (provider.psValueHolder!.headerToken == null ||
                  provider.psValueHolder!.headerToken == '') {
                Utils.saveHeaderInfoAndToken(provider);
              }
              return provider;
            },
          ),
          ChangeNotifierProvider<NotificationProvider>(
              lazy: false,
              create: (BuildContext context) {
                final NotificationProvider provider = NotificationProvider(
                    repo: Provider.of<NotificationRepository>(context,
                        listen: false),
                    psValueHolder: valueHolder);
                if (provider.psValueHolder!.deviceToken == null ||
                    provider.psValueHolder!.deviceToken == '') {
                  Utils.saveDeviceToken(provider, langProvider);
                } else {
                  print(
                      'Notification Token is already registered. Notification Setting : true.');
                }
                return provider;
              }),
          ChangeNotifierProvider<AppInfoProvider>(
              lazy: false,
              create: (BuildContext context) {
                provider =
                    AppInfoProvider(repo: repo1, psValueHolder: valueHolder);
                callDateFunction(
                    provider, clearAllDataProvider, languageProvider, context);

                return provider;
              }),
        ],
        child: Consumer<MobileColorProvider>(
          builder: (BuildContext context,
              MobileColorProvider mobileColorProvider, Widget? child) {
            if (mobileColorProvider.hasData) {
              replaceColor(mobileColorProvider.getMobileColor.data!);
              PsColors.loadColor(context);
            } else {
              PsColors.loadColor(context);
            }
            return CustomLoadingUi();
          },
        ));
  }
}
