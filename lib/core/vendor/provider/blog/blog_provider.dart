import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/blog_repository.dart';
import '../../viewobject/blog.dart';
import '../../viewobject/holder/blog_parameter_holder.dart';
import '../common/ps_provider.dart';

class BlogProvider extends PsProvider<Blog> {
  BlogProvider({
    required BlogRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Blog>> get blogList => super.dataList;
  BlogParameterHolder blogParameterHolder = BlogParameterHolder();
}
