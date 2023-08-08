import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:global_student/networking/customException.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes/customerror.dart';
import 'NetworkConstant.dart';
import 'package:path/path.dart';

class ApiProvider {
  final String baseUrl = NetworkConstant.BASE_URL;
  final String beforeAuth = "";
  final String baseUrllocal = NetworkConstant.BASE_URL_LOCAl;

  String? token;
  var responseJson;
  Future<dynamic> get(
    String url,
  ) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrllocal + url),
      );

      responseJson = _response(response);
    } catch (error) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> getAfterAuth(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('stringValue');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrllocal + url),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept": "application/json"
        },
      );

      responseJson = _response(response);
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> getAfterAuthlocal(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('stringValue');
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrllocal + url),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept": "application/json"
        },
      );

      responseJson = _response(response);
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> postBeforeAuth(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(
          Uri.parse(baseUrllocal + beforeAuth + url),
          headers: {"Accept": "application/json"},
          body: parameter);

      responseJson = _response(response);
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> postlogin(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrllocal + url),
          headers: {"Accept": "application/json"}, body: parameter);

      responseJson = _response(response);
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> postWithToken(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrllocal + url),
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json"
          },
          body: parameter);

      responseJson = _response(response);
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> getLocal(String url) async {
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');
    try {
      final response = await http.get(
        Uri.parse(baseUrllocal + url),
      );

      responseJson = _response(response);
    } on SocketException {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuth(Map parameter, String url, File files) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');

    var responseJson;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };

    try {
      final response =
          http.MultipartRequest("POST", Uri.parse(baseUrllocal + url));
      response.headers.addAll(headers);
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }

      final file = await http.MultipartFile.fromPath(
        'file',
        files.path,
      );
      response.files.add(file);

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          if (response.body.isNotEmpty) {
            responseJson = json.decode(response.body);
          }
        });
      });
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

//Email post

  Future<dynamic> courseEmailPost(
      Map<String, dynamic> parameter, String url) async {
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');

    try {
      final response = await http.post(
        Uri.parse(baseUrllocal + url).replace(queryParameters: parameter),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      responseJson = jsonDecode(response.body.toString());
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

/////////////drop params///////
  ///
  Future<dynamic> getDropdownParams(
      Map<String, dynamic> parameter, String url) async {
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');

    try {
      final response = await http.get(
        Uri.parse(baseUrllocal + url).replace(queryParameters: parameter),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      responseJson = jsonDecode(response.body.toString());
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> postAfterAuthWithMultipart(
      Map<String, dynamic> parameter, String url, List<File> files) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');

    var responseJson;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      "Accept": "application/json"
    };

    try {
      final response =
          http.MultipartRequest("POST", Uri.parse(baseUrllocal + url));
      response.headers.addAll(headers);
      for (var i = 0; i < parameter.length; i++) {
        response.fields[parameter.keys.elementAt(i)] =
            parameter.values.elementAt(i);
      }

      await Future.forEach(
        files,
        (File file) async => {
          response.files.add(
            http.MultipartFile(
              'file',
              (http.ByteStream(file.openRead())).cast(),
              await file.length(),
              filename: basename(file.path),
            ),
          )
        },
      );

      await response.send().then((value) async {
        await http.Response.fromStream(value).then((response) {
          if (response.body.isNotEmpty) {
            responseJson = json.decode(response.body);
          }
        });
      });
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }

  Future<dynamic> getDropdownPagenation(
      parameter, String url, int _page, int _limit) async {
    var responseJson;

    try {
      final response = await http.get(
        Uri.parse("$baseUrllocal$url?_page=$_page&_limit=$_limit")
            .replace(queryParameters: parameter),
        headers: {
          "Content-Type": "application/json",
        },
      );
      responseJson = jsonDecode(response.body.toString());
    } catch (e) {
      Get.to(const CustomErrorWidget());
    }
    return responseJson;
  }
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());

      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw BadRequestException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

dynamic _responseFromStream(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
