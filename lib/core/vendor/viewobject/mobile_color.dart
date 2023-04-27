import 'common/ps_object.dart';

class MobileColor extends PsObject<MobileColor> {
  MobileColor({
    this.mainLightColorWithBlack,
    this.mainDividerColor,
    this.mainShadowColor,
    this.mainLightShadowColor,
    this.primary50,
    this.primary100,
    this.primary200,
    this.primary300,
    this.primary400,
    this.primary500,
    this.primary600,
    this.primary700,
    this.primary800,
    this.primary900,
    this.primaryDarkDark,
    this.primaryDarkAccent,
    this.primaryDarkWhite,
    this.primaryDarkGrey,

    this.secondary50,
    this.secondary100,
    this.secondary200,
    this.secondary300,
    this.secondary400,
    this.secondary500,
    this.secondary600,
    this.secondary700,
    this.secondary800,
    this.secondary900,
    this.secondaryDarkDark,
    this.secondaryDarkAccent,
    this.secondaryDarkWhite,
    this.secondaryDarkGrey,

    this.white,
    this.black,
    this.grey,
    this.blue,
    this.lightGreen,
    this.facebookLoginButtonColor,
    this.googleLoginButtonColor,
    this.phoneLoginButtonColor,
    this.appleLoginButtonColor,

    this.paypalColor,
    this.stripeColor,
    this.ratingColor,
    this.soldOutUIColor,
    this.itemTypeColor,
    this.watingForApprovalColor,
    this.notYetStartColor,
    this.adInFinishColor,
    this.adInRejectColor,
    this.adInProgressColor,
    this.warningColor,
    this.offlineIconColor,
    this.senderTextMsgColor,
    this.receiverTextMsgColor,
    this.buttonBorderColor,
    this.borderColor,

    this.lMainColor,
    this.lbaseColor,
    this.lbaseDarkColor,
    this.lbaseLightColor,
    this.lTextPrimaryColor,
    this.lTextPrimaryLightColor,
    this.lTextPrimaryDarkColor,
    this.lTextColor4,
    this.lIconColor,
    this.lIconRejectColor,
    this.lIconSuccessColor,
    this.lIconInfoColor,
    this.lDividerColor,
    this.lMainTransparentColor,
    this.lAppBarTitleColor,
    this.lBottomNavigationColor,

    this.dMainColor,
    this.dBaseColor,
    this.dBaseDarkColor,
    this.dBaseLightColor,
    this.dTextPrimaryColor,
    this.dTextPrimaryLightColor,
    this.dTextPrimaryDarkColor,
    this.dTextColor3,
    this.dIconColor,
    this.dDividerColor,
    this.dMainTransparentColor,
    this.lCardBackgroundColor,
    this.dCardBackgroundColor

  });

  String? mainLightColorWithBlack;
  String? mainDividerColor;
  String? mainShadowColor;
  String? mainLightShadowColor;
  String? primary50;
  String? primary100;
  String? primary200;
  String? primary300;
  String? primary400;
  String? primary500;
  String? primary600;
  String? primary700;
  String? primary800;
  String? primary900;
  String? primaryDarkDark;
  String? primaryDarkAccent;
  String? primaryDarkWhite;
  String? primaryDarkGrey;

  String? secondary50;
  String? secondary100;
  String? secondary200;
  String? secondary300;
  String? secondary400;
  String? secondary500;
  String? secondary600;
  String? secondary700;
  String? secondary800;
  String? secondary900;
  String? secondaryDarkDark;
  String? secondaryDarkAccent;
  String? secondaryDarkWhite;
  String? secondaryDarkGrey;

  String? white;
  String? black;
  String? grey;
  String? blue;
  String? lightGreen;
  String? facebookLoginButtonColor;
  String? googleLoginButtonColor;
  String? phoneLoginButtonColor;
  String? appleLoginButtonColor;

  String? paypalColor;
  String? stripeColor;
  String? ratingColor;
  String? soldOutUIColor;
  String? itemTypeColor;

  String? watingForApprovalColor;
  String? notYetStartColor;
  String? adInFinishColor;
  String? adInRejectColor;
  String? adInProgressColor;
  String? warningColor;
  String? offlineIconColor;
  String? senderTextMsgColor;
  String? receiverTextMsgColor;
  String? buttonBorderColor;
  String? borderColor;

