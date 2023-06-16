import 'dart:io';
import 'package:global_student/networking/apiProvider.dart';
import '../networking/NetworkConstant.dart';

class DashBoardGet {
  ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> getEventDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_EVENT);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Get Event Details
  Future<dynamic> getUniversityDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_UNIVERSITY);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getBranchDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_BRANCH);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

// Batch Details
  Future<dynamic> getBatchDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_BATCH);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Banner  Details

  Future<dynamic> getBannersDetailsRepo() async {
    final response =
        await _apiProvider.getAfterAuth(NetworkConstant.END_POINT_GET_BANNERS);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Get Users

  Future<dynamic> getUsersDetailsRepo() async {
    final response =
        await _apiProvider.getAfterAuth(NetworkConstant.END_POINT_GET_USER);

    return response;
  }

  //Application Status

  Future<dynamic> getApplicationStatusRepo() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_APPLICATION_STATUS);

    return response;
  }

  //Qualification Dropdown get

  Future<dynamic> getQualificationlistRepo() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_QUALIFICATION_LIST);

    return response;
  }

// Board University List get
  Future<dynamic> getBoardlistRepo() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_GET_BOARD);

    return response;
  }

  // post Document 10th

  Future<dynamic> postDocument(Map parameter, File files) async {
    final response = await _apiProvider.postAfterAuth(
        parameter, NetworkConstant.END_POINT_POST_DOCUMENT, files);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Upload More Document

  Future<dynamic> getuploadmoredocument() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_MORE_GET_DOCUMENT);

    return response;
  }

  //Get Qualification

  Future<dynamic> getQualificationRepo() async {
    final response = await _apiProvider
        .getAfterAuth(NetworkConstant.END_POINT_GET_QUALIFICATION);

    return response;
  }

  //Upload More Document

  Future<dynamic> postMoreDocument(Map parameter, List<File> files) async {
    final response = await _apiProvider.postAfterAuthWithMultipart(
        parameter, NetworkConstant.END_POINT_UPLOAD_MORE_DOCUMENT, files);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //GetVisa Module

  Future<dynamic> getvisadeatails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_VISA_GET);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

//Upload More Document

  Future<dynamic> UploadVisaDocument(Map parameter, File files) async {
    final response = await _apiProvider.postAfterAuth(
        parameter, NetworkConstant.END_POINT_UPLOAD_VISA, files);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

//final submit visa
  Future<dynamic> finalvisasubmit(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_FINAL_VISA_SUBMIT);

    return response; //GetApplicationDetailsResponse.fromJson(response);
  }
}


//final submit visa


