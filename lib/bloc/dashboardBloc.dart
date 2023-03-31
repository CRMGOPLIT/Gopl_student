import 'dart:async';
import 'package:global_student/repogetory/dashBoardGet.dart';

class DashBoardBloc {
  late DashBoardGet dashBoardGet;
  late StreamController<dynamic> streamController;
  late StreamController<dynamic> branchController;
  late StreamController<dynamic> batchController;
  late StreamController<dynamic> bannersController;
  late StreamController<dynamic> userController;
  late StreamController<dynamic> universityController;
  late StreamController<dynamic> applicationController;
  late StreamController<dynamic> qualificationController;

//Event Controller
  StreamSink<dynamic> get getEventDetailsSink => streamController.sink;

  Stream<dynamic> get getEventDetailsStream => streamController.stream;

  //University Event
  StreamSink<dynamic> get universityControllerSink => universityController.sink;

  Stream<dynamic> get universityControllerStream => universityController.stream;

//branch Controller
  StreamSink<dynamic> get branchControllerSink => branchController.sink;

  Stream<dynamic> get branchControllerStream => branchController.stream;

  //batch Controller
  StreamSink<dynamic> get batchControllerSink => batchController.sink;

  Stream<dynamic> get batchControllerStream => batchController.stream;

  // Banners Controllers
  StreamSink<dynamic> get bannersControllerSink => bannersController.sink;

  Stream<dynamic> get bannersControllerStream => bannersController.stream;

  //User Controller
  StreamSink<dynamic> get userControllerSink => userController.sink;

  Stream<dynamic> get userControllerStream => userController.stream;

  //Application Status

  StreamSink<dynamic> get applicationControllerSink =>
      applicationController.sink;

  Stream<dynamic> get applicationControllerStream =>
      applicationController.stream;

  //Qualification Controller
  StreamSink<dynamic> get qualificationControllerSink =>
      applicationController.sink;

  Stream<dynamic> get qualificationControllerStream =>
      applicationController.stream;

  DashBoardBloc() {
    streamController = StreamController<dynamic>();
    branchController = StreamController<dynamic>();
    batchController = StreamController<dynamic>();
    bannersController = StreamController<dynamic>();
    userController = StreamController<dynamic>();
    universityController = StreamController<dynamic>();
    applicationController = StreamController<dynamic>();
    qualificationController = StreamController<dynamic>();
    dashBoardGet = DashBoardGet();
  }
//Get All Events Detaails
  callGetEventDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getEventDetailsRepo();
      getEventDetailsSink.add(chuckCats);
    } catch (e) {
      getEventDetailsSink.add('error');
      // print(e);
    }
  }

  //Get All Events Detaails
  callGetUniversityDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getUniversityDetailsRepo();
      universityControllerSink.add(chuckCats);
    } catch (e) {
      universityControllerSink.add('error');
      // print(e);
    }
  }

//Get Branch Details

  callGetBranchDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBranchDetailsRepo();
      branchControllerSink.add(chuckCats);
    } catch (e) {
      branchControllerSink.add('error');
      // print(e);
    }
  }

  //Get Batch Details

  callGetBatchDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBatchDetailsRepo();
      batchControllerSink.add(chuckCats);
    } catch (e) {
      batchControllerSink.add('error');
      // print(e);
    }
  }

  //Banners Details
  callGetBannersDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBannersDetailsRepo();
      bannersControllerSink.add(chuckCats);
    } catch (e) {
      bannersControllerSink.add('error');
      // print(e);
    }
  }

//User Details
  callGetUsersDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getUsersDetailsRepo();
      userControllerSink.add(chuckCats);
    } catch (e) {
      userControllerSink.add('error');
      // print(e);
    }
  }

//User Details
  callApplicationstatusApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getApplicationStatusRepo();
      applicationControllerSink.add(chuckCats);
    } catch (e) {
      applicationControllerSink.add('error');
      // print(e);
    }
  }

  // Qualification dropdown

  callQualificationListApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getQualificationlistRepo();
      qualificationControllerSink.add(chuckCats);
    } catch (e) {
      qualificationControllerSink.add('error');
      // print(e);
    }
  }

  dispose() {
    streamController.close();
    branchController.close();
    batchController.close();
    bannersController.close();
    userController.close();
    applicationController.close();
    qualificationController.close();
  }
}
