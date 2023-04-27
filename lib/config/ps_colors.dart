// Copyright (c) 2019, the PS Project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// PS license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../core/vendor/utils/utils.dart';

/// Colors Config For the whole App
/// Please change the color based on your brand need.

///
/// Dark Theme
///
// const Color ps_wtheme_color_primary = Color(0xFFFFFFFF);
// const Color ps_wtheme_color_primary_dark = Color(0xfFC7D180);
// const Color ps_wtheme_color_primary_light = Color(0xfEFAD670);

// const Color ps_wtheme_text__primary_color = Color(0xFF656565);
// const Color ps_wtheme_text__primary_light_color = Color(0xFFadadad);
// const Color ps_wtheme_text__primary_dark_color = Color(0xFF424242);

// const Color ps_wtheme_icon_color = Color(0xFF757575);
// const Color ps_wtheme_white_color = Colors.white;

// ///
// /// White Theme
// ///
// const Color ps_dtheme_color_primary = Color(0xFF303030);
// const Color ps_dtheme_color_primary_dark = Color(0xFF555555);
// const Color ps_dtheme_color_primary_light = Color(0xFF555555);

// const Color ps_dtheme_text__primary_color = Color(0xFFFFFFFF);
// const Color ps_dtheme_text__primary_light_color = Color(0xFFFFFFFF);
// const Color ps_dtheme_text__primary_dark_color = Color(0xFFFFFFFF);

// const Color ps_dtheme_icon_color = Colors.white;
// const Color ps_dtheme_white_color = Color(0xFF757575);

// ///
// /// Common Theme
// ///
// const Color ps_ctheme_text__category_title = Color(0xFFffcc00);
// const Color ps_ctheme_button__category_title = Color(0xFFffcc00);
// const Color ps_ctheme_text__color_gery = Color(0xFF757575);
// const Color ps_ctheme_text__color_primary_light = Color(0xFFbdbdbd);
// const Color ps_ctheme__color_speical = Color(0xFFD2232A);
// const Color ps_ctheme__color_about_us = Colors.cyan;
// const Color ps_ctheme__color_application = Colors.blue;
// const Color ps_ctheme__color_line = Color(0xFFbdbdbd);
// const Color ps_ctheme__sold_out = Color(0x80D2232A);
// const Color ps_ctheme__global_primary = Color(0xFFD2232A);

// Copyright (c) 2019, the PS Project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// PS license that can be found in the LICENSE file.

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:psxmpc/vendor/utils/utils.dart';

class PsColors {
  PsColors._();

  ///
  /// Main Color
  ///

  static Color mainLightColorWithBlack = dBaseColor;
  static Color mainShadowColor = Colors.black.withOpacity(0.5);
  static Color mainLightShadowColor = Colors.black.withOpacity(0.5);

  /// Primary Color
  static Color primary50 = cPrimary50;
  static Color primary100 = cPrimary100;
  static Color primary200 = cPrimary200;
  static Color primary300 = cPrimary300;
  static Color primary400 = cPrimary400;
  static Color primary500 = cPrimary500;
  static Color primary600 = cPrimary600;
  static Color primary700 = cPrimary700;
  static Color primary800 = cPrimary800;
  static Color primary900 = cPrimary900;

  /// Primary Dark Color
  static Color primaryDarkDark = cPrimaryDarkDark;
  static Color primaryDarkAccent = cPrimaryDarkAccent;
  static Color primaryDarkWhite = cPrimaryDarkWhite;
  static Color primaryDarkGrey = cPrimaryDarkGrey;

  /// Secondary Color
  static Color secondary50 = cSecondary50;
  static Color secondary100 = cSecondary100;
  static Color secondary200 = cSecondary200;
  static Color secondary300 = cSecondary300;
  static Color secondary400 = cSecondary400;
  static Color secondary500 = cSecondary500;
  static Color secondary600 = cSecondary600;
  static Color secondary700 = cSecondary700;
  static Color secondary800 = cSecondary800;
  static Color secondary900 = cSecondary900;

  /// Secondary Dark Color

