import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class NearestProductProvider extends PsProvider<Product> {
  NearestProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productNearestParameterHolder =
      ProductParameterHolder().getNearestParameterHolder();
  PsResource<List<Product>> get productList => super.dataList;

  // Future<void> initSubscription() async {
  //   if (productListStream != null) {
  //     await productListStream?.close();
  //   }
  //   if (subscription != null) {
  //     await subscription?.cancel();
  //   }

  //   productListStream = StreamController<PsResource<List<Product>>>.broadcast();
  //   subscription =
  //       productListStream!.stream.listen((PsResource<List<Product>> resource) {
  //     updateOffset(resource.data!.length);

  //     _productList = resource;
  //     _productList.data = Product().checkDuplicate(resource.data!);

  //     if (resource.status != PsStatus.BLOCK_LOADING &&
  //         resource.status != PsStatus.PROGRESS_LOADING) {
  //       isLoading = false;
  //     }

  //     if (!isDispose) {
  //       notifyListeners();
  //     }
  //   });
  // }

  // Future<dynamic> loadProductList(
  //     String loginUserId, ProductParameterHolder productParameterHolder) async {
  //   isLoading = true;

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   await _repo.getProductList(
  //       productListStream,
  //       isConnectedToInternet,
  //       loginUserId,
  //       limit,
  //       offset,
  //       PsStatus.PROGRESS_LOADING,
  //       productParameterHolder);

  //   if (daoSubscription != null) {
  //     await daoSubscription.cancel();
  //   }
  //   await initSubscription();
  //   daoSubscription = await _repo.subscribeProductList(
  //       productListStream, PsStatus.PROGRESS_LOADING, productParameterHolder);
  // }

  // Future<dynamic> resetProductList(
  //     String loginUserId, ProductParameterHolder productParameterHolder) async {
  //   isLoading = true;

  //   updateOffset(0);

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   // daoSubscription = await _repo.getProductList(
  //   //     productListStream,
  //   //     isConnectedToInternet,
  //   //     loginUserId,
  //   //     limit,
  //   //     offset,
  //   //     PsStatus.PROGRESS_LOADING,
  //   //     productParameterHolder);

  //   await _repo.getProductList(
  //       productListStream,
  //       isConnectedToInternet,
  //       loginUserId,
  //       limit,
  //       offset,
  //       PsStatus.PROGRESS_LOADING,
  //       productParameterHolder);

  //   if (daoSubscription != null) {
  //     await daoSubscription.cancel();
  //   }
  //   await initSubscription();
  //   daoSubscription = await _repo.subscribeProductList(
  //       productListStream, PsStatus.PROGRESS_LOADING, productParameterHolder);

  //   isLoading = false;
  // }

  // Future<dynamic> nextProductList(
  //     String loginUserId, ProductParameterHolder productParameterHolder) async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   if (!isLoading && !isReachMaxData) {
  //     super.isLoading = true;

  //     // daoSubscription = await _repo.getProductList(
  //     //     productListStream,
  //     //     isConnectedToInternet,
  //     //     loginUserId,
  //     //     limit,
  //     //     offset,
  //     //     PsStatus.PROGRESS_LOADING,
  //     //     productParameterHolder);
  //     await _repo.getProductList(
  //         productListStream,
  //         isConnectedToInternet,
  //         loginUserId,
  //         limit,
  //         offset,
  //         PsStatus.PROGRESS_LOADING,
  //         productParameterHolder);
  //   }
  // }
}
