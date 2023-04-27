import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/package_bought_transaction_history_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/buyadpost_transaction.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/package_transaction_holder.dart';
import '../common/ps_provider.dart';

class PackageTranscationHistoryProvider extends PsProvider<PackageTransaction> {
  PackageTranscationHistoryProvider({
    required PackageTranscationHistoryRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION){
      _repo = repo!;
  }

  late PackgageBoughtTransactionParameterHolder holder =
      PackgageBoughtTransactionParameterHolder();
  PsValueHolder? psValueHolder;

  PsResource<List<PackageTransaction>> get transactionList => super.dataList;



  PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;  

 late PackageTranscationHistoryRepository _repo;

   Future<dynamic> deletePacakgeHistoryList(
     Map<dynamic, dynamic> jsonMap,String languageCode,
    String? loginUserId,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.deletePacakgeHistoryList(
        jsonMap, loginUserId, isConnectedToInternet, PsStatus.PROGRESS_LOADING,languageCode);

    return _apiStatus;
  }
}
