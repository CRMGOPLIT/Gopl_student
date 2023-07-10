import 'package:global_student/networking/apiProvider.dart';

import '../networking/NetworkConstant.dart';

class CourseRepo {
  final ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> getCountrySearchApi() async {
    final response = await _apiProvider
        .getAfterAuth(NetworkConstant.END_POINT_SEARCH_COUNTRY);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getUniversitySearchApi(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_SEARCH_UNIVERSITY);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getLocationSearchApi(
    Map<String, String> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_SEARCH_LOCATION);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getStudyAreaSearchApi() async {
    final response = await _apiProvider
        .getAfterAuth(NetworkConstant.END_POINT_SEARCH_STUDY_AREA);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  //Discipline Area

  Future<dynamic> getDisciplineAreaSearchApi(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_SEARCH_DISCIPLINE_AREA);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }
  //Filter Post

  Future<dynamic> postFilterSearchApi(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.postWithToken(
        parameter, NetworkConstant.END_POINT_SEARCH_FILTER_LIST);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getUniversityPagenation(
      Map<String, dynamic> parameter, int page, int limit) async {
    final response = await _apiProvider.getDropdownPagenation(
        parameter, NetworkConstant.END_POINT_SEARCH_UNIVERSITY, page, limit);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getSearchhomeApi() async {
    final response = await _apiProvider.get(
      NetworkConstant.END_POINT_DASH_SEARCH,
    );
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> getcourseDetails(
    Map<String, dynamic> parameter,
  ) async {
    final response = await _apiProvider.getDropdownParams(
        parameter, NetworkConstant.END_POINT_COURSE_DETAILS);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }
}