  static Color secondaryDarkDark = cSecondaryDarkDark;
  static Color secondaryDarkAccent = cSecondaryDarkAccent;
  static Color secondaryDarkWhite = cSecondaryDarkWhite;
  static Color secondaryDarkGrey = cSecondaryDarkGrey;

  ///
  /// Base Color
  ///
  static Color baseColor = dBaseColor;
  static Color baseDarkColor = dBaseDarkColor;
  static Color baseLightColor = dBaseLightColor;

  static Color? textPrimaryColorForLight;
  static Color? textPrimaryDarkColorForLight;
  static Color? textPrimaryLightColorForLight;

  static Color? textColor1;
  static Color? textColor2;
  static Color? textColor3;
  static Color? textColor4;
  static Color? textColor5;

  ///
  /// Common Color
  ///

  static Color? txtPrimaryColor;
  static Color? txtPrimaryDarkColor;
  static Color? txtPrimaryLightColor;

  ///
  /// Button Color
  ///
  static Color? buttonColor;
  static Color? bottomNavigationSelectedColor;
  static Color? backArrowColor;
  static Color? appBarTitleColor;
  static Color? successColor;

  ///
  /// Primary Color
  ///
  static Color? mainColor;
  static Color? mainTransparentColor;
  static Color? mainDividerColor;

  ///
  ///
  ///
  static Color? bottomNavigationColor;

  ///
  /// Icon Color
  ///
  static Color iconColor = dIconColor;
  static Color iconRejectColor = dIconColor;
  static Color iconSuccessColor = dIconColor;
  static Color iconInfoColor = dIconColor;

  ///
  /// Background Color
  ///
  static Color coreBackgroundColor = dBaseColor;
  static Color backgroundColor = dBaseDarkColor;

  ///
  /// General
  ///
  static Color white = cWhiteColor;
  static Color black = cBlackColor;
  static Color grey = cGreyColor;
  static Color transparent = cTransparentColor;

  ///
  /// Customs
  ///

  static Color facebookLoginButtonColor = cFacebookLoginColor;
  static Color googleLoginButtonColor = cGoogleLoginColor;
  static Color phoneLoginButtonColor = cPhoneLoginColor;
  static Color appleLoginButtonColor = cAppleLoginColor;

  static Color paypalColor = cPaypalColor;
  static Color stripeColor = cStripeColor;
  static Color cardBackgroundColor = cCardBackgroundColor;

  static Color loadingCircleColor = cBlueColor;
  static Color ratingColor = cRatingColor;
  static Color soldOutUIColor = cSoldOutColor;
  static Color itemTypeColor = cItemTypeColor;
  static Color paidAdsColor = cPaidAdsColor;
  static Color bluemarkColor = cBlueColor;

  static Color watingForApprovalColor = cWatingForApprovalColor;
  static Color notYetStartColor = cNotYetStartColor;
  static Color adInFinishColor = cAdInFinishColor;
  static Color adInRejectColor = cAdInRejectColor;
  static Color adInProgressColor = cAdInProgressColor;
  static Color warningColor = cWarningColor;

  static Color offlineIconColor = cOfflineIconColor;
  static Color senderTextMsgColor = cSenderTextMsgColor;
  static Color receiverTextMsgColor = cReceiverTextMsgColor;
  static Color buttonBorderColor = cButtonBorderColor;
  static Color borderColor = cBorderColor;

  /// Colors Config For the whole App
  /// Please change the color based on your brand need.

  ///
  /// Light Theme
  ///

  static Color lMainColor = const Color(0xFFa92428);
  static Color lBaseColor = const Color(0xFFffffff);
  static Color lbaseDarkColor = const Color(0xFFFFFFFF);
  static Color lbaseLightColor = const Color(0xFFEFEFEF);

  static Color lTextPrimaryColor = const Color(0xFF445E76);
  static Color lTextPrimaryLightColor = const Color(0xFFadadad);
  static Color lTextPrimaryDarkColor = const Color(0xFF25425D);
  static Color lTextColor4 = const Color(0xFF456079);

