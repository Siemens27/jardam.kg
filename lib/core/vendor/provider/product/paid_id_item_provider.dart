
import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/paid_ad_item_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/paid_ad_item.dart';
import '../common/ps_provider.dart';

class PaidAdItemProvider extends PsProvider<PaidAdItem> {
  PaidAdItemProvider({
    required PaidAdItemRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? psValueHolder;

  PsResource<List<PaidAdItem>> get paidAdItemList => super.dataList;
}
