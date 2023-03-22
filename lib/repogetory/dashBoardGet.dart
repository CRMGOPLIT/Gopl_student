import 'dart:developer';
import 'dart:io';

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
}