  static Color lIconColor = const Color(0xFFa92428);
  static Color lIconRejectColor = const Color(0xFFF23A43);
  static Color lIconSuccessColor = const Color(0xFF38C141);
  static Color lIconInfoColor = const Color(0xFF00A2DD);
  static Color lDividerColor = const Color(0x15505050);
  static Color lMainTransparentColor = const Color(0xFFF6E9EA);
  static Color lAppBarTitleColor = const Color(0xFF121212);
  static Color lBottomNavigationColor = const Color(0xFFf5e5e5);
  static Color lCardBackgroundColor = const Color(0xFF303030);
  static Color lButtonColor = const Color(0xFFa92428);

  ///
  /// Dark Theme
  ///
  static Color dMainColor = const Color(0xFFffb0b1);
  static Color dBaseColor = const Color(0xFF212121);
  static Color dBaseDarkColor = const Color(0xFF303030);
  static Color dBaseLightColor = const Color(0xFF454545);
  static Color dTextPrimaryColor = const Color(0xFFFFFFFF);
  static Color dTextPrimaryLightColor = const Color(0xFFFFFFFF);
  static Color dTextPrimaryDarkColor = const Color(0xFFFFFFFF);
  static Color dTextColor3 = const Color(0xFFA0A0A0);
  static Color dIconColor = const Color(0xFFffb0b1);
  static Color dDividerColor = const Color(0x1FFFFFFF);
  static Color dMainTransparentColor = const Color(0xFFF6E9EA);
  static Color dCardBackgroundColor = const Color(0xFF303030);
  static Color dButtonColor = const Color(0xFFffb0b1);

  ///
  /// Common Theme
  ///

  static Color cPrimary50 = const Color(0xFFFDEBE7);
  static Color cPrimary100 = const Color(0xFFFACDC2);
  static Color cPrimary200 = const Color(0xFFF7AC9A);
  static Color cPrimary300 = const Color(0xFFF48A72);
  static Color cPrimary400 = const Color(0xFFF17153);
  static Color cPrimary500 = const Color(0xFFEF5835);
  static Color cPrimary600 = const Color(0xFFED5030);
  static Color cPrimary700 = const Color(0xFFEB4728);
  static Color cPrimary800 = const Color(0xFFE83D22);
  static Color cPrimary900 = const Color(0xFFE42D16);

  static Color cPrimaryDarkDark = const Color(0xFF303030);
  static Color cPrimaryDarkAccent = const Color(0xFFffb0b1);
  static Color cPrimaryDarkWhite = const Color(0xFFffffff);
  static Color cPrimaryDarkGrey = const Color(0xFFA0A0A0);

  static Color cSecondary50 = const Color(0xFFF9F9F9);
  static Color cSecondary100 = const Color(0xFFF3F3F3);
  static Color cSecondary200 = const Color(0xFFEAEAEA);
  static Color cSecondary300 = const Color(0xFFDADADA);
  static Color cSecondary400 = const Color(0xFFB7B7B7);
  static Color cSecondary500 = const Color(0xFF979797);
  static Color cSecondary600 = const Color(0xFF6F6F6F);
  static Color cSecondary700 = const Color(0xFF5B5B5B);
  static Color cSecondary800 = const Color(0xFF3C3C3C);
  static Color cSecondary900 = const Color(0xFF1C1C1C);

  static Color cSecondaryDarkDark = const Color(0xFF303030);
  static Color cSecondaryDarkAccent = const Color(0xFF6facff);
  static Color cSecondaryDarkWhite = const Color(0xFFffffff);
  static Color cSecondaryDarkGrey = const Color(0xFFA0A0A0);

  static Color cWhiteColor = Colors.white;
  static Color cBlackColor = Colors.black;
  static Color cGreyColor = Colors.grey;
  static Color cBlueColor = Colors.blue;
  static Color cTransparentColor = Colors.transparent;
  static Color cPaidAdsColor = Colors.lightGreen;

  static Color cFacebookLoginColor = const Color(0xFF1877F2);
  static Color cGoogleLoginColor = const Color(0xFFFFFFFF);
  static Color cPhoneLoginColor = const Color(0xFF38C141);
  static Color cAppleLoginColor = const Color(0xFF000000);

  static Color cPaypalColor = const Color(0xFF3b7bbf);
  static Color cStripeColor = const Color(0xFF008cdd);
  static Color cCardBackgroundColor = const Color(0xFF303030);
  static Color cRatingColor = const Color(0xFFF59E0B);
  static Color cSoldOutColor = const Color(0x80D2232A);
  static Color cItemTypeColor = const Color(0xFFBDBDBD);

