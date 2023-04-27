import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../core/vendor/repository/product_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_item_list.dart';
import '../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_nav_items.dart';
import '../../../../common/ps_admob_banner_widget.dart';
import '../../../../common/ps_app_bar_widget.dart';

class ProductListWithFilterView extends StatefulWidget {
  const ProductListWithFilterView({
    Key? key,
    required this.productParameterHolder,
    required this.animationController,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);

  final ProductParameterHolder productParameterHolder;
  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  @override
  _ProductListWithFilterViewState createState() =>
      _ProductListWithFilterViewState();
}

class _ProductListWithFilterViewState extends State<ProductListWithFilterView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  SearchProductProvider? _searchProductProvider;
  late ProductRepository _repo;
  late PsValueHolder _valueHolder;
  bool isGrid = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchProductProvider!.loadNextDataList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _repo = Provider.of<ProductRepository>(context);
    _valueHolder = Provider.of<PsValueHolder>(context);
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);

    print(
        '............................Build UI Again............................');

    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(widget.scaffoldKey.currentContext ?? context)
                .viewPadding
                .top),
        child: WillPopScope(
          onWillPop: () async {
            return Future<bool>.value(false);
          },
          child: Scaffold(
            appBar: PsAppbarWidget(
              appBarTitle: widget.title,
              leading: Center(
                  child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
              )),
              actionWidgets: <Widget>[
                if (isGrid)
                  IconButton(
                    icon: Icon(Icons.grid_view,
                        color: PsColors.iconColor, size: 20),
                    onPressed: () async {
                      setState(() {
                        isGrid = false;
                      });
                    },
                  )
                else
                  IconButton(
                    icon: Icon(Icons.list, color: PsColors.iconColor, size: 28),
                    onPressed: () async {
                      setState(() {
                        isGrid = true;
                      });
                    },
                  ),
              ],
            ),
            body: ChangeNotifierProvider<SearchProductProvider?>(
                lazy: false,
                create: (BuildContext context) {
                  final SearchProductProvider provider = SearchProductProvider(
                      repo: _repo,
                      psValueHolder: _valueHolder,
                      limit: _valueHolder.defaultLoadingLimit!);

                  if (_valueHolder.isSubLocation == PsConst.ONE) {
                    widget.productParameterHolder.itemLocationTownshipId =
                        _valueHolder.locationTownshipId;
                  }
                  final String? loginUserId =
                      Utils.checkUserLoginId(_valueHolder);
                  provider.loadDataList(
                      requestPathHolder: RequestPathHolder(
                          loginUserId: loginUserId,
                          languageCode:
                              langProvider.currentLocale.languageCode),
                      requestBodyHolder: widget.productParameterHolder);

                  _searchProductProvider = provider;
                  _searchProductProvider!.productParameterHolder =
                      widget.productParameterHolder;

                  return _searchProductProvider;
                },
                child: Column(
                  children: <Widget>[
                    const CustomFilterNavItems(),
                    CustomItemListView(
                      animationController: widget.animationController,
                      isGrid: isGrid,
                    ),
                    const PsAdMobBannerWidget(),
                  ],
                )),
          ),
        ));
  }
}
