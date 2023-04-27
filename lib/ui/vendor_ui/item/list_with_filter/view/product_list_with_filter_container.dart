import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../core/vendor/repository/item_entry_field_repository.dart';
import '../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../core/vendor/repository/search_user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/item/list_with_filter/components/item/filter_item_list_view.dart';
import '../../../common/search_bar_view.dart';

class ProductListWithFilterContainerView extends StatefulWidget {
  const ProductListWithFilterContainerView({
    required this.productParameterHolder,
    required this.appBarTitle,
  });
  final ProductParameterHolder productParameterHolder;
  final String? appBarTitle;

  @override
  _ProductListWithFilterContainerViewState createState() =>
      _ProductListWithFilterContainerViewState();
}

class _ProductListWithFilterContainerViewState
    extends State<ProductListWithFilterContainerView>
    with TickerProviderStateMixin {
  _ProductListWithFilterContainerViewState();

  AnimationController? animationController;
  late TextEditingController searchTextController = TextEditingController();
  late SearchBar searchBar;
  PsValueHolder? valueHolder;
  late SearchProductProvider _searchProductProvider;
  ItemEntryFieldProvider? itemEntryFieldProvider;
  ItemEntryFieldRepository? itemEntryFieldRepo;
  ProductRepository? repo1;
  SearchUserRepository? repo2;
  late AppLocalization langProvider;
  bool isGrid = true;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);

    super.initState();

    searchBar = SearchBar(
        inBar: true,
        controller: searchTextController,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print('cleared');
        },
        closeOnSubmit: false,
        onClosed: () {
          widget.productParameterHolder.searchTerm = '';
          _searchProductProvider.loadDataList(reset: true);
        });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    searchTextController.clear();
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      backgroundColor: PsColors.baseColor,
      iconTheme:
          Theme.of(context).iconTheme.copyWith(color: PsColors.iconColor),
      title: Text(widget.appBarTitle ?? '',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)
              .copyWith(color: PsColors.textColor2)),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: PsColors.iconColor, size: 24),
          onPressed: () async {
            final dynamic result = await Navigator.pushNamed(
                  context, RoutePaths.serachItemHistoryList,
                  arguments: _searchProductProvider.productParameterHolder);

              if (result != null) {
                _searchProductProvider.productParameterHolder = result;
                _searchProductProvider.loadDataList(
                  reset: true,
                  requestBodyHolder: _searchProductProvider.productParameterHolder,
                  requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(valueHolder!),
                      languageCode: langProvider.currentLocale.languageCode),
                );
              }
            // searchBar.beginSearch(context);
          },
        ),
        if (isGrid)
          IconButton(
            padding: const EdgeInsets.only(right: PsDimens.space16),
            icon: Icon(Icons.grid_view, color: PsColors.iconColor, size: 20),
            onPressed: () async {
              setState(() {
                isGrid = false;
              });
            },
          )
        else
          IconButton(
            padding: const EdgeInsets.only(right: PsDimens.space16),
            icon: Icon(Icons.list, color: PsColors.iconColor, size: 28),
            onPressed: () async {
              setState(() {
                isGrid = true;
              });
            },
          ),
      ],
      elevation: 0,
    );
  }

  void onSubmitted(String value) {
    if (!_searchProductProvider.needReset) {
      _searchProductProvider.needReset = true;
    }
    widget.productParameterHolder.searchTerm = value;
    _searchProductProvider.loadDataList(reset: true);
  }

  void resetDataList() {
    widget.productParameterHolder.searchTerm = '';
    _searchProductProvider.loadDataList(reset: true);
  }

  Future<bool> _requestPop() {
    animationController!.reverse().then<dynamic>(
      (void data) {
        if (!mounted) {
          return Future<bool>.value(false);
        }
        Navigator.pop(context, false);
        return Future<bool>.value(true);
      },
    );
    return Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context);
    repo1 = Provider.of<ProductRepository>(context);
    repo2 = Provider.of<SearchUserRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);

    print(
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<SearchProductProvider?>(
              lazy: false,
              create: (BuildContext context) {
                final SearchProductProvider provider = SearchProductProvider(
                    repo: repo1,
                    psValueHolder: valueHolder,
                    limit: valueHolder!.defaultLoadingLimit!);
                if (widget.productParameterHolder.itemLocationId == '') {
                  widget.productParameterHolder.itemLocationId =
                      valueHolder!.locationId;
                  widget.productParameterHolder.itemLocationName =
                      valueHolder!.locactionName;
                  if (valueHolder!.isSubLocation == PsConst.ONE &&
                      widget.productParameterHolder.itemLocationTownshipId ==
                          '') {
                    widget.productParameterHolder.itemLocationTownshipId =
                        valueHolder!.locationTownshipId;
                    widget.productParameterHolder.itemLocationTownshipName =
                        valueHolder!.locationTownshipName;
                  }
                }

                widget.productParameterHolder.mile = valueHolder!.mile;
                final String? loginUserId =
                    Utils.checkUserLoginId(valueHolder!);
                provider.loadDataList(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: loginUserId,
                      languageCode: langProvider.currentLocale.languageCode),
                  requestBodyHolder: widget.productParameterHolder,
                );
                _searchProductProvider = provider;
                _searchProductProvider.productParameterHolder =
                    widget.productParameterHolder;
                if (widget.appBarTitle == 'home_search__app_bar_title'.tr)
                  _searchProductProvider.needReset = false;
                print(
                    'ProductParameterHolder:: ${_searchProductProvider.productParameterHolder.toString()}');
                return _searchProductProvider;
              }),
        ],
        child: Scaffold(
          appBar: searchBar.build(context),
          body: CustomFilterItemListView(
            animationController: animationController!,
            isGrid: isGrid,
          ),
        ),
      ),
    );
  }
}
