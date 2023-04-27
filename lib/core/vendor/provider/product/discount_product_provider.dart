import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class DiscountProductProvider extends PsProvider<Product> {
  DiscountProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productDiscountParameterHolder =
      ProductParameterHolder().getDiscountParameterHolder();

  PsResource<List<Product>> get productList => super.dataList;
}
