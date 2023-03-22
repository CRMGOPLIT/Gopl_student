import 'package:flutter/material.dart';

class NetworkConstant {
  static const String DEFAULT_USER_IMAGE = "default image url here";

  static const String BASE_URL_SOCKET = "your url will be here";
  static const String BASE_URL = "http://crmapi.global-opportunities.co.in/Api";
  static const String BASE_URL_LOCAl =
      "http://crmdemoapi.global-opportunities.co.in/Api";
  static const String AFTER_AUTH = '/ias/ubi/v1/user/';

  //Dummy data
  static const String DUMMY_TOKEN =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhOWU2YmZkZC04MGI2LTQyZjctYWVlYy0zMzdmNTdmMmQwN2IiLCJpYXQiOjE2Njg3NjU1ODAsInRva2VuVHlwZSI6IlVTRVIiLCJleHAiOjE2NjkzNzAzODB9.aZa6w3WxTkLas00Vf0lzmjBkFXpmWyrz85eJEIg7zZHA1ojRZgrwR6PqWAUl-E40WPrlNeI1Ku11JZW-wLbV1A';
  static const String DUMMY_APPLICATION_ID = 'UBIM0000001101';

  static const String CASH_CREDIT = 'CASH_CREDIT';

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

  static const String END_POINT_GET_BRANCH = "/GopAndroid/GetBranchDeatis";

  static const String END_POINT_GET_BATCH = "/GopAndroid/ListBatches";

  static const String END_POINT_GET_BANNERS = "/Login/GetDashboardBanner";
}
