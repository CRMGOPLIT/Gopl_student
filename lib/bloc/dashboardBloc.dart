import 'dart:async';

import 'package:global_student/networking/response.dart';
import 'package:global_student/repogetory/dashBoardGet.dart';

import '../repogetory/registration.dart';

class DashBoardBloc {
  late DashBoardGet dashBoardGet;
  late StreamController<dynamic> streamController;
  late StreamController<dynamic> branchController;
  late StreamController<dynamic> batchController;
  late StreamController<dynamic> bannersController;

  StreamSink<dynamic> get getEventDetailsSink => streamController.sink;

  Stream<dynamic> get getEventDetailsStream => streamController.stream;

//branch Controller
  StreamSink<dynamic> get branchControllerSink => branchController.sink;

  Stream<dynamic> get branchControllerStream => branchController.stream;

  //batch Controller
  StreamSink<dynamic> get batchControllerSink => batchController.sink;

  Stream<dynamic> get batchControllerStream => batchController.stream;

  // Banners Controllers
  StreamSink<dynamic> get bannersControllerSink => bannersController.sink;

  Stream<dynamic> get bannersControllerStream => bannersController.stream;

  DashBoardBloc() {
    streamController = StreamController<dynamic>();
    branchController = StreamController<dynamic>();
    batchController = StreamController<dynamic>();
    bannersController = StreamController<dynamic>();

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

  dispose() {
    streamController.close();
    branchController.close();
    batchController.close();
    bannersController.close();
  }
}
