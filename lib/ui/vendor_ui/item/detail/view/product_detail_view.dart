import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/gallery/gallery_provider.dart';
import '../../../../../../../../core/vendor/provider/history/history_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/favourite_item_provider.dart';
import '../../../../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../../../../core/vendor/provider/product/mark_sold_out_item_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/provider/product/related_product_provider.dart';
import '../../../../../../../../core/vendor/provider/product/touch_count_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/repository/about_us_repository.dart';
import '../../../../../../../../core/vendor/repository/app_info_repository.dart';
import '../../../../../../../../core/vendor/repository/gallery_repository.dart';
import '../../../../../../../../core/vendor/repository/history_repsitory.dart';
import '../../../../../../../../core/vendor/repository/item_entry_field_repository.dart';
import '../../../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../../../core/vendor/viewobject/holder/app_info_parameter_holder.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/db/common/ps_data_source_manager.dart';
import '../../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/holder/touch_count_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../custom_ui/item/detail/component/appbar/product_expandable_appbar.dart';
import '../../../../custom_ui/item/detail/component/info_widgets/description_widget.dart';
import '../../../../custom_ui/item/detail/component/info_widgets/price_widget.dart';
import '../../../../custom_ui/item/detail/component/info_widgets/title_with_favorite_edit_widget.dart';
import '../../../../custom_ui/item/detail/component/sticky_bottom/sticky_bottom_widget.dart';
import '../../../../custom_ui/item/detail/component/tiles/contact_info_tile_view.dart';
import '../../../../custom_ui/item/detail/component/tiles/faq_tile_view.dart';
import '../../../../custom_ui/item/detail/component/tiles/safety_tips_tile_view.dart';
import '../../../../custom_ui/item/detail/component/tiles/seller_info_tile_view.dart';
import '../../../../custom_ui/item/detail/component/tiles/static_tile_view.dart';
import '../../../../custom_ui/item/detail/component/tiles/terms_and_conditions_tile_view.dart';
import '../../../../custom_ui/item/related_item/component/horizontal/related_product_list_widget.dart';
import '../../../common/base/ps_widget_with_multi_provider.dart';
import '../component/custom_detail_info/custom_detail_inof_view.dart';
import '../component/info_widgets/location_widget.dart';

const int maxFailedLoadAttempts = 3;

class ProductDetailView extends StatefulWidget {
  const ProductDetailView(
      {required this.productId,
      required this.heroTagImage,
      required this.heroTagTitle});

  final String? productId;
  final String? heroTagImage;
  final String? heroTagTitle;
  @override
  ProductDetailState<ProductDetailView> createState() =>
      ProductDetailState<ProductDetailView>();
}

