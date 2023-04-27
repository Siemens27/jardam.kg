import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/about_us_repository.dart';
import '../../viewobject/about_us.dart';
import '../common/ps_provider.dart';

class AboutUsProvider extends PsProvider<AboutUs> {
  AboutUsProvider({
    required AboutUsRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<AboutUs> get aboutUs => super.data;
}
