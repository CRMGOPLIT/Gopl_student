import 'package:global_student/networking/apiProvider.dart';
import '../networking/NetworkConstant.dart';

class Registrationget {
  final ApiProvider _apiProvider = ApiProvider();

  Future<dynamic> getRegistraionDetailsApi() async {
    final response = await _apiProvider
        .get(NetworkConstant.END_POINT_Get_REGISTRATIONDETAILS);

    return response;
  }

  Future<dynamic> postRegistration(Map<String, String> parameter) async {
    final response = await _apiProvider.postBeforeAuth(
        parameter, NetworkConstant.END_POINT_POST_REGISTRATION);
    return response;
  }
}
