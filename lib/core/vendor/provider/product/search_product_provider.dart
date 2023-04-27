import '../../../vendor/provider/language/app_localization_provider.dart';
import '../../../vendor/viewobject/item_location.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class SearchProductProvider extends PsProvider<Product> {
  SearchProductProvider({
    required ProductRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? psValueHolder;
  PsResource<List<Product>> get productList => super.dataList;

  bool needReset = true;

  late ProductParameterHolder productParameterHolder;

  bool isSwitchedFeaturedProduct = false;
  bool isSwitchedDiscountPrice = false;

  String? selectedCategoryName = '';
  String? selectedSubCategoryName = '';
  String? selectedItemTypeName = '';
  String? selectedItemConditionName = '';
  String? selectedItemPriceTypeName = '';
  String? selectedItemDealOptionName = '';
  String? selectedItemIsSoldOut = '';
  String? selectedLocationName = '';
  String? selectedLocationTownshipName = '';

  String? categoryId = '';
  String? subCategoryId = '';
  String? itemTypeId = 'product_list__category_all'.tr; //default
  String? itemConditionId = '';
  String? itemPriceTypeId = '';
  String? itemDealOptionId = '';
  String? itemIsSoldOut = '';
  String? locationId = '';
  String? locationTownshipId = '';

  bool isfirstRatingClicked = false;
  bool isSecondRatingClicked = false;
  bool isThirdRatingClicked = false;
  bool isfouthRatingClicked = false;
  bool isFifthRatingClicked = false;

  void onCityDataChoose(dynamic locationResult) {
    if (locationResult != null && locationResult is ItemLocation) {
      locationId = locationResult.id;
      locationTownshipId = '';
      selectedLocationName = locationResult.name;
      selectedLocationTownshipName = 'product_list__category_all'.tr;
    } else if (locationResult) {
      locationId = '';
      selectedLocationName = 'product_list__category_all'.tr;
      locationTownshipId = '';
      selectedLocationTownshipName = 'product_list__category_all'.tr;
    }
    notifyListeners();
  }

  void clearData() {
    locationId = '';
    locationTownshipId = '';

    itemIsSoldOut = '';

    productParameterHolder.itemLocationId = '';
    selectedLocationName = 'product_list__category_all'.tr;
    productParameterHolder.itemLocationTownshipId = '';
    selectedLocationTownshipName = 'product_list__category_all'.tr;

    productParameterHolder.isSoldOut = '';
    productParameterHolder.productRelation?.clear();
    notifyListeners();
  }
}