  String? lMainColor;
  String? lbaseColor;
  String? lbaseDarkColor;
  String? lbaseLightColor;
  String? lTextPrimaryColor;
  String? lTextPrimaryLightColor;
  String? lTextPrimaryDarkColor;
  String? lTextColor4;
  String? lIconColor;
  String? lIconRejectColor;
  String? lIconSuccessColor;
  String? lIconInfoColor;
  String? lDividerColor;
  String? lMainTransparentColor;
  String? lAppBarTitleColor;
  String? lBottomNavigationColor;

  String? dMainColor;
  String? dBaseColor;
  String? dBaseDarkColor;
  String? dBaseLightColor;
  String? dTextPrimaryColor;
  String? dTextPrimaryLightColor;
  String? dTextPrimaryDarkColor;
  String? dTextColor3;
  String? dIconColor;
  String? dDividerColor;
  String? dMainTransparentColor;
  String? lCardBackgroundColor;
  String? dCardBackgroundColor;
 

  @override
  String? getPrimaryKey() {
    return mainLightColorWithBlack;
  }

  @override
  MobileColor fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return MobileColor(
        mainLightColorWithBlack: dynamicData['_c_main_light_color_with_black'],
        mainDividerColor: dynamicData['_c_main_divider_color'],
        mainShadowColor: dynamicData['_c_main_shadow_color'],
        mainLightShadowColor: dynamicData['_c_main_light_shadow_color'],    
        primary50: dynamicData['_c_primary_50'],
        primary100: dynamicData['_c_primary_100'],
        primary200: dynamicData['_c_primary_200'],
        primary300: dynamicData['_c_primary_300'],
        primary400: dynamicData['_c_primary_400'],
        primary500: dynamicData['_c_primary_500'],
        primary600: dynamicData['_c_primary_600'],
        primary700: dynamicData['_c_primary_700'],
        primary800: dynamicData['_c_primary_800'],
        primary900: dynamicData['_c_primary_900'],
        primaryDarkDark: dynamicData['_c_primary_dark_dark'],
        primaryDarkAccent: dynamicData['_c_primary_dark_accent'],
        primaryDarkWhite: dynamicData['_c_primary_dark_white'],
        primaryDarkGrey: dynamicData['_c_primary_dark_grey'],
    
        secondary50: dynamicData['_c_secondary_50'],
        secondary100: dynamicData['_c_secondary_100'],
        secondary200: dynamicData['_c_secondary_200'],
        secondary300: dynamicData['_c_secondary_300'],
        secondary400: dynamicData['_c_secondary_400'],
        secondary500: dynamicData['_c_secondary_500'],
        secondary600: dynamicData['_c_secondary_600'],
        secondary700: dynamicData['_c_secondary_700'],
        secondary800: dynamicData['_c_secondary_800'],
        secondary900: dynamicData['_c_secondary_900'],
        secondaryDarkDark: dynamicData['_c_secondary_dark_dark'],
        secondaryDarkAccent: dynamicData['_c_secondary_dark_accent'],
        secondaryDarkWhite: dynamicData['_c_secondary_dark_white'],
        secondaryDarkGrey: dynamicData['_c_secondary_dark_grey'],

        white: dynamicData['_c_white_color'],
        black: dynamicData['_c_black_color'],
        grey: dynamicData['_c_grey_color'],
        blue: dynamicData['_c_blue_color'],
        lightGreen: dynamicData['_c_paid_ads_color'],
        facebookLoginButtonColor: dynamicData['_c_facebook_login_color'],
        googleLoginButtonColor: dynamicData['_c_google_login_color'],
        phoneLoginButtonColor: dynamicData['_c_phone_login_color'],
        appleLoginButtonColor: dynamicData['_c_apple_login_color'],

        paypalColor: dynamicData['_c_paypal_color'],
        stripeColor: dynamicData['_c_stripe_color'],
        ratingColor: dynamicData['_c_rating_color'],
        soldOutUIColor: dynamicData['_c_sold_out'],
        itemTypeColor: dynamicData['_c_item_type_color'],

        watingForApprovalColor: dynamicData['_c_wating_for_approval_color'],
        notYetStartColor: dynamicData['_c_not_yet_start_color'],
        adInFinishColor: dynamicData['_c_ad_in_finish_color'],
        adInRejectColor: dynamicData['_c_ad_in_reject_color'],
        adInProgressColor: dynamicData['_c_ad_in_progress_color'],
        warningColor: dynamicData['_c_warning_color'],
        offlineIconColor: dynamicData['_c_offline_icon_color'],
        senderTextMsgColor: dynamicData['_c_sender_text_msg_color'],
        receiverTextMsgColor: dynamicData['_c_receiver_text_msg_color'],
        buttonBorderColor: dynamicData['_c_button_border_color'],
        borderColor: dynamicData['_c_border_color'], 

        lMainColor: dynamicData['_l_mainColor'], 
        lbaseColor: dynamicData['_l_base_color'], 
        lbaseDarkColor: dynamicData['_l_base_dark_color'], 
        lbaseLightColor: dynamicData['_l_base_light_color'], 
        lTextPrimaryColor: dynamicData['_l_text_primary_color'], 
        lTextPrimaryLightColor: dynamicData['_l_text_primary_light_color'], 
        lTextPrimaryDarkColor: dynamicData['_l_text_primary_dark_color'], 
        lTextColor4: dynamicData['_l_text_color_4'], 
        lIconColor: dynamicData['_l_icon_color'], 
        lIconRejectColor: dynamicData['_l_icon_reject_color'], 
        lIconSuccessColor: dynamicData['_l_icon_success_color'], 
        lIconInfoColor: dynamicData['_l_icon_info_color'], 
        lDividerColor: dynamicData['_l_divider_color'], 
        lMainTransparentColor: dynamicData['_l_main_transparent_color'],
        lAppBarTitleColor: dynamicData['_l_app_bar_title_color'],
        lBottomNavigationColor: dynamicData['_l_bottom_navigation_color'],

        dMainColor: dynamicData['_d_main_color'], 
        dBaseColor: dynamicData['_d_base_color'], 
        dBaseDarkColor: dynamicData['_d_base_dark_color'], 
        dBaseLightColor: dynamicData['_d_base_light_color'], 
        dTextPrimaryColor: dynamicData['_d_text_primary_color'], 
        dTextPrimaryLightColor: dynamicData['_d_text_primary_light_color'], 
        dTextPrimaryDarkColor: dynamicData['_d_text_primary_dark_color'], 
        dTextColor3: dynamicData['_d_text_color_3'], 
        dIconColor: dynamicData['_d_icon_color'], 
        dDividerColor: dynamicData['_d_divider_color'], 
        dMainTransparentColor: dynamicData['_d_main_transparent_color'],
        lCardBackgroundColor: dynamicData['_l_card_background_color'],
        dCardBackgroundColor: dynamicData['_d_card_background_color'], 

    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['_c_main_light_color_with_black'] = object.mainLightColorWithBlack;
      data['_c_main_divider_color'] = object.mainDividerColor;
      data['_c_main_shadow_color'] = object.mainShadowColor;
      data['_c_main_light_shadow_color'] = object.mainLightShadowColor;
      data['_c_primary_50'] = object.primary50;
      data['_c_primary_100'] = object.primary100;
      data['_c_primary_200'] = object.primary200;
      data['_c_primary_300'] = object.primary300;
      data['_c_primary_400'] = object.primary400;
      data['_c_primary_500'] = object.primary500;
      data['_c_primary_600'] = object.primary600;
      data['_c_primary_700'] = object.primary700;
      data['_c_primary_800'] = object.primary800;
      data['_c_primary_900'] = object.primary900;
      data['_c_primary_dark_dark'] = object.primaryDarkDark;
      data['_c_primary_dark_accent'] = object.primaryDarkAccent;
      data['_c_primary_dark_white'] = object.primaryDarkWhite;
      data['_c_primary_dark_grey'] = object.primaryDarkGrey;

      data['_c_secondary_50'] = object.secondary50;
      data['_c_secondary_100'] = object.secondary100;
      data['_c_secondary_200'] = object.secondary200;
      data['_c_secondary_300'] = object.secondary300;
      data['_c_secondary_400'] = object.secondary400;
      data['_c_secondary_500'] = object.secondary500;
      data['_c_secondary_600'] = object.secondary600;
      data['_c_secondary_700'] = object.secondary700;
      data['_c_secondary_800'] = object.secondary800;
      data['_c_secondary_900'] = object.secondary900;
      data['_c_secondary_dark_dark'] = object.secondaryDarkDark;
      data['_c_secondary_dark_accent'] = object.secondaryDarkAccent;
      data['_c_secondary_dark_white'] = object.secondaryDarkWhite;
      data['_c_secondary_dark_grey'] = object.secondaryDarkGrey;

      data['_c_white_color'] = object.white;
      data['_c_black_color'] = object.black;
      data['_c_grey_color'] = object.grey;
      data['_c_blue_color'] = object.blue;
      data['_c_paid_ads_color'] = object.lightGreen;
      data['_c_facebook_login_color'] = object.facebookLoginButtonColor;
      data['_c_google_login_color'] = object.googleLoginButtonColor;
      data['_c_phone_login_color'] = object.phoneLoginButtonColor;
      data['_c_apple_login_color'] = object.appleLoginButtonColor;

      data['_c_paypal_color'] = object.paypalColor;
      data['_c_stripe_color'] = object.stripeColor;
      data['_c_rating_color'] = object.ratingColor;
      data['_c_sold_out'] = object.soldOutUIColor;
      data['_c_item_type_color'] = object.itemTypeColor;

      data['_c_wating_for_approval_color'] = object.watingForApprovalColor;
      data['_c_not_yet_start_color'] = object.notYetStartColor;
      data['_c_ad_in_finish_color'] = object.adInFinishColor;
      data['_c_ad_in_reject_color'] = object.adInRejectColor;
      data['_c_ad_in_progress_color'] = object.adInProgressColor;
      data['_c_warning_color'] = object.warningColor;
      data['_c_offline_icon_color'] = object.offlineIconColor;
      data['_c_sender_text_msg_color'] = object.senderTextMsgColor;
      data['_c_receiver_text_msg_color'] = object.receiverTextMsgColor;
      data['_c_button_border_color'] = object.buttonBorderColor;
      data['_c_border_color'] = object.borderColor;

      data['_l_mainColor'] = object.lMainColor;
      data['_l_base_color'] = object.lbaseColor;
      data['_l_base_dark_color'] = object.lbaseDarkColor;
      data['_l_base_light_color'] = object.lbaseLightColor;
      data['_l_text_primary_color'] = object.lTextPrimaryColor;
      data['_l_text_primary_light_color'] = object.lTextPrimaryLightColor;
      data['_l_text_primary_dark_color'] = object.lTextPrimaryDarkColor;
      data['_l_text_color_4'] = object.lTextColor4;
      data['_l_icon_color'] = object.lIconColor;
      data['_l_icon_reject_color'] = object.lIconRejectColor;
      data['_l_icon_success_color'] = object.lIconSuccessColor;
      data['_l_icon_info_color'] = object.lIconInfoColor;
      data['_l_divider_color'] = object.lDividerColor;
      data['_l_main_transparent_color'] = object.lMainTransparentColor;
      data['_l_app_bar_title_color'] = object.lAppBarTitleColor;
      data['_l_bottom_navigation_color'] = object.lBottomNavigationColor;

      data['_d_main_color'] = object.dMainColor;
      data['_d_base_color'] = object.dBaseColor;
      data['_d_base_dark_color'] = object.dBaseDarkColor;
      data['_d_base_light_color'] = object.dBaseLightColor;
      data['_d_text_primary_color'] = object.dTextPrimaryColor;
      data['_d_text_primary_light_color'] = object.dTextPrimaryLightColor;
      data['_d_text_primary_dark_color'] = object.dTextPrimaryDarkColor;
      data['_d_text_color_3'] = object.dTextColor3;
      data['_d_icon_color'] = object.dIconColor;
      data['_d_divider_color'] = object.dDividerColor;
      data['_d_main_transparent_color'] = object.dMainTransparentColor;
      data['_l_card_background_color'] = object.lCardBackgroundColor;
      data['_d_card_background_color'] = object.dCardBackgroundColor;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<MobileColor> fromMapList(List<dynamic> dynamicDataList) {
    final List<MobileColor> userLoginList = <MobileColor>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        userLoginList.add(fromMap(dynamicData));
      }
    }
    // }
    return userLoginList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }
}
