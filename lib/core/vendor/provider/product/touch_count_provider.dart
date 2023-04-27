import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class TouchCountProvider extends PsProvider<ApiStatus> {
  TouchCountProvider(
      {required ProductRepository? repo,
      required this.psValueHolder,
      int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION);

  PsValueHolder? psValueHolder;

}