  static Color cWatingForApprovalColor = const Color(0xFFF59E0B);
  static Color cNotYetStartColor = const Color(0xFF979797);
  static Color cAdInFinishColor = const Color(0xFF10B981);
  static Color cAdInRejectColor = const Color(0xFFF23A43);
  static Color cAdInProgressColor = const Color(0xFF00A2DD);
  static Color cWarningColor = const Color(0xFFFFC700);

  static Color cOfflineIconColor = const Color(0xFF6B7280);
  static Color cSenderTextMsgColor = const Color(0xFF009993);
  static Color cReceiverTextMsgColor = const Color(0xFFF6E9EA);
  static Color cButtonBorderColor = const Color(0xFFE5E7EB);
  static Color cBorderColor = const Color(0xFFD1D5DB);

  static void loadColor(BuildContext context) {
    if (Utils.isLightMode(context)) {
      _loadLightColors();
    } else {
      _loadDarkColors();
    }
  }

  static void loadColor2(bool isLightMode) {
    if (isLightMode) {
      _loadLightColors();
    } else {
      _loadDarkColors();
    }
  }

  static void _loadDarkColors() {
    ///
    /// Main Color
    ///
    mainLightColorWithBlack = dBaseColor;
    mainShadowColor = Colors.black.withOpacity(0.5);
    mainLightShadowColor = Colors.black.withOpacity(0.5);
    mainDividerColor = dDividerColor;

    ///
    ///Primary dark Color
    ///
    primaryDarkDark = cPrimaryDarkDark;
    primaryDarkAccent = cPrimaryDarkAccent;
    primaryDarkWhite = cPrimaryDarkWhite;
    primaryDarkGrey = cPrimaryDarkGrey;

    ///
    ///Secondary dark Color
    ///
    secondaryDarkDark = cSecondaryDarkDark;
    secondaryDarkAccent = cSecondaryDarkAccent;
    secondaryDarkWhite = cSecondaryDarkWhite;
    secondaryDarkGrey = cSecondaryDarkGrey;

    ///
    /// Base Color
    ///
    baseColor = dBaseColor;
    baseDarkColor = dBaseDarkColor;
    baseLightColor = dBaseLightColor;

    ///
    /// Text Color
    ///
    txtPrimaryColor = dTextPrimaryColor;
    txtPrimaryDarkColor = dTextPrimaryDarkColor;
    txtPrimaryLightColor = dTextPrimaryLightColor;

    textPrimaryColorForLight = lTextPrimaryColor;
    textPrimaryDarkColorForLight = lTextPrimaryDarkColor;
    textPrimaryLightColorForLight = lTextPrimaryLightColor;

    textColor1 = dMainColor;
    textColor2 = dTextPrimaryLightColor;
    textColor3 = dTextColor3;
    textColor4 = dBaseColor;
    textColor5 = secondary800;

    ///
    /// Button Color
    ///
    buttonColor = dButtonColor;
    bottomNavigationSelectedColor = dMainColor;
    mainColor = dMainColor;
    mainTransparentColor = dMainTransparentColor;
    backArrowColor = dMainColor;
    appBarTitleColor = dTextPrimaryColor;
    bottomNavigationColor = dBaseDarkColor;

    ///
    /// Icon Color
    ///
    iconColor = dIconColor;

    ///
    /// Background Color
    ///
    coreBackgroundColor = dBaseColor;
    backgroundColor = dBaseDarkColor;

    ///
    /// General
    ///
    white = cWhiteColor;
    black = cBlackColor;
    grey = cGreyColor;
    transparent = cTransparentColor;

    ///
    /// Custom
    ///
    facebookLoginButtonColor = cFacebookLoginColor;
    googleLoginButtonColor = cGoogleLoginColor;
    appleLoginButtonColor = cAppleLoginColor;
    phoneLoginButtonColor = cPhoneLoginColor;
    paypalColor = cPaypalColor;
    stripeColor = cStripeColor;
    loadingCircleColor = cBlueColor;
    ratingColor = cRatingColor;
    soldOutUIColor = cSoldOutColor;
    itemTypeColor = cItemTypeColor;
    paidAdsColor = cPaidAdsColor;
    bluemarkColor = cBlueColor;
    cardBackgroundColor = dCardBackgroundColor;

    watingForApprovalColor = cWatingForApprovalColor;
    notYetStartColor = cNotYetStartColor;
    adInFinishColor = cAdInFinishColor;
    adInRejectColor = cAdInRejectColor;
    adInProgressColor = cAdInProgressColor;
    warningColor = cWarningColor;

    offlineIconColor = cOfflineIconColor;
    senderTextMsgColor = cSenderTextMsgColor;
    receiverTextMsgColor = cReceiverTextMsgColor;
    buttonBorderColor = cButtonBorderColor;
    borderColor = cBorderColor;
  }

