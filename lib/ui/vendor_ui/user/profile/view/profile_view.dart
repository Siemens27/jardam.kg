import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/package_bought/package_bought_transaction_provider.dart';
import '../../../../../../core/vendor/provider/product/added_item_provider.dart';
import '../../../../../../core/vendor/provider/product/disabled_product_provider.dart';
import '../../../../../../core/vendor/provider/product/paid_id_item_provider.dart';
import '../../../../../../core/vendor/provider/product/pending_product_provider.dart';
import '../../../../../../core/vendor/provider/product/rejected_product_provider.dart';
import '../../../../../../core/vendor/provider/product/sold_out_item_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/package_bought_transaction_history_repository.dart';
import '../../../../../../core/vendor/repository/paid_ad_item_repository.dart';
import '../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/package_transaction_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/holder/user_unread_message_parameter_holder.dart';
import '../../../../custom_ui/user/paid_item_list/component/horizontal/paid_product_list_widget.dart';
import '../../../../custom_ui/user/profile/component/detail_info/profile_detail_widget.dart';
import '../../../../custom_ui/user/profile/component/product_list/active_product_list_widget.dart';
import '../../../../custom_ui/user/profile/component/product_list/disabled_product_list_widget.dart';
import '../../../../custom_ui/user/profile/component/product_list/pending_product_list_widget.dart';
import '../../../../custom_ui/user/profile/component/product_list/rejected_product_list_widget.dart';
import '../../../../custom_ui/user/profile/component/product_list/sold_out_product_list_widget.dart';
import '../../../common/ps_app_bar_widget.dart';
import '../component/detail_info/widgets/profile_pop_up.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
    required this.animationController,
    required this.flag,
    this.userId,
    required this.scaffoldKey,
    required this.callLogoutCallBack,
    required this.onDeactivate,
  }) : super(key: key);
  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int? flag;
  final String? userId;
  final Function callLogoutCallBack, onDeactivate;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  UserRepository? userRepository;
  PsValueHolder? psValueHolder;
  UserProvider? provider;
  PaidAdItemProvider? paidAdItemProvider;
  PackageTranscationHistoryProvider? packageTranscationHistoryProvider;
  AddedItemProvider? productProvider;
  SoldOutItemProvider? soldOutItemProvider;
  PendingProductProvider? pendingProductProvider;
  DisabledProductProvider? disabledProductProvider;
  RejectedProductProvider? rejectedProductProvider;
  ProductRepository? productRepository;
  PaidAdItemRepository? paidAdItemRepository;
  PackageTranscationHistoryRepository? packageTranscationHistoryRepository;
  bool firstTime = true;
  ScrollController scrollController = ScrollController();
  AnimationController? animationControllerForFab;
  late AppLocalization langProvider;

  @override
  void initState() {
    animationControllerForFab = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 1);

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (animationControllerForFab != null) {
          animationControllerForFab!.reverse();
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (animationControllerForFab != null) {
          animationControllerForFab!.forward();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.animationController.forward();
    langProvider = Provider.of<AppLocalization>(context);
    userRepository = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    productRepository = Provider.of<ProductRepository>(context);
    paidAdItemRepository = Provider.of<PaidAdItemRepository>(context);
    packageTranscationHistoryRepository =
        Provider.of<PackageTranscationHistoryRepository>(context);

    //when login again, loadUnreadCount
    if (firstTime) {
      final UserUnreadMessageProvider userUnreadMessageProvider =
          Provider.of<UserUnreadMessageProvider>(context);
      final UserUnreadMessageParameterHolder userUnreadMessageHolder =
          UserUnreadMessageParameterHolder(
              userId: Utils.checkUserLoginId(psValueHolder),
              deviceToken: psValueHolder!.deviceToken);
      userUnreadMessageProvider.loadData(
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(psValueHolder),
              headerToken: psValueHolder!.headerToken),
          requestBodyHolder: userUnreadMessageHolder);
      firstTime = false;
    }

    provider = UserProvider(repo: userRepository, psValueHolder: psValueHolder);

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<UserProvider>(
              lazy: false,
              create: (BuildContext context) {
                print(provider!.getCurrentFirebaseUser());
                if (provider!.psValueHolder!.loginUserId == null ||
                    provider!.psValueHolder!.loginUserId == '') {
                  provider!.userParameterHolder.id = widget.userId;
                  provider!.getUser(
                      widget.userId, langProvider.currentLocale.languageCode);
                } else {
                  provider!.userParameterHolder.id =
                      provider!.psValueHolder!.loginUserId;
                  provider!.getUser(provider!.psValueHolder!.loginUserId,
                      langProvider.currentLocale.languageCode);
                }
                print('..................USER_ID...................');
                print(provider!.userParameterHolder.id);
                return provider!;
              }),
          ChangeNotifierProvider<PaidAdItemProvider?>(
              lazy: false,
              create: (BuildContext context) {
                paidAdItemProvider = PaidAdItemProvider(
                    repo: paidAdItemRepository,
                    psValueHolder: psValueHolder,
                    limit: psValueHolder!.defaultLoadingLimit!);
                if (paidAdItemProvider!.psValueHolder!.loginUserId == null ||
                    paidAdItemProvider!.psValueHolder!.loginUserId == '') {
                  paidAdItemProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: widget.userId,
                          headerToken: psValueHolder!.headerToken,
                          languageCode:
                              langProvider.currentLocale.languageCode));
                } else {
                  paidAdItemProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId:
                              paidAdItemProvider!.psValueHolder!.loginUserId,
                          headerToken: psValueHolder!.headerToken,
                          languageCode:
                              langProvider.currentLocale.languageCode));
                }

                return paidAdItemProvider;
              }),
          ChangeNotifierProvider<PackageTranscationHistoryProvider?>(
              lazy: false,
              create: (BuildContext context) {
                packageTranscationHistoryProvider =
                    PackageTranscationHistoryProvider(
                        repo: packageTranscationHistoryRepository,
                        psValueHolder: psValueHolder);
                final PackgageBoughtTransactionParameterHolder
                    packgageBoughtParameterHolder =
                    PackgageBoughtTransactionParameterHolder(
                        userId: psValueHolder!.loginUserId);
                if (packageTranscationHistoryProvider!
                            .psValueHolder!.loginUserId ==
                        null ||
                    packageTranscationHistoryProvider!
                            .psValueHolder!.loginUserId ==
                        '') {
                  packageTranscationHistoryProvider!.loadDataList(
                      requestBodyHolder: packgageBoughtParameterHolder,
                      requestPathHolder: RequestPathHolder(
                          loginUserId: psValueHolder!.loginUserId,
                          headerToken: psValueHolder!.headerToken,
                          languageCode:
                              langProvider.currentLocale.languageCode));
                } else {
                  packageTranscationHistoryProvider!.loadDataList(
                      requestBodyHolder: packgageBoughtParameterHolder,
                      requestPathHolder: RequestPathHolder(
                          loginUserId: psValueHolder!.loginUserId,
                          headerToken: psValueHolder!.headerToken));
                }

                return packageTranscationHistoryProvider!;
              }),
          ChangeNotifierProvider<AddedItemProvider?>(
              lazy: false,
              create: (BuildContext context) {
                productProvider = AddedItemProvider(
                    repo: productRepository,
                    psValueHolder: psValueHolder,
                    limit: psValueHolder!.defaultLoadingLimit!);
                productProvider!.addedUserParameterHolder.mile =
                    psValueHolder!.mile;
                if (productProvider!.psValueHolder!.loginUserId == null ||
                    productProvider!.psValueHolder!.loginUserId == '') {
                  productProvider!.addedUserParameterHolder.addedUserId =
                      widget.userId;
                  productProvider!.addedUserParameterHolder.status = '1';
                  productProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          productProvider!.addedUserParameterHolder);
                } else {
                  productProvider!.addedUserParameterHolder.addedUserId =
                      productProvider!.psValueHolder!.loginUserId;
                  productProvider!.addedUserParameterHolder.status = '1';
                  productProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          productProvider!.addedUserParameterHolder);
                }
                return productProvider;
              }),
          ChangeNotifierProvider<SoldOutItemProvider?>(
              lazy: false,
              create: (BuildContext context) {
                soldOutItemProvider = SoldOutItemProvider(
                    repo: productRepository,
                    psValueHolder: psValueHolder,
                    limit: psValueHolder!.defaultLoadingLimit!);
                soldOutItemProvider!.addedUserParameterHolder.mile =
                    psValueHolder!.mile;
                if (soldOutItemProvider!.psValueHolder!.loginUserId == null ||
                    soldOutItemProvider!.psValueHolder!.loginUserId == '') {
                  soldOutItemProvider!.addedUserParameterHolder.addedUserId =
                      widget.userId;
                  soldOutItemProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          soldOutItemProvider!.addedUserParameterHolder);
                } else {
                  soldOutItemProvider!.addedUserParameterHolder.addedUserId =
                      soldOutItemProvider!.psValueHolder!.loginUserId;
                  soldOutItemProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          soldOutItemProvider!.addedUserParameterHolder);
                }
                return soldOutItemProvider;
              }),
          ChangeNotifierProvider<PendingProductProvider?>(
              lazy: false,
              create: (BuildContext context) {
                pendingProductProvider = PendingProductProvider(
                    repo: productRepository,
                    psValueHolder: psValueHolder,
                    limit: psValueHolder!.defaultLoadingLimit!);
                pendingProductProvider!.addedUserParameterHolder.mile =
                    psValueHolder!.mile;
                if (pendingProductProvider!.psValueHolder!.loginUserId ==
                        null ||
                    pendingProductProvider!.psValueHolder!.loginUserId == '') {
                  pendingProductProvider!.addedUserParameterHolder.addedUserId =
                      widget.userId;
                  pendingProductProvider!.addedUserParameterHolder.status = '0';
                  pendingProductProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          pendingProductProvider!.addedUserParameterHolder);
                } else {
                  pendingProductProvider!.addedUserParameterHolder.addedUserId =
                      pendingProductProvider!.psValueHolder!.loginUserId;
                  pendingProductProvider!.addedUserParameterHolder.status = '0';
                  pendingProductProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          pendingProductProvider!.addedUserParameterHolder);
                }

                return pendingProductProvider;
              }),
          ChangeNotifierProvider<DisabledProductProvider?>(
              lazy: false,
              create: (BuildContext context) {
                disabledProductProvider = DisabledProductProvider(
                    repo: productRepository,
                    psValueHolder: psValueHolder,
                    limit: psValueHolder!.defaultLoadingLimit!);
                disabledProductProvider!.addedUserParameterHolder.mile =
                    psValueHolder!.mile;
                if (disabledProductProvider!.psValueHolder!.loginUserId ==
                        null ||
                    disabledProductProvider!.psValueHolder!.loginUserId == '') {
                  disabledProductProvider!
                      .addedUserParameterHolder.addedUserId = widget.userId;
                  disabledProductProvider!.addedUserParameterHolder.status =
                      '2';
                  disabledProductProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          disabledProductProvider!.addedUserParameterHolder);
                } else {
                  disabledProductProvider!
                          .addedUserParameterHolder.addedUserId =
                      disabledProductProvider!.psValueHolder!.loginUserId;
                  disabledProductProvider!.addedUserParameterHolder.status =
                      '2';
                  disabledProductProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          disabledProductProvider!.addedUserParameterHolder);
                }

                return disabledProductProvider;
              }),
          ChangeNotifierProvider<RejectedProductProvider?>(
              lazy: false,
              create: (BuildContext context) {
                rejectedProductProvider = RejectedProductProvider(
                    repo: productRepository,
                    psValueHolder: psValueHolder,
                    limit: psValueHolder!.defaultLoadingLimit!);
                rejectedProductProvider!.addedUserParameterHolder.mile =
                    psValueHolder!.mile;
                if (rejectedProductProvider!.psValueHolder!.loginUserId ==
                        null ||
                    rejectedProductProvider!.psValueHolder!.loginUserId == '') {
                  rejectedProductProvider!
                      .addedUserParameterHolder.addedUserId = widget.userId;
                  rejectedProductProvider!.addedUserParameterHolder.status =
                      '3';
                  rejectedProductProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          rejectedProductProvider!.addedUserParameterHolder);
                } else {
                  rejectedProductProvider!
                          .addedUserParameterHolder.addedUserId =
                      rejectedProductProvider!.psValueHolder!.loginUserId;
                  rejectedProductProvider!.addedUserParameterHolder.status =
                      '3';
                  rejectedProductProvider!.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          languageCode: langProvider.currentLocale.languageCode,
                          loginUserId: Utils.checkUserLoginId(psValueHolder!)),
                      requestBodyHolder:
                          rejectedProductProvider!.addedUserParameterHolder);
                }

                return rejectedProductProvider;
              }),
        ],
        /**
           * UI SECTION
           */
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(widget.scaffoldKey.currentContext ?? context)
                  .viewPadding
                  .top),
          child: Scaffold(
            appBar: PsAppbarWidget(
              appBarTitle: 'profile__title'.tr,
              leading: Center(
                  child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
              )),
              actionWidgets: <Widget>[
                ProfilePopUpWidget(
                  callLogout: widget.callLogoutCallBack,
                  onDeactivate: widget.onDeactivate,
                  scaffoldKey: widget.scaffoldKey,
                ),
              ],
            ),
            body: CustomScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  CustomProfileDetailWidget(
                      animationController: widget.animationController,
                      callLogoutCallBack: widget.callLogoutCallBack),
                  CustomPaidProductListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomActiveProductListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomPendingProductListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomSoldOutProductListWidget(
                    animationController: widget.animationController,
                  ),
                  CustomRejectedListingDataWidget(
                    animationController: widget.animationController,
                  ),
                  CustomDisabledListingDataWidget(
                    animationController: widget.animationController,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: PsDimens.space80,
                    ),
                  )
                ]),

            // )),
          ),
        ));
  }
}
