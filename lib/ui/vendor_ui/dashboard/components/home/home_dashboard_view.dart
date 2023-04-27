import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/blog/blog_provider.dart';
import '../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/discount_product_provider.dart';
import '../../../../../core/vendor/provider/product/item_list_from_followers_provider.dart';
import '../../../../../core/vendor/provider/product/nearest_product_provider.dart';
import '../../../../../core/vendor/provider/product/paid_ad_product_provider copy.dart';
import '../../../../../core/vendor/provider/product/popular_product_provider.dart';
import '../../../../../core/vendor/provider/product/recent_product_provider.dart';
import '../../../../../core/vendor/repository/Common/notification_repository.dart';
import '../../../../../core/vendor/repository/blog_repository.dart';
import '../../../../../core/vendor/repository/category_repository.dart';
import '../../../../../core/vendor/repository/item_location_repository.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/repository/user_unread_message_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/holder/user_unread_message_parameter_holder.dart';
import '../../../../custom_ui/blog/component/slider/blog_product_slider_widget.dart';
import '../../../../custom_ui/category/component/horizontal/home_category_list_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/buy_package_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/follower_product_horizontal_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/header_search_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/home_discount_product_horizontal_list_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/home_paid_ad_product_horizontal_list_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/home_popular_product_horizontal_list_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/nearest_product_horizontal_list_widget.dart';
import '../../../../custom_ui/dashboard/components/home/widgets/recent_product_horizontal_list_widget.dart';
import '../../../common/dialog/confirm_dialog_view.dart';
import '../../../common/dialog/rating_dialog/core.dart';
import '../../../common/dialog/rating_dialog/style.dart';


class HomeDashboardViewWidget extends StatefulWidget {
  const HomeDashboardViewWidget(
    this.animationController,
    this.context,
  );

  final AnimationController animationController;
  final BuildContext context;

  @override
  _HomeDashboardViewWidgetState createState() =>
      _HomeDashboardViewWidgetState();
}

class _HomeDashboardViewWidgetState extends State<HomeDashboardViewWidget> {
  PsValueHolder? valueHolder;
  CategoryRepository? repo1;
  late ProductRepository repo2;
  late BlogRepository repo3;
  ItemLocationRepository? repo4;
  NotificationRepository? notificationRepository;
  CategoryProvider? _categoryProvider;
  RecentProductProvider? _recentProductProvider;
  NearestProductProvider? _nearestProductProvider;
  PopularProductProvider? _popularProductProvider;
  DiscountProductProvider? _discountProductProvider;
  PaidAdProductProvider? _paidAdItemProvider;
  BlogProvider? _blogProvider;
  UserUnreadMessageProvider? _userUnreadMessageProvider;
  ItemListFromFollowersProvider? _itemListFromFollowersProvider;
  UserUnreadMessageRepository? userUnreadMessageRepository;
  late AppLocalization langProvider;

  final int count = 8;
  final TextEditingController userInputItemNameTextEditingController =
      TextEditingController();
  final TextEditingController useraddressTextEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Position? _currentPosition;
  bool androidFusedLocation = true;
  bool locationIsGranted = false;
  @override
  void dispose() {
    // _categoryProvider.dispose();
    // _recentProductProvider.dispose();
    super.dispose();
  }