  static void _loadLightColors() {
    ///
    /// Main Color
    mainDividerColor = lDividerColor;

    ///
    ///Primary Color
    ///
    primary50 = cPrimary50;
    primary100 = cPrimary100;
    primary200 = cPrimary200;
    primary300 = cPrimary300;
    primary400 = cPrimary400;
    primary500 = cPrimary500;
    primary600 = cPrimary600;
    primary700 = cPrimary700;
    primary800 = cPrimary800;
    primary900 = cPrimary900;

    ///
    ///Secondary Color
    ///
    secondary50 = cSecondary50;
    secondary100 = cSecondary100;
    secondary200 = cSecondary200;
    secondary300 = cSecondary300;
    secondary400 = cSecondary400;
    secondary500 = cSecondary500;
    secondary600 = cSecondary600;
    secondary700 = cSecondary700;
    secondary800 = cSecondary800;
    secondary900 = cSecondary900;

    ///
    /// Base Color
    ///
    baseColor = lBaseColor;
    baseDarkColor = lbaseDarkColor;
    baseLightColor = lbaseLightColor;

    ///
    /// Text Color
    ///
    txtPrimaryColor = lTextPrimaryColor;
    txtPrimaryDarkColor = lTextPrimaryDarkColor;
    txtPrimaryLightColor = lTextPrimaryLightColor;

    textPrimaryColorForLight = lTextPrimaryColor;
    textPrimaryDarkColorForLight = lTextPrimaryDarkColor;
    textPrimaryLightColorForLight = lTextPrimaryLightColor;

    textColor1 = lMainColor;
    textColor2 = cSecondary700;
    textColor3 = cSecondary500;
    textColor4 = lTextColor4;
    textColor5 = white;

    ///
    /// Button Color
    ///
    buttonColor = lButtonColor;
    bottomNavigationSelectedColor = lMainColor;
    mainColor = lMainColor;
    mainTransparentColor = lMainTransparentColor;
    backArrowColor = cSecondary800;
    appBarTitleColor = lAppBarTitleColor;
    successColor = lIconSuccessColor;
    bluemarkColor = cBlueColor;
    bottomNavigationColor = lBottomNavigationColor;

    ///
    /// Icon Color
    ///
    iconColor = lIconColor;
    iconRejectColor = lIconRejectColor;
    iconSuccessColor = lIconSuccessColor;
    iconInfoColor = lIconInfoColor;

    ///
    /// Background Color
    ///
    coreBackgroundColor = lBaseColor;
    backgroundColor = lbaseDarkColor;

    ///
    /// General
    ///
    white = cWhiteColor;
    black = cBlackColor;
    grey = cGreyColor;
    transparent = cTransparentColor;

    ///
    /// Custom
    ///
    facebookLoginButtonColor = cFacebookLoginColor;
    googleLoginButtonColor = cGoogleLoginColor;
    appleLoginButtonColor = cAppleLoginColor;
    phoneLoginButtonColor = cPhoneLoginColor;
    paypalColor = cPaypalColor;
    stripeColor = cStripeColor;
    loadingCircleColor = cBlueColor;
    ratingColor = cRatingColor;
    soldOutUIColor = cSoldOutColor;
    itemTypeColor = cItemTypeColor;
    paidAdsColor = cPaidAdsColor;
    cardBackgroundColor = lCardBackgroundColor;
  }
}
