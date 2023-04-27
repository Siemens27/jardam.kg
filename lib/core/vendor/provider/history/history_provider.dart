import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/history_repsitory.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class HistoryProvider extends PsProvider<Product> {
  HistoryProvider({
    required HistoryRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Product>> get historyList => super.dataList;
}
