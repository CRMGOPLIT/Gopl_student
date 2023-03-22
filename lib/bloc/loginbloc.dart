import 'dart:async';

import 'package:global_student/networking/response.dart';
import 'package:global_student/repogetory/login.dart';

import '../repogetory/registration.dart';

class LoginDataBloc {
  late LoginRepo loginRepo;

  late StreamController<Response<dynamic>> postLogin;

  late StreamController<Response<dynamic>> postOtp;
//login
  StreamSink<Response<dynamic>> get postloginSink => postLogin.sink;

  Stream<Response<dynamic>> get postloginStream => postLogin.stream;

//otp
  StreamSink<Response<dynamic>> get postOtpSink => postOtp.sink;

  Stream<Response<dynamic>> get postOtpStream => postOtp.stream;

  LoginDataBloc() {
    postLogin = StreamController<Response<dynamic>>();
    postOtp = StreamController<Response<dynamic>>();
    loginRepo = LoginRepo();
  }

//post Login
  callPostLogin(Map<String, String> parameter) async {
    try {
      dynamic chuckCats = await loginRepo.postLoginRepo(parameter);
      postloginSink.add(Response.completed(chuckCats));
    } catch (e) {
      postloginSink.add(Response.error(e.toString()));
      print(e);
    }
  }
//post otp

  callPostOtp(Map<String, String> parameter) async {
    try {
      dynamic chuckCats = await loginRepo.postOtpRepo(parameter);
      postloginSink.add(Response.completed(chuckCats));
    } catch (e) {
      postloginSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    postLogin.close();
    postOtp.close();
  }
}