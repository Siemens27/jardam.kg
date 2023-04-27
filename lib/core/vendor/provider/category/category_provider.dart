import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/category_repository.dart';
import '../../viewobject/category.dart';
import '../../viewobject/holder/category_parameter_holder.dart';
import '../common/ps_provider.dart';

class CategoryProvider extends PsProvider<Category> {
  CategoryProvider({
    required this.repo,
    int limit = 0,
  }) : super(repo, limit,subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  CategoryParameterHolder categoryParameterHolder =
      CategoryParameterHolder().getLatestParameterHolder();

  final CategoryRepository? repo;

  PsResource<List<Category>> get categoryList => super.dataList;

}
