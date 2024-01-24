import 'package:global_student/networking/apiProvider.dart';
import '../networking/NetworkConstant.dart';

class BatchpaymentRepo {
  final ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> batchperformadetails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_BATCH_PERFORMA);
    return response;
  }

  Future<dynamic> batchreciptdetails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_BATCH_RECIPT);
    return response;
  }
}
