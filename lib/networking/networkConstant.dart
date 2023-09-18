class NetworkConstant {
  // ignore: constant_identifier_names
  static const String BASE_URL = "http://crmapi.global-opportunities.co.in/Api";


  

  //post field Register
  // ignore: constant_identifier_names
  static const String NAME = 'NAME';
  // ignore: constant_identifier_names
  static const String EMAIL = 'Email';
  // ignore: constant_identifier_names
  static const String MOBILE = 'mobile';
  // ignore: constant_identifier_names
  static const String BRANCH = 'location';
  // ignore: constant_identifier_names
  static const String INTAKE = 'intake';
  // ignore: constant_identifier_names
  static const String COUNTRY = 'country_interested';
  //post Field Login
  // ignore: constant_identifier_names
  static const String Mobile_Number = 'f_mobile';

  //post otp Field
  // ignore: constant_identifier_names
  static const String OTP_CODE = 'mobileverified_code';

  // post Upload Document
  static const String qualification = 'f_qualification';
  static const String stream = 'f_Stream';
  static const String uboard = 'f_university_board';
  static const String cstudied = 'f_courses_studied';
  static const String grade = 'f_avg_grade';
  static const String syear = 'f_starting_year';
  static const String smonth = 'starting_month';
  static const String pmonth = 'passing_month';
  static const String pyear = 'f_passing_year';
  static const String rdistance = 'f_Regular_Distance';
  static const String dtype = 'f_DocumentType';
  static const String image = 'image';

  //Filter Search

  static const String filterType = 'FilterType';
  static const String pageNumber = 'PageNumber';
  static const String sortBy = 'SortBy';
  static const String courseName = 'CourseName';
  static const String year = 'Year';
  static const String intake = 'Intake';
  static const String countryId = 'CountryId';
  static const String scholarship = 'Scholarship';
  static const String studyArea = 'StudyArea';

  static const String disciplineArea = 'DisciplineArea';
  static const String flocation = 'f_Location';
  static const String duration = 'Duration';
  static const String isIELTS = 'Is_IELTS';
  static const String istOEFL = 'Is_TOEFL';
  static const String placement = 'Placement';
  //
  static const String ispte = 'Is_PTE';
  static const String issat = 'Is_SAT';
  static const String isACT = 'Is_ACT';
  static const String isGRE = 'Is_GRE';
  static const String isGMAT = 'Is_GMAT';
  static const String deadlineAvailable = 'DeadlineAvailable';
  static const String fifteenYearsOfEd = 'FifteenYearsOfEd';
  static const String eslElp = 'EslElp';
  static const String conditionalOffer = 'ConditionalOffer';
  static const String programLevel = 'ProgramLevel';
  static const String universityId = 'UniversityId';
  static const String fRequest = 'f_Request';
  static const String crmAccessRequest = 'Crm_AccessRequest';

  //flag
  static const String documenttpye = '10th Marksheet';
  static const String documenttpye12 = '12th Marksheet';
  static const String bachelor = 'Bachelor Degree';

//upload more Document

  static const String studentid = "studentid";
  static const String documentname = "documentname";
  // ignore: constant_identifier_names
  static const String Applicationid = "Applicationid";
  // ignore: constant_identifier_names
  static const String Universityid = "Universityid";
  static const String appstage = "appstage";

//Registration Api
  // ignore: constant_identifier_names
  static const String END_POINT_Get_REGISTRATIONDETAILS =
      '/GopAndroid/AndroidDDL';
  // ignore: constant_identifier_names
  static const String END_POINT_POST_REGISTRATION = '/GopAndroid/InsertEnquiry';

  //Loginn APi
  // ignore: constant_identifier_names
  static const String END_POINT_POST_LOGIN = '/Login/GetLogin';
  // ignore: constant_identifier_names
  static const String END_POINT_POST_OTP = "/GopAndroid/GetOTPverified";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_EVENT = "/Event/getUpcomingEvents";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_UNIVERSITY =
      "/GopAndroid/UniversityAppList";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_BRANCH = "/GopAndroid/GetBranchDeatis";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_BATCH = "/GopAndroid/ListBatches";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_BANNERS = "/Login/GetDashboardBanner";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_USER = "/Login/GetTokenInfo";
  // ignore: constant_identifier_names
  static const String END_POINT_APPLICATION_STATUS =
      "/Login/GetTokenApplication";
  // ignore: constant_identifier_names
  static const String END_POINT_QUALIFICATION_LIST =
      "/Registeration/GetQualification";
  // ignore: constant_identifier_names
  static const String END_POINT_POST_DOCUMENT =
      "/Login/TokenQuallificationInfo";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_BOARD =
      "/Registeration/Getuniversity_board";
  // ignore: constant_identifier_names
  static const String END_POINT_MORE_GET_DOCUMENT =
      "/Login/Getstudent_DocDetails";
  // ignore: constant_identifier_names
  static const String END_POINT_GET_QUALIFICATION =
      "/Login/GetstudentQuallification";

  //course Search
  // ignore: constant_identifier_names
  static const String END_POINT_SEARCH_COUNTRY =
      "/SearchCourseMaster/GetCountry";
  // ignore: constant_identifier_names
  static const String END_POINT_SEARCH_UNIVERSITY =
      "/SearchCourseMaster/CountryWiseUniversityList";
  // ignore: constant_identifier_names
  static const String END_POINT_SEARCH_LOCATION =
      "/SearchCourseMaster/GetForeignLocationList";
  // ignore: constant_identifier_names
  static const String END_POINT_SEARCH_STUDY_AREA =
      "/SearchCourseMaster/GetAllStudyList";
  // ignore: constant_identifier_names
  static const String END_POINT_SEARCH_DISCIPLINE_AREA =
      "/SearchCourseMaster/GetDisciplineAreaList";

  // ignore: constant_identifier_names
  static const String END_POINT_SEARCH_FILTER_LIST =
      "/gopandroid/AndroidCourseSearchList";

  // ignore: constant_identifier_names
  static const String END_POINT_DASH_SEARCH =
      "/gopandroid/CourseRelatedDetails";

  // ignore: constant_identifier_names
  static const String END_POINT_COURSE_DETAILS =
      "/SearchCourseMaster/GetSearchCourseDetails";

  //uploadmore Document
  // ignore: constant_identifier_names
  static const String END_POINT_UPLOAD_MORE_DOCUMENT =
      "/DocumentUpload/UploadMoreDocmentbyApp";

  //visa get details
  // ignore: constant_identifier_names
  static const String END_POINT_VISA_GET =
      "/GopAndroid/AndroidVisaFileRequiredDocuments";
//Visa Upload
  // ignore: constant_identifier_names
  static const String END_POINT_UPLOAD_VISA =
      "/DocumentUpload/studentVisaApplied";

//final submit
  // ignore: constant_identifier_names
  static const String END_POINT_FINAL_VISA_SUBMIT =
      "/DocumentUpload/VisaSubmit";

  // ignore: constant_identifier_names
  static const String END_POINT_COURSE_APPLIED_EMAIL =
      "/DocumentUpload/AppStudent_SendCourse";
}
