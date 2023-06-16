import 'dart:async';

import 'package:global_student/networking/response.dart';
import 'package:global_student/repogetory/courseSearch.dart';

class SearchBloc {
  late CourseRepo courseRepo;
  late StreamController<dynamic> getcountrysearch;
  late StreamController<dynamic> getuniversitysearch;
  late StreamController<dynamic> getlocationsearch;
  late StreamController<dynamic> getstudyareasearch;
  late StreamController<dynamic> getdisciplineareasearch;
  late StreamController<dynamic> getuniversitypagenation;
  late StreamController<dynamic> getdashboardsearch;
  late StreamController<dynamic> coursemoredetails;
  late StreamController<Response<dynamic>> getfiltersearch;

  StreamSink<dynamic> get getcountrysearchSink => getcountrysearch.sink;

  Stream<dynamic> get getcountrysearchStream => getcountrysearch.stream;

  //university
  StreamSink<dynamic> get getuniversitysearchSink => getuniversitysearch.sink;

  Stream<dynamic> get getuniversitysearchStream => getuniversitysearch.stream;
  //Location

  StreamSink<dynamic> get getlocationsearchSink => getlocationsearch.sink;

  Stream<dynamic> get getlocationsearchStream => getlocationsearch.stream;
  //Study Area

  StreamSink<dynamic> get getstudyareasearchSink => getstudyareasearch.sink;

  Stream<dynamic> get getstudyareasearchStream => getstudyareasearch.stream;

  //Discipline Area

  StreamSink<dynamic> get getdisciplineareasearchSink =>
      getdisciplineareasearch.sink;

  Stream<dynamic> get getdisciplineareasearchStream =>
      getdisciplineareasearch.stream;

  //Discipline Area
  StreamSink<Response<dynamic>> get getfiltersearchSink => getfiltersearch.sink;

  Stream<Response<dynamic>> get getfiltersearchStream => getfiltersearch.stream;

//Pagenation

  StreamSink<dynamic> get getuniversitypagenationSink =>
      getuniversitypagenation.sink;

  Stream<dynamic> get getuniversitypagenationStream =>
      getuniversitypagenation.stream;

  StreamSink<dynamic> get getdashboardsearchSink => getdashboardsearch.sink;

  Stream<dynamic> get getdashboardsearchStream => getdashboardsearch.stream;

  StreamSink<dynamic> get coursemoredetailsSink => coursemoredetails.sink;

  Stream<dynamic> get coursemoredetailsStream => coursemoredetails.stream;

  SearchBloc() {
    getcountrysearch = StreamController<dynamic>();
    getuniversitysearch = StreamController<dynamic>();
    getlocationsearch = StreamController<dynamic>();
    getstudyareasearch = StreamController<dynamic>();
    getdisciplineareasearch = StreamController<dynamic>();
    getfiltersearch = StreamController<Response<dynamic>>();
    getuniversitypagenation = StreamController<dynamic>();
    getdashboardsearch = StreamController<dynamic>();
    coursemoredetails = StreamController<dynamic>();
    courseRepo = CourseRepo();
  }

//Get All drop Fields
  callGetCountrySearchApi() async {
    try {
      dynamic chuckCats = await courseRepo.getCountrySearchApi();
      getcountrysearchSink.add(chuckCats);
    } catch (e) {
      getcountrysearchSink.add('error');
    }
  }

//University Search
  callGetUniversitySearchApi(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.getUniversitySearchApi(parameter);
      getuniversitysearchSink.add(chuckCats);
    } catch (e) {
      getuniversitysearchSink.add('error');
    }
  }

  //Location Search
  callGetLocationSearchApi(Map<String, String> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.getLocationSearchApi(parameter);
      getlocationsearchSink.add(chuckCats);
    } catch (e) {
      getlocationsearchSink.add('error');
    }
  }

//Study Area
  callGetStudyAreaSearchApi() async {
    try {
      dynamic chuckCats = await courseRepo.getStudyAreaSearchApi();
      getstudyareasearchSink.add(chuckCats);
    } catch (e) {
      getstudyareasearchSink.add('error');
    }
  }

  //Discipline Area Search
  callGetDisciplineSearchApi(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats =
          await courseRepo.getDisciplineAreaSearchApi(parameter);
      getdisciplineareasearchSink.add(chuckCats);
    } catch (e) {
      getdisciplineareasearchSink.add('error');
    }
  }

//Filter Area Search
  callGetFilterSearch(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.postFilterSearchApi(parameter);
      getfiltersearchSink.add(Response.completed(chuckCats));
    } catch (e) {
      getfiltersearchSink.add(Response.error(e.toString()));
    }
  }

  callGetUniversitySearchApiPagenation(
      Map<String, dynamic> parameter, int page, int limit) async {
    try {
      dynamic chuckCats =
          await courseRepo.getUniversityPagenation(parameter, page, limit);
      getuniversitypagenationSink.add(chuckCats);
    } catch (e) {
      getuniversitypagenationSink.add('error');
    }
  }

  callSearchDashSearchApi() async {
    try {
      dynamic chuckCats = await courseRepo.getSearchhomeApi();
      getdashboardsearch.add(chuckCats);
    } catch (e) {
      getdashboardsearch.add('error');
    }
  }

  callGetCourseDetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.getcourseDetails(parameter);
      coursemoredetailsSink.add(chuckCats);
    } catch (e) {
      coursemoredetailsSink.add('error');
    }
  }

  void dispose() {
    getcountrysearch.close();
    getuniversitysearch.close();
    getlocationsearch.close();
    getstudyareasearch.close();
    getdisciplineareasearch.close();
    getfiltersearch.close();
    getuniversitypagenation.close();
    getdashboardsearch.close();
    coursemoredetails.close();
  }
}