class ProductDetailState<T extends ProductDetailView>
    extends State<ProductDetailView> with SingleTickerProviderStateMixin {
  ProductRepository? productRepo;
  HistoryRepository? historyRepo;
  HistoryProvider? historyProvider;
  ItemDetailProvider? itemDetailProvider;
  TouchCountProvider? touchCountProvider;
  AppInfoProvider? appInfoProvider;
  GalleryProvider? galleryProvider;
  late GalleryRepository galleryRepository;
  AppInfoRepository? appInfoRepository;
  RelatedProductProvider? relatedProductProvider;
  PsValueHolder? psValueHolder;
  AnimationController? animationController;
  late AboutUsRepository aboutUsRepo;
  AboutUsProvider? aboutUsProvider;
  UserProvider? userProvider;
  UserRepository? userRepo;
  late AppLocalization langProvider;
  FavouriteItemProvider? favouriteProvider;
  bool isReadyToShowAppBarIcons = false;
  bool isFirstTime = false;
  bool isHaveVideo = false;
  DefaultPhoto? currentDefaultPhoto;
  int maxFailedLoadAttempts = 3;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  ItemEntryFieldProvider? itemEntryFieldProvider;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isReadyToShowAppBarIcons) {
      Timer(const Duration(milliseconds: 800), () {
        setState(() {
          isReadyToShowAppBarIcons = true;
        });
      });
    }
    psValueHolder = Provider.of<PsValueHolder>(context);

    historyRepo = Provider.of<HistoryRepository>(context);
    productRepo = Provider.of<ProductRepository>(context);
    aboutUsRepo = Provider.of<AboutUsRepository>(context);
    userRepo = Provider.of<UserRepository>(context);
    appInfoRepository = Provider.of<AppInfoRepository>(context);
    galleryRepository = Provider.of<GalleryRepository>(context);
    final ItemEntryFieldRepository itemEntryFieldRepository =
        Provider.of<ItemEntryFieldRepository>(context);
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    final AppInfoParameterHolder appInfoParameterHolder =
        AppInfoParameterHolder(
            languageCode: langProvider.currentLocale.languageCode,
            countryCode: langProvider.currentLocale.countryCode);

    return PsWidgetWithMultiProvider(
        child: MultiProvider(
            providers: <SingleChildWidget>[
          ChangeNotifierProvider<ItemDetailProvider?>(
            lazy: false,
            create: (BuildContext context) {
              itemDetailProvider = ItemDetailProvider(
                  repo: productRepo, psValueHolder: psValueHolder);

              final String? loginUserId =
                  Utils.checkUserLoginId(psValueHolder!);
              itemDetailProvider!.loadData(
                requestPathHolder: RequestPathHolder(
                  itemId: widget.productId,
                  loginUserId: loginUserId,
                  languageCode: langProvider.currentLocale.languageCode,
                ),
              );

              return itemDetailProvider;
            },
          ),
          ChangeNotifierProvider<ItemEntryFieldProvider?>(
            lazy: false,
            create: (BuildContext context) {
              itemEntryFieldProvider =
                  ItemEntryFieldProvider(repo: itemEntryFieldRepository);
              itemEntryFieldProvider!.loadData(
                  dataConfig: DataConfiguration(
                      dataSourceType: DataSourceType.SERVER_DIRECT),
                  requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(psValueHolder),
                      languageCode: langProvider.currentLocale.languageCode));
              return itemEntryFieldProvider;
            },
          ),
          ChangeNotifierProvider<MarkSoldOutItemProvider?>(
            lazy: false,
            create: (BuildContext context) {
              return MarkSoldOutItemProvider(repo: productRepo);
            },
          ),
          ChangeNotifierProvider<HistoryProvider?>(
            lazy: false,
            create: (BuildContext context) {
              historyProvider = HistoryProvider(repo: historyRepo!);
              return historyProvider;
            },
          ),
          ChangeNotifierProvider<AboutUsProvider?>(
            lazy: false,
            create: (BuildContext context) {
              aboutUsProvider = AboutUsProvider(repo: aboutUsRepo);
              aboutUsProvider!.loadData(
                requestPathHolder: RequestPathHolder(
                  loginUserId: psValueHolder?.loginUserId,
                  languageCode: langProvider.currentLocale.languageCode
                ),
              );
              return aboutUsProvider;
            },
          ),
          ChangeNotifierProvider<RelatedProductProvider>(
            lazy: false,
            create: (BuildContext context) {
              relatedProductProvider = RelatedProductProvider(
                  repo: productRepo!, psValueHolder: psValueHolder!);
              return relatedProductProvider!;
            },
          ),
          ChangeNotifierProvider<UserProvider?>(
            lazy: false,
            create: (BuildContext context) {
              userProvider =
                  UserProvider(repo: userRepo, psValueHolder: psValueHolder);
              return userProvider;
            },
          ),
          ChangeNotifierProvider<TouchCountProvider?>(
            lazy: false,
            create: (BuildContext context) {
              touchCountProvider = TouchCountProvider(
                  repo: productRepo, psValueHolder: psValueHolder);
              final String? loginUserId =
                  Utils.checkUserLoginId(psValueHolder!);

              final TouchCountParameterHolder touchCountParameterHolder =
                  TouchCountParameterHolder(
                      itemId: widget.productId, userId: loginUserId);
              touchCountProvider!.postData(
                  requestBodyHolder: touchCountParameterHolder,
                  requestPathHolder:
                      RequestPathHolder(loginUserId: loginUserId, languageCode: langProvider.currentLocale.languageCode));
              return touchCountProvider;
            },
          ),
          ChangeNotifierProvider<FavouriteItemProvider?>(
              lazy: false,
              create: (BuildContext context) {
                favouriteProvider = FavouriteItemProvider(
                    repo: productRepo, psValueHolder: psValueHolder);
                return favouriteProvider;
              }),
          ChangeNotifierProvider<AppInfoProvider?>(
              lazy: false,
              create: (BuildContext context) {
                appInfoProvider = AppInfoProvider(
                    repo: appInfoRepository, psValueHolder: psValueHolder);

                appInfoProvider!
                    .loadDeleteHistorywithNotifier(appInfoParameterHolder);

                return appInfoProvider;
              }),
          ChangeNotifierProvider<GalleryProvider?>(
              lazy: false,
              create: (BuildContext context) {
                galleryProvider = GalleryProvider(repo: galleryRepository);
                return galleryProvider;
              }),
        ],
            child: Consumer2<ItemDetailProvider, AboutUsProvider>(
              builder: (BuildContext context, ItemDetailProvider provider,
                  AboutUsProvider aboutUsProvider, Widget? child) {
                if (provider.hasData) {
                  final Product product = provider.product;
                  if (!isFirstTime) {
                    historyProvider!.addToDatabase(product);

                    processToShowAdInItemDetail();
                    relatedProductProvider!.loadRelatedProductList(
                      dataConfiguration: DataConfiguration(dataSourceType: DataSourceType.SERVER_DIRECT),
                      productId: product.id,
                      categoryId: product.catId!,
                      loginUserId: Utils.checkUserLoginId(psValueHolder),
                      languageCode: langProvider.currentLocale.languageCode
                    );
                    isFirstTime = true;
                  }
                  /**
                   * UI Section is here 
                   * */
                  return Stack(
                    children: <Widget>[
                      CustomScrollView(slivers: <Widget>[
                        CustomProductExpandableAppbar(
                            isReadyToShowAppBarIcons: isReadyToShowAppBarIcons),
                        CustomTitleWithEditAndFavoriteWidget(
                          heroTagTitle: widget.heroTagTitle,
                        ),
                        CustomPriceWidget(),
                        LocationWidget(),
                        CustomDescriptionWidget(),
                        CustomDetailInfoView(
                          item: itemDetailProvider!.itemDetail.data!,
                        ),
                        CustomSafetyTipsTileView(),
                        const CustomTermsAndConditionTileView(),
                        const CustomFAQTileView(),
                        if (Utils.isOwnerItem(psValueHolder!, product)) CustomStatisticTileView(),
                        if (product.phoneNumList != '')
                        CustomContactListWidget(),
                        CustomSellerInfoTileView(),
                        CustomRelatedProductListWidget(),
                        const SliverToBoxAdapter(
                            child: SizedBox(height: PsDimens.space88))
                      ]),
                      CustomStickyBottomWidget(),
                    ],
                  );
                } else
                  return const SizedBox();
              },
            )));
  }

  void processToShowAdInItemDetail() {
    if (itemDetailProvider!.openDetailCountLimitExceeded &&
        psValueHolder!.isShowAdsInItemDetail!) {
      _createInterstitialAd();
      itemDetailProvider!.replaceDetailOpenCount(0);
    } else {
      if (psValueHolder!.detailOpenCount == null) {
        itemDetailProvider!.replaceDetailOpenCount(1);
      } else {
        final int i = psValueHolder!.detailOpenCount! + 1;
        itemDetailProvider!.replaceDetailOpenCount(i);
      }
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Utils.getInterstitialUnitId(context),
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            _interstitialAd!.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }
}