  final RateMyApp _rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      minLaunches: 1,
      remindDays: 5,
      remindLaunches: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
    if (Platform.isAndroid) {
      _rateMyApp.init().then((_) {
        if (_rateMyApp.shouldOpenDialog) {
          _rateMyApp.showStarRateDialog(
            context,
            title: 'home__menu_drawer_rate_this_app'.tr,
            message: 'rating_popup_dialog_message'.tr,
            ignoreNativeDialog: true,
            actionsBuilder: (BuildContext context, double? stars) {
              return <Widget>[
                TextButton(
                  child: Text(
                    'dialog__ok'.tr,
                  ),
                  onPressed: () async {
                    if (stars != null) {
                      // _rateMyApp.save().then((void v) => Navigator.pop(context));
                      Navigator.pop(context);
                      if (stars < 1) {
                      } else if (stars >= 1 && stars <= 3) {
                        await _rateMyApp
                            .callEvent(RateMyAppEventType.laterButtonPressed);
                        await showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmDialogView(
                                description: 'rating_confirm_message'.tr,
                                leftButtonText: 'dialog__cancel'.tr,
                                rightButtonText:
                                    'home__menu_drawer_contact_us'.tr,
                                onAgreeTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    RoutePaths.contactUs,
                                  );
                                },
                              );
                            });
                      } else if (stars >= 4) {
                        await _rateMyApp
                            .callEvent(RateMyAppEventType.rateButtonPressed);
                        if (Platform.isIOS) {
                          Utils.launchAppStoreURL(
                              iOSAppId: valueHolder!.iosAppStoreId,
                              writeReview: true);
                        } else {
                          Utils.launchURL();
                        }
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  },
                )
              ];
            },
            onDismissed: () =>
                _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
            dialogStyle: const DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 16.0),
            ),
            starRatingOptions: const StarRatingOptions(),
          );
        }
      });
    }
  }

    @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_authStatus', _authStatus));
  }

  String _authStatus = 'Unknown';
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final String uuid =
        await AppTrackingTransparency.getAdvertisingIdentifier();
    print('UUID: $uuid');
  }


  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<CategoryRepository>(context);
    repo2 = Provider.of<ProductRepository>(context);
    repo3 = Provider.of<BlogRepository>(context);
    repo4 = Provider.of<ItemLocationRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    userUnreadMessageRepository =
        Provider.of<UserUnreadMessageRepository>(context);

    notificationRepository = Provider.of<NotificationRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<NearestProductProvider>(
              lazy: false,
              create: (BuildContext context) {
                _nearestProductProvider = NearestProductProvider(
                    repo: repo2, limit: valueHolder!.recentItemLoadingLimit!);
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                Geolocator.checkPermission()
                    .then((LocationPermission permission) {
                  if (permission == LocationPermission.denied) {
                    Geolocator.requestPermission()
                        .then((LocationPermission permission) {
                      if (permission == LocationPermission.denied) {
                        //permission denied, do nothing
                      } else {
                        Geolocator.getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.medium,
                                forceAndroidLocationManager:
                                    !androidFusedLocation)
                            .then((Position position) {
                          if (mounted) {
                            setState(() {
                              _currentPosition = position;
                            });
                            _nearestProductProvider
                                ?.productNearestParameterHolder
                                .lat = _currentPosition?.latitude.toString();
                            _nearestProductProvider
                                ?.productNearestParameterHolder
                                .lng = _currentPosition?.longitude.toString();
                            _nearestProductProvider
                                ?.productNearestParameterHolder
                                .mile = valueHolder!.mile;
                            _nearestProductProvider?.loadDataList(
                              requestPathHolder: RequestPathHolder(
                                  loginUserId: loginUserId!,
                                  languageCode:
                                      langProvider.currentLocale.languageCode),
                              requestBodyHolder: _nearestProductProvider!
                                  .productNearestParameterHolder,
                            );
                          }
                        }).catchError((Object e) {
                          //
                        });
                      }
                    });
                  } else {
                    Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.medium,
                            forceAndroidLocationManager: !androidFusedLocation)
                        .then((Position position) {
                      if (mounted) {
                        setState(() {
                          _currentPosition = position;
                        });
                        _nearestProductProvider?.productNearestParameterHolder
                            .lat = _currentPosition?.latitude.toString();
                        _nearestProductProvider?.productNearestParameterHolder
                            .lng = _currentPosition?.longitude.toString();
                        _nearestProductProvider?.productNearestParameterHolder
                            .mile = valueHolder!.mile;
                        _nearestProductProvider?.loadDataList(
                          requestPathHolder: RequestPathHolder(
                              loginUserId: loginUserId!,
                              languageCode:
                                  langProvider.currentLocale.languageCode),
                          requestBodyHolder: _nearestProductProvider!
                              .productNearestParameterHolder,
                        );
                      }
                    }).catchError((Object e) {
                      //
                    });
                  }
                });
                return _nearestProductProvider!;
              }),
          ChangeNotifierProvider<CategoryProvider>(
              lazy: false,
              create: (BuildContext context) {
                _categoryProvider ??= CategoryProvider(
                  repo: repo1,
                  limit: valueHolder!.categoryLoadingLimit!,
                );
                _categoryProvider!.loadDataList(
                    requestBodyHolder:
                        _categoryProvider!.categoryParameterHolder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(valueHolder!),
                        languageCode: langProvider.currentLocale.languageCode));

                // Utils.psPrint("Is Has Internet " + value);
                bool isConnectedToIntenet = true;
                Utils.checkInternetConnectivity()
                    .then((bool value) => isConnectedToIntenet = value);
                if (!isConnectedToIntenet) {
                  Fluttertoast.showToast(
                      msg: 'No Internet Connectiion. Please try again !',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blueGrey,
                      textColor: Colors.white);
                }

                return _categoryProvider!;
              }),
          ChangeNotifierProvider<RecentProductProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _recentProductProvider = RecentProductProvider(
                    repo: repo2, limit: valueHolder!.recentItemLoadingLimit!);
                _recentProductProvider!.productRecentParameterHolder.mile =
                    valueHolder!.mile;
                _recentProductProvider!.productRecentParameterHolder
                    .itemLocationId = valueHolder!.locationId;
                _recentProductProvider!.productRecentParameterHolder
                    .itemLocationName = valueHolder!.locactionName;
                if (valueHolder!.isSubLocation == PsConst.ONE) {
                  _recentProductProvider!.productRecentParameterHolder
                      .itemLocationTownshipId = valueHolder!.locationTownshipId;
                  _recentProductProvider!.productRecentParameterHolder
                          .itemLocationTownshipName =
                      valueHolder!.locationTownshipName;
                }
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                _recentProductProvider?.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId!,
                      languageCode: langProvider.currentLocale.languageCode),
                  requestBodyHolder:
                      _recentProductProvider!.productRecentParameterHolder,
                );
                return _recentProductProvider;
              }),
          ChangeNotifierProvider<PopularProductProvider>(
              lazy: false,
              create: (BuildContext context) {
                _popularProductProvider = PopularProductProvider(
                    repo: repo2, limit: valueHolder!.populartItemLoadingLimit!);
                _popularProductProvider!.productPopularParameterHolder.mile =
                    valueHolder!.mile;
                _popularProductProvider!.productPopularParameterHolder
                    .itemLocationId = valueHolder!.locationId;
                _popularProductProvider!.productPopularParameterHolder
                    .itemLocationName = valueHolder!.locactionName;
                if (valueHolder!.isSubLocation == PsConst.ONE) {
                  _popularProductProvider!.productPopularParameterHolder
                      .itemLocationTownshipId = valueHolder!.locationTownshipId;
                  _popularProductProvider!.productPopularParameterHolder
                          .itemLocationTownshipName =
                      valueHolder!.locationTownshipName;
                }
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                _popularProductProvider!.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId!,
                      languageCode: langProvider.currentLocale.languageCode),
                  requestBodyHolder:
                      _popularProductProvider!.productPopularParameterHolder,
                );
                return _popularProductProvider!;
              }),
          ChangeNotifierProvider<DiscountProductProvider>(
              lazy: false,
              create: (BuildContext context) {
                _discountProductProvider = DiscountProductProvider(
                    repo: repo2, limit: valueHolder!.discountItemLoadingLimit!);
                _discountProductProvider!.productDiscountParameterHolder.mile =
                    valueHolder!.mile;
                _discountProductProvider!.productDiscountParameterHolder
                    .itemLocationId = valueHolder!.locationId;
                _discountProductProvider!.productDiscountParameterHolder
                    .itemLocationName = valueHolder!.locactionName;
                if (valueHolder!.isSubLocation == PsConst.ONE) {
                  _discountProductProvider!.productDiscountParameterHolder
                      .itemLocationTownshipId = valueHolder!.locationTownshipId;
                  _discountProductProvider!.productDiscountParameterHolder
                          .itemLocationTownshipName =
                      valueHolder!.locationTownshipName;
                }
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                _discountProductProvider!.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId!,
                      languageCode: langProvider.currentLocale.languageCode),
                  requestBodyHolder:
                      _discountProductProvider!.productDiscountParameterHolder,
                );
                return _discountProductProvider!;
              }),
          ChangeNotifierProvider<PaidAdProductProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _paidAdItemProvider = PaidAdProductProvider(
                    repo: repo2, limit: valueHolder!.featuredItemLoadingLimit!);
                _paidAdItemProvider!.productPaidAdParameterHolder.mile =
                    valueHolder!.mile;
                _paidAdItemProvider!.productPaidAdParameterHolder
                    .itemLocationId = valueHolder!.locationId;
                _paidAdItemProvider!.productPaidAdParameterHolder
                    .itemLocationName = valueHolder!.locactionName;
                if (valueHolder!.isSubLocation == PsConst.ONE) {
                  _paidAdItemProvider!.productPaidAdParameterHolder
                      .itemLocationTownshipId = valueHolder!.locationTownshipId;
                  _paidAdItemProvider!.productPaidAdParameterHolder
                          .itemLocationTownshipName =
                      valueHolder!.locationTownshipName;
                }
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                _paidAdItemProvider!.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId!,
                      languageCode: langProvider.currentLocale.languageCode),
                  requestBodyHolder:
                      _paidAdItemProvider!.productPaidAdParameterHolder,
                );

                return _paidAdItemProvider;
              }),
          ChangeNotifierProvider<BlogProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _blogProvider = BlogProvider(
                    repo: repo3, limit: valueHolder!.blockSliderLoadingLimit!);
                _blogProvider?.blogParameterHolder.cityId =
                    valueHolder?.locationId;
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                _blogProvider?.loadDataList(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: loginUserId,
                        languageCode: langProvider.currentLocale.languageCode),
                    requestBodyHolder: _blogProvider?.blogParameterHolder);

                return _blogProvider;
              }),
          ChangeNotifierProvider<UserUnreadMessageProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _userUnreadMessageProvider = UserUnreadMessageProvider(
                    repo: userUnreadMessageRepository);
                if (valueHolder!.loginUserId != null &&
                    valueHolder!.loginUserId != '') {
                  _userUnreadMessageProvider!.userUnreadMessageHolder =
                      UserUnreadMessageParameterHolder(
                          userId: valueHolder!.loginUserId,
                          deviceToken: valueHolder!.deviceToken);
                  _userUnreadMessageProvider!.loadData(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: valueHolder!.loginUserId,
                          headerToken: valueHolder!.headerToken ?? '',
                          languageCode:
                              langProvider.currentLocale.languageCode),
                      requestBodyHolder:
                          _userUnreadMessageProvider!.userUnreadMessageHolder);
                }
                return _userUnreadMessageProvider;
              }),
          ChangeNotifierProvider<ItemListFromFollowersProvider?>(
              lazy: false,
              create: (BuildContext context) {
                _itemListFromFollowersProvider = ItemListFromFollowersProvider(
                    repo: repo2,
                    psValueHolder: valueHolder,
                    limit: valueHolder!.followerItemLoadingLimit!);

                _itemListFromFollowersProvider!.followUserItemParameterHolder
                    .itemLocationId = valueHolder!.locationId;
                if (valueHolder!.isSubLocation == PsConst.ONE) {
                  _itemListFromFollowersProvider!.followUserItemParameterHolder
                      .itemLocationTownshipId = valueHolder!.locationTownshipId;
                }
                _itemListFromFollowersProvider!.loadItemListFromFollowersList(
                    jsonMap: _itemListFromFollowersProvider!
                        .followUserItemParameterHolder
                        .toMap(),
                    loginUserId: Utils.checkUserLoginId(
                      _itemListFromFollowersProvider!.psValueHolder!,
                    ),
                    languageCode: langProvider.currentLocale.languageCode);
                return _itemListFromFollowersProvider;
              }),
        ],
        child: Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                _recentProductProvider!.loadDataList(reset: true);

                _popularProductProvider!.loadDataList(reset: true);

                _discountProductProvider!.loadDataList(reset: true);

                _nearestProductProvider!.loadDataList(reset: true);

                _paidAdItemProvider!.loadDataList(reset: true);

                _blogProvider?.loadDataList(reset: true);

                if (valueHolder!.loginUserId != null &&
                    valueHolder!.loginUserId != '') {
                  _userUnreadMessageProvider!.loadData(
                      requestBodyHolder:
                          _userUnreadMessageProvider!.userUnreadMessageHolder);
                }

                _itemListFromFollowersProvider!.resetItemListFromFollowersList(
                    jsonMap: _itemListFromFollowersProvider!
                        .followUserItemParameterHolder
                        .toMap(),
                    loginUserId: Utils.checkUserLoginId(
                        _itemListFromFollowersProvider!.psValueHolder!),
                    languageCode: langProvider.currentLocale.languageCode);

                return _categoryProvider!
                    .loadDataList(reset: true)
                    .then((dynamic value) {
                  final bool isConnectedToIntenet;
                  if (_categoryProvider!.dataList.status == PsStatus.ERROR) {
                    isConnectedToIntenet = false;
                  } else {
                    isConnectedToIntenet = true;
                  }
                  if (!isConnectedToIntenet) {
                    Fluttertoast.showToast(
                        msg: 'No Internet Connectiion. Please try again !',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blueGrey,
                        textColor: Colors.white);
                  }
                });
              },
              /**
               * UI SECTION
               */
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                shrinkWrap: false,
                slivers: <Widget>[
                  CustomHomeSearchHeaderWidget(
                    animationController: widget.animationController,
                  ),
                  CustomBlogProductSliderListWidget(
                    animationController: widget.animationController,
                  ),
                  if (valueHolder!.isPaidApp == PsConst.ONE)
                    CustomBuyPackageWidget(
                      animationController: widget.animationController,
                    ),
                  CustomHomeCategoryHorizontalListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomHomePaidAdProductHorizontalListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomRecentProductHorizontalListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomNearestProductHorizontalListWidget(
                    animationController: widget.animationController,
                  ),
                  if (valueHolder!.isShowDiscount!)
                    CustomHomeDiscountProductHorizontalListWidget(
                      animationController: widget.animationController,
                    ),
                  CustomHomePopularProductHorizontalListWidget(
                    animationController: widget.animationController,
                  ),
                  if (!Utils.isLoginUserEmpty(valueHolder))
                    CustomItemListFromFollowersHorizontalListWidget(
                      animationController: widget.animationController,
                    ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: PsDimens.space80),
                  ),
                ],
              )),
        ));
  }
}
