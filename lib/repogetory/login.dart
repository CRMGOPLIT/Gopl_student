import 'package:global_student/networking/apiProvider.dart';
import '../networking/NetworkConstant.dart';

class LoginRepo {
  final ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> postLoginRepo(Map<String, String> parameter) async {
    final response = await _apiProvider.postlogin(
        parameter, NetworkConstant.END_POINT_POST_LOGIN);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }

  Future<dynamic> postOtpRepo(Map<String, String> parameter) async {
    final response = await _apiProvider.postlogin(
        parameter, NetworkConstant.END_POINT_POST_OTP);
    return response; //GetApplicationDetailsResponse.fromJson(response);
  }
}
