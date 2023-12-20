import 'dart:io';

import 'package:global_student/networking/apiProvider.dart';
import '../networking/NetworkConstant.dart';

class GofairRepo {
  final ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> getappointmentdetails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_APPOINTMENT_DETAILS);
    return response;
  }

  Future<dynamic> getfairdetailsdetails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_GOFAIR_DETAILS);
    return response;
  }

  Future<dynamic> gofairdrop(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.postWithToken(
        parameter, NetworkConstant.END_POINT_GOFAIR_DROPDOWN);
    return response;
  }

  Future<dynamic> bookappointmentdata(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.postWithToken(
        parameter, NetworkConstant.END_POINT_GOFAIR_POSTDATA);
    return response;
  }

  Future<dynamic> updatefairappointment(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.postWithToken(
        parameter, NetworkConstant.END_POINT_GOFAIR_WALKIN);
    return response;
  }

  //Upload More Document
  Future<dynamic> postFairDocument(
      Map<String, dynamic> parameter, List<File> files) async {
    final response = await _apiProvider.postAfterAuthWithMultipart(
        parameter, NetworkConstant.END_POINT_GOFAIR_DOCUMENT, files);

    return response;
  }

  Future<dynamic> fairdocumentget(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_GOFAIR_DOCUMENT_GET);
    return response;
  }

  Future<dynamic> sendToken(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.courseEmailPost(
        parameter, NetworkConstant.END_POINT_SEND_TOKEN);
    return response;
  }

  //Get Users
  Future<dynamic> getVersionDetails() async {
    final response =
        await _apiProvider.getAfterAuth(NetworkConstant.END_POINT_VERSION);
    return response;
  }
}
