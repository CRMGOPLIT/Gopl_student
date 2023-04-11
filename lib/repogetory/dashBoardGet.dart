import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:global_student/networking/apiProvider.dart';

import '../networking/NetworkConstant.dart';

class DashBoardGet {
  ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> getEventDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_EVENT);
    // print(response.body);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Get Event Details
  Future<dynamic> getUniversityDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_UNIVERSITY);
    // print(response.body);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getBranchDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_BRANCH);
    // print(response.body);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

// Batch Details
  Future<dynamic> getBatchDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_BATCH);
    // print(response.body);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Banner  Details

  Future<dynamic> getBannersDetailsRepo() async {
    final response =
        await _apiProvider.getLocal(NetworkConstant.END_POINT_GET_BANNERS);
    // print(response.body);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Get Users

  Future<dynamic> getUsersDetailsRepo() async {
    final response =
        await _apiProvider.getAfterAuth(NetworkConstant.END_POINT_GET_USER);
    // print(response.body);
    return response;
  }

  //Application Status

  Future<dynamic> getApplicationStatusRepo() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_APPLICATION_STATUS);
    // print(response.body);
    return response;
  }

  //Qualification Dropdown get

  Future<dynamic> getQualificationlistRepo() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_QUALIFICATION_LIST);
    // print(response.body);
    return response;
  }

// Board University List get
  Future<dynamic> getBoardlistRepo() async {
    final response = await _apiProvider
        .getAfterAuthlocal(NetworkConstant.END_POINT_GET_BOARD);
    // print(response.body);
    return response;
  }

  // post Document 10th

  Future<dynamic> postDocument(Map parameter, File files) async {
    final response = await _apiProvider.postAfterAuth(
        parameter, NetworkConstant.END_POINT_POST_DOCUMENT, files);

    // debugger();
    // print(response);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }
}
