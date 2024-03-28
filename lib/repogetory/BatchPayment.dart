import 'package:global_student/networking/apiProvider.dart';
import 'package:global_student/networking/networkConstant.dart';

class BatchpaymentRepo {
  final ApiProvider _apiProvider = ApiProvider();

  // Future<dynamic> batchperformadetails(
  //   Map<String, dynamic> parameter,
  // ) async {
  //   final response = await _apiProvider.getDropdownParams(
  //       parameter, NetworkConstant.END_POINT_BATCH_PERFORMA);
  //   return response;
  // }
  Future<dynamic> gethisroryDetailsRepo() async {
    final response = await _apiProvider
        .getAfterAuth(NetworkConstant.END_POINT_PAYMENT_HISTORY);

    return response;
  }

  Future<dynamic> batchreciptdetails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_BATCH_RECIPT);
    return response;
  }

  Future<dynamic> getPerformaCreateDetailsRepo() async {
    final response = await _apiProvider
        .getAfterAuth(NetworkConstant.END_POINT_PERFORMA_CREATE);

    return response;
  }

  Future<dynamic> createOrderBatch(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.paymentGatway(
        parameter, NetworkConstant.END_POINT_CREATE_ORDER);
    return response;
  }

  Future<dynamic> veryfyPayment(Map<String, String> parameter) async {
    final response = await _apiProvider.postBeforeAuth(
        parameter, NetworkConstant.END_POINT_VERYFY_PAYMENT);
    return response;
  }

  Future<dynamic> applyBatch(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.paymentGatway(
        parameter, NetworkConstant.END_POINT_BATCH_APPLY);
    return response;
  }
}
