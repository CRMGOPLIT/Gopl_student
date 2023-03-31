import 'package:flutter/material.dart';

class NetworkConstant {
  static const String DEFAULT_USER_IMAGE = "default image url here";

  static const String BASE_URL_SOCKET = "your url will be here";
  static const String BASE_URL = "http://crmapi.global-opportunities.co.in/Api";
  static const String BASE_URL_LOCAl = "http://192.168.1.151:8080/Api";
  static const String AFTER_AUTH = '/ias/ubi/v1/user/';

  //post field Register
  static const String NAME = 'NAME';
  static const String EMAIL = 'Email';
  static const String MOBILE = 'mobile';
  static const String BRANCH = 'location';
  static const String INTAKE = 'intake';
  static const String COUNTRY = 'country_interested';
  //post Field Login
  static const String Mobile_Number = 'f_mobile';

  //post otp Field
  static const String OTP_CODE = 'mobileverified_code';

//Errors

  static const String SUCCESS_STATUS = 'SDF224';

//Registration Api

  static const String END_POINT_Get_REGISTRATIONDETAILS =
      '/GopAndroid/AndroidDDL';

  static const String END_POINT_POST_REGISTRATION = '/GopAndroid/InsertEnquiry';

  //Loginn APi
  static const String END_POINT_POST_LOGIN = '/Login/GetLogin';

  static const String END_POINT_POST_OTP = "/GopAndroid/GetOTPverified";

  static const String END_POINT_GET_EVENT = "/Event/getUpcomingEvents";

  static const String END_POINT_GET_UNIVERSITY =
      "/GopAndroid/UniversityAppList";

  static const String END_POINT_GET_BRANCH = "/GopAndroid/GetBranchDeatis";

  static const String END_POINT_GET_BATCH = "/GopAndroid/ListBatches";

  static const String END_POINT_GET_BANNERS = "/Login/GetDashboardBanner";

  static const String END_POINT_GET_USER = "/Login/GetTokenInfo";

  static const String END_POINT_APPLICATION_STATUS =
      "/Login/GetTokenApplication";

  static const String END_POINT_QUALIFICATION_LIST =
      "/Registeration/GetQualification";
}
