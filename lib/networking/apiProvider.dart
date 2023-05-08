import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:global_student/networking/customException.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'NetworkConstant.dart';
import 'package:path/path.dart';

class ApiProvider {
  final String baseUrl = NetworkConstant.BASE_URL;
  final String beforeAuth = "";
  final String afterAuth = NetworkConstant.AFTER_AUTH;
  final String baseUrllocal = NetworkConstant.BASE_URL_LOCAl;

  String? token;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
      );

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getAfterAuth(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');

    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept": "application/json"
        },
      );

      responseJson = _response(response);
    } catch (e) {
      throw FetchDataException('No Internet connection');
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
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postBeforeAuth(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + beforeAuth + url),
          headers: {"Accept": "application/json"}, body: parameter);

      responseJson = _response(response);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postlogin(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + url),
          headers: {"Accept": "application/json"}, body: parameter);

      responseJson = _response(response);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithToken(Map parameter, String url) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + url),
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json"
          },
          body: parameter);

      responseJson = _response(response);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getLocal(String url) async {
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('stringValue');
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
      );

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
      final response = http.MultipartRequest("POST", Uri.parse(baseUrl + url));
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
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

/////////////drop params///////
  ///
  Future<dynamic> getDropdownParams(parameter, String url) async {
    var responseJson;

    try {
      final response = await http.get(
        Uri.parse(baseUrl + url).replace(queryParameters: parameter),
        headers: {
          "Content-Type": "application/json",
        },
      );

      responseJson = jsonDecode(response.body.toString());
    } catch (e) {}
    return responseJson;
  }

  Future<dynamic> postAfterAuthWithMultipart(
      Map parameter, String url, List<File> files) async {
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
        http.Response.fromStream(value).then((response) {
          if (response.statusCode == 200) {
            if (response.body.isNotEmpty) {
              json.decode(response.body);
            }
          }
        });
      });
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}

// Future<dynamic> postAfterAuth(Map parameter, String url) async {
//   var responseJson;

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //Return String
//   token = prefs.getString('stringValue');

//   try {
//     Map<String, String> headers = {
//       'Authorization': 'Bearer $token',
//       // "Accept": "application/json"
//       //'Content-Type': 'application/json'
//       "Accept": "application/json",
//     };
//     final response = await http.post(Uri.parse(baseUrllocal + url),
//         headers: headers, body: parameter);

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body.toString());
//     }
//     // debugger();
//     // print(response.body);

//     responseJson = _response(response);
//   } catch (e) {
//     // debugger();
//     print(e);

//     //   throw FetchDataException('No Internet connection');
//   }
//   return responseJson;
// }

// Future<dynamic> postAfterAuthWithMultipart(Map parameter, String url, List<File>files) async {
//     var responseJson;
//     SharedPref box = new SharedPref();
//     String? token = await box.getToken();

//     try {
//       final response = await http.post(Uri.parse(baseUrl +afterAuth+ url),
//           headers: {
//             'authorization': 'Bearer ' + token,
//             'Content-type':'application/json'

//           },
//           body: parameter);

//       responseJson = _response(response);
//     } catch(e) {
//       debugger();
//       print(e);

//       throw FetchDataException('No Internet connection');
//     }
//     return responseJson;
//   }

// Future<dynamic> postAfterAuthMultipart(
//     Map parameter, String url, File files) async {
//   SharedPref box = new SharedPref();
//   String token = await box.getToken();
//   // debugger();
//   // print(files);
//   var responseJson;
//   Map<String, String> headers = {
//     "authorization": "Bearer " + token,
//     "Accept": "application/json"
//   };

//   try {
//     final response =
//         http.MultipartRequest("POST", Uri.parse(baseUrl + afterAuth + url));
//     response.headers.addAll(headers);
//     for (var i = 0; i < parameter.length; i++) {
//       response.fields[parameter.keys.elementAt(i)] =
//           parameter.values.elementAt(i);
//     }

//     response.files.add(
//       http.MultipartFile(
//         'file',
//         (http.ByteStream(files.openRead())).cast(),
//         await files.length(),
//         filename: basename(files.path),
//       ),
//     );

//     await response.send().then((value) async {
//       await http.Response.fromStream(value).then((response) {
//         responseJson = _response(response);
//       });
//     });
//   } catch (e) {
//     debugger();
//     print(e);
//     throw FetchDataException('No Internet connection');
//   }
//   return responseJson;
// }

// Future<dynamic> postAfterAuthMultipartForUploadBusinessPhoto(
//     Map parameter, String url, File files) async {
//   SharedPref box = new SharedPref();
//   String token = await box.getToken();
//   // debugger();
//   // print(files);
//   var responseJson;
//   Map<String, String> headers = {
//     "authorization": "Bearer " + token,
//     "Accept": "application/json"
//   };

//   try {
//     final response =
//         http.MultipartRequest("POST", Uri.parse(baseUrl + afterAuth + url));
//     response.headers.addAll(headers);
//     for (var i = 0; i < parameter.length; i++) {
//       response.fields[parameter.keys.elementAt(i)] =
//           parameter.values.elementAt(i);
//     }

//     response.files.add(
//       http.MultipartFile(
//         NetworkConstant.BUSINESS_PHOTO,
//         (http.ByteStream(files.openRead())).cast(),
//         await files.length(),
//         filename: basename(files.path),
//       ),
//     );

//     await response.send().then((value) async {
//       await http.Response.fromStream(value).then((response) {
//         responseJson = _response(response);
//       });
//     });
//   } catch (e) {
//     debugger();
//     print(e);
//     throw FetchDataException('No Internet connection');
//   }
//   return responseJson;
// }

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
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

dynamic _responseFromStream(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
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
