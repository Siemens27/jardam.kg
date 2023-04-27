import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class SoldOutItemProvider extends PsProvider<Product> {
  SoldOutItemProvider({
    required ProductRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? psValueHolder;
  ProductParameterHolder addedUserParameterHolder =
      ProductParameterHolder().getSoldOutParameterHolder();

  PsResource<List<Product>> get itemList => super.dataList;
}
