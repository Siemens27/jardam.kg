import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../db/common/ps_data_source_manager.dart';
import '../../repository/product_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/follower_uer_item_list_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class ItemListFromFollowersProvider extends PsProvider<Product> {
  ItemListFromFollowersProvider({
    required ProductRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }
  FollowUserItemParameterHolder followUserItemParameterHolder =
      FollowUserItemParameterHolder().getLatestParameterHolder();

  ProductRepository? _repo;
  PsValueHolder? psValueHolder;

  PsResource<List<Product>> get itemListFromFollowersList => super.dataList;

  Future<dynamic> loadItemListFromFollowersList({
    required Map<dynamic, dynamic> jsonMap,
    required String? loginUserId,required String? languageCode,
    DataConfiguration? dataConfig,
  }) async {
    isLoading = true;
  final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo!.getAllItemListFromFollower(
      super.dataListStreamController,
      jsonMap,
      loginUserId,
      limit,
      offset,
      PsStatus.PROGRESS_LOADING,
      languageCode!,
      dataConfig ?? defaultDataConfig,
    );
  }

  Future<dynamic> nextItemListFromFollowersList({
    required Map<dynamic, dynamic> jsonMap,
    required String? loginUserId,required String? languageCode,
    DataConfiguration? dataConfig,
  }) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();
  final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    if (!isLoading && !isReachMaxData) {
      super.isLoading = true;
      await _repo!.getNextPageItemListFromFollower(
        super.dataListStreamController,
        jsonMap,
        loginUserId!,
        limit,
        offset,
        PsStatus.PROGRESS_LOADING,
         languageCode!,
        dataConfig ?? defaultDataConfig,
      );
    }
  }

  Future<void> resetItemListFromFollowersList({
    required Map<dynamic, dynamic> jsonMap,
    required String? loginUserId,required String? languageCode,
    DataConfiguration? dataConfig,
  }) async {
    isConnectedToInternet = await Utils.checkInternetConnectivity();
    isLoading = true;

    updateOffset(0);
  final DataConfiguration defaultDataConfig =
        await super.getDefaultDataConfig;
    await _repo!.getAllItemListFromFollower(
      super.dataListStreamController,
      jsonMap,
      loginUserId,
      limit,
      offset,
      PsStatus.PROGRESS_LOADING,
       languageCode!,
      dataConfig ?? defaultDataConfig,
    );

    isLoading = false;
  }

  bool get hasLoginUserId {
    return psValueHolder != null && psValueHolder!.loginUserId != null && psValueHolder!.loginUserId != '';
  }
}
