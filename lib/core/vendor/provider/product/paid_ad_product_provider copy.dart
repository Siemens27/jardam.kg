import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class PaidAdProductProvider extends PsProvider<Product> {
  PaidAdProductProvider({
    required ProductRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productPaidAdParameterHolder =
      ProductParameterHolder().getPaidItemParameterHolder();
  PsResource<List<Product>> get productList => super.dataList;
}
