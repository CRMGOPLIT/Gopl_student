import 'dart:async';

import 'package:global_student/repogetory/courseSearch.dart';

class SearchBloc {
  late CourseRepo courseRepo;
  late StreamController<dynamic> getcountrysearch;
  late StreamController<dynamic> getuniversitysearch;
  late StreamController<dynamic> getlocationsearch;
  late StreamController<dynamic> getstudyareasearch;
  late StreamController<dynamic> getdisciplineareasearch;

  late StreamController<dynamic> getfiltersearch;

  //late StreamController<Response<dynamic>> postRegistraion;

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

  StreamSink<dynamic> get getfiltersearchSink => getfiltersearch.sink;

  Stream<dynamic> get getfiltersearchStream => getfiltersearch.stream;

  // StreamSink<Response<dynamic>> get postRegistrationSink =>
  //     postRegistraion.sink;

  // Stream<Response<dynamic>> get postRegistrationStream =>
  //     postRegistraion.stream;

  SearchBloc() {
    getcountrysearch = StreamController<dynamic>();
    getuniversitysearch = StreamController<dynamic>();
    getlocationsearch = StreamController<dynamic>();
    getstudyareasearch = StreamController<dynamic>();
    getdisciplineareasearch = StreamController<dynamic>();
    getfiltersearch = StreamController<dynamic>();
    courseRepo = CourseRepo();
  }
//Get All drop Fields
  callGetCountrySearchApi() async {
    try {
      dynamic chuckCats = await courseRepo.getCountrySearchApi();
      getcountrysearchSink.add(chuckCats);
    } catch (e) {
      getcountrysearchSink.add('error');
      // print(e);
    }
  }

//University Search
  callGetUniversitySearchApi(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.getUniversitySearchApi(parameter);
      getuniversitysearchSink.add(chuckCats);
    } catch (e) {
      getuniversitysearchSink.add('error');
      // print(e);
    }
  }

  //Location Search
  callGetLocationSearchApi(Map<String, String> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.getLocationSearchApi(parameter);
      getlocationsearchSink.add(chuckCats);
    } catch (e) {
      getlocationsearchSink.add('error');
      // print(e);
    }
  }

//Study Area
  callGetStudyAreaSearchApi() async {
    try {
      dynamic chuckCats = await courseRepo.getStudyAreaSearchApi();
      getstudyareasearchSink.add(chuckCats);
    } catch (e) {
      getstudyareasearchSink.add('error');
      // print(e);
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
      // print(e);
    }
  }

//Filter Area Search
  callGetFilterSearch(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await courseRepo.postFilterSearchApi(parameter);
      getfiltersearchSink.add(chuckCats);
    } catch (e) {
      getfiltersearchSink.add('error');
      // print(e);
    }
  }

  dispose() {
    getcountrysearch.close();
    getuniversitysearch.close();
    getlocationsearch.close();
    getstudyareasearch.close();
    getdisciplineareasearch.close();
    getfiltersearch.close();
  }
}
