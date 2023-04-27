import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/category_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/category/component/menu_vertical/widgets/category_sort_widget.dart';
import '../../../custom_ui/category/component/menu_vertical/widgets/category_vertical_list_view.dart';
import '../../common/ps_admob_banner_widget.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/search_bar_view.dart';

class CategorySortingListViewContainer extends StatefulWidget {
  const CategorySortingListViewContainer({this.keyword = ''});
  final String? keyword;
  @override
  _CategorySortingListViewState createState() {
    return _CategorySortingListViewState();
  }
}

class _CategorySortingListViewState
    extends State<CategorySortingListViewContainer>
    with SingleTickerProviderStateMixin {
  CategoryProvider? _categoryProvider;
  late SearchBar searchBar;
  late TextEditingController searchTextController = TextEditingController();
  AnimationController? animationController;
  CategoryRepository? repo1;
  PsValueHolder? psValueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  late AppLocalization langProvider;

  void resetCategoryListByKeyword(String value) {
    if (_categoryProvider != null) {
      _categoryProvider!.categoryParameterHolder.keyword = value.trim();
      _categoryProvider!.loadDataList(
        reset: true,
      );
    }
  }

  PsAppbarWidget buildAppBar(BuildContext context) {
    searchTextController.clear();
    return PsAppbarWidget(
      appBarTitle: 'dashboard__category_list'.tr,
      actionWidgets: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: PsColors.iconColor),
          onPressed: () async {
            final dynamic result = await Navigator.pushNamed(
                  context, RoutePaths.serachCategoryHistoryList,
                  arguments: _categoryProvider!.categoryParameterHolder);

              if (result != null) {
                _categoryProvider!.categoryParameterHolder = result;
                _categoryProvider!.loadDataList(
                  reset: true,
                  requestBodyHolder: _categoryProvider!.categoryParameterHolder,
                  requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(psValueHolder!),
                      languageCode: langProvider.currentLocale.languageCode)
                );

              // searchBar.beginSearch(context);
            }
          },
        ),
      ],
    );
  }

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && psValueHolder!.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    searchBar = SearchBar(
        inBar: true,
        controller: searchTextController,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted:
            resetCategoryListByKeyword, //search categories after keyword is submitted
        closeOnSubmit: false,
        onCleared: () {
          print('cleared');
        },
        onClosed: () {
          resetCategoryListByKeyword('');
        });
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<CategoryRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    if (!isConnectedToInternet && psValueHolder!.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
    Future<bool> _requestPop() {
      animationController!.reverse();
      resetCategoryListByKeyword('');
      if (!mounted) {
        return Future<bool>.value(false);
      } else {
        Navigator.pop(context);
        return Future<bool>.value(true);
      }
    }

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: searchBar.build(context), //appbar with search icon
          body: ChangeNotifierProvider<CategoryProvider?>(
            lazy: false,
            create: (BuildContext context) {
              final CategoryProvider provider = CategoryProvider(repo: repo1);
              _categoryProvider = provider;
              provider.categoryParameterHolder.keyword = widget.keyword;
              provider.loadDataList(
                  requestBodyHolder: provider.categoryParameterHolder,
                  requestPathHolder: RequestPathHolder(
                      loginUserId: Utils.checkUserLoginId(psValueHolder!),
                      languageCode: langProvider.currentLocale.languageCode));

              return _categoryProvider;
            },
            child: Consumer<CategoryProvider>(builder: (BuildContext context,
                CategoryProvider provider, Widget? child) {
              return Column(
                children: <Widget>[
                  const PsAdMobBannerWidget(),
                  CustomCategorySortWidget(),
                  CustomCategoryVerticalListView(
                      animationController: animationController!)
                ],
              );
            }),
          ),
        ));
  }
}
