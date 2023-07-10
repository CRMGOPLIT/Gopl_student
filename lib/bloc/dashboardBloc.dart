
import 'dart:async';
import 'dart:io';
import 'package:global_student/repogetory/dashBoardGet.dart';
import '../networking/response.dart';

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
  late StreamController<Response<dynamic>> documentuploadController;
  late StreamController<dynamic> boarduniversityController;
  late StreamController<dynamic> getmoredocumentcontroller;
  late StreamController<Response<dynamic>> uploadmoredocumentcontroller;

  late StreamController<dynamic> getqualificationcontroller;

  late StreamController<dynamic> getvisadetailscontroller;

  late StreamController<Response<dynamic>> uploadviscontroller;

  late StreamController<Response<dynamic>> finalvisasubmitcontroller;

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

  //Board Document
  StreamSink<dynamic> get boarduniversityControllerSink =>
      boarduniversityController.sink;

  Stream<dynamic> get boarduniversityControllerStream =>
      boarduniversityController.stream;

  //Upload Document
  StreamSink<Response<dynamic>> get documentuploadControllerSink =>
      documentuploadController.sink;

  Stream<Response<dynamic>> get documentuploadControllerStream =>
      documentuploadController.stream;
  //upload more document

  StreamSink<dynamic> get getmoredocumentcontrollerSink =>
      getmoredocumentcontroller.sink;

  Stream<dynamic> get getmoredocumentcontrollerStream =>
      getmoredocumentcontroller.stream;

  //Get Qualification

  StreamSink<dynamic> get getqualificationcontrollerSink =>
      getqualificationcontroller.sink;

  Stream<dynamic> get getqualificationcontrollerStream =>
      getqualificationcontroller.stream;
  //Upload more Document

  StreamSink<Response<dynamic>> get uploadmoredocumentcontrollerSink =>
      uploadmoredocumentcontroller.sink;

  Stream<Response<dynamic>> get uploadmoredocumentcontrollerStream =>
      uploadmoredocumentcontroller.stream;

  //

  StreamSink<dynamic> get getvisadetailscontrollerSink =>
      getvisadetailscontroller.sink;

  Stream<dynamic> get getvisadetailscontrollerStream =>
      getvisadetailscontroller.stream;

  //Uploadvisa
  StreamSink<Response<dynamic>> get uploadviscontrollerSink =>
      uploadviscontroller.sink;

  Stream<Response<dynamic>> get uploadviscontrollerStream =>
      uploadviscontroller.stream;

//final visa submit
  StreamSink<Response<dynamic>> get finalvisasubmitcontrollerSink =>
      finalvisasubmitcontroller.sink;

  Stream<Response<dynamic>> get finalvisasubmitcontrollerStream =>
      finalvisasubmitcontroller.stream;

  DashBoardBloc() {
    streamController = StreamController<dynamic>();
    branchController = StreamController<dynamic>();
    batchController = StreamController<dynamic>();
    bannersController = StreamController<dynamic>();
    userController = StreamController<dynamic>();
    universityController = StreamController<dynamic>();
    applicationController = StreamController<dynamic>();
    qualificationController = StreamController<dynamic>();
    documentuploadController = StreamController<Response<dynamic>>();
    boarduniversityController = StreamController<dynamic>();
    getmoredocumentcontroller = StreamController<dynamic>();
    getqualificationcontroller = StreamController<dynamic>();
    uploadmoredocumentcontroller = StreamController<Response<dynamic>>();
    getvisadetailscontroller = StreamController<dynamic>();
    uploadviscontroller = StreamController<Response<dynamic>>();
    finalvisasubmitcontroller = StreamController<Response<dynamic>>();
    dashBoardGet = DashBoardGet();
  }
//Get All Events Detaails
  callGetEventDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getEventDetailsRepo();
      getEventDetailsSink.add(chuckCats);
    } catch (e) {
      getEventDetailsSink.add('error');
    }
  }

  //Get All Events Detaails
  callGetUniversityDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getUniversityDetailsRepo();
      universityControllerSink.add(chuckCats);
    } catch (e) {
      universityControllerSink.add('error');
    }
  }

//Get Branch Details

  callGetBranchDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBranchDetailsRepo();
      branchControllerSink.add(chuckCats);
    } catch (e) {
      branchControllerSink.add('error');
    }
  }

  //Get Batch Details

  callGetBatchDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBatchDetailsRepo();
      batchControllerSink.add(chuckCats);
    } catch (e) {
      batchControllerSink.add('error');
    }
  }

  //Banners Details
  callGetBannersDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBannersDetailsRepo();
      bannersControllerSink.add(chuckCats);
    } catch (e) {
      bannersControllerSink.add('error');
    }
  }

//User Details
  callGetUsersDetailsApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getUsersDetailsRepo();
      userControllerSink.add(chuckCats);
    } catch (e) {
      userControllerSink.add('error');
    }
  }

//Get Application Status
  callApplicationstatusApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getApplicationStatusRepo();
      applicationControllerSink.add(chuckCats);
    } catch (e) {
      applicationControllerSink.add('error');
    }
  }

  // Qualification dropdown

  callQualificationListApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getQualificationlistRepo();
      qualificationControllerSink.add(chuckCats);
    } catch (e) {
      qualificationControllerSink.add('error');
    }
  }
  // Board University dropdown

  callBoardListApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getBoardlistRepo();
      boarduniversityControllerSink.add(chuckCats);
    } catch (e) {
      boarduniversityControllerSink.add('error');
    }
  }

  //Document Upload

  callUploadDocumentApi(Map parameter, File files) async {
    try {
      dynamic chuckCats = await dashBoardGet.postDocument(parameter, files);
      documentuploadControllerSink.add(Response.completed(chuckCats));
    } catch (e) {
      documentuploadControllerSink.add(Response.error(e.toString()));
    }
  }

  //Get upload more Document
  callUploadmoreDocumentApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getuploadmoredocument();
      getmoredocumentcontrollerSink.add(chuckCats);
    } catch (e) {
      getmoredocumentcontrollerSink.add('error');
    }
  }
// Get Qualification

  callQualificationApi() async {
    try {
      dynamic chuckCats = await dashBoardGet.getQualificationRepo();
      getqualificationcontrollerSink.add(chuckCats);
    } catch (e) {
      getqualificationcontrollerSink.add('error');
    }
  }

  // Upload More Document

  callUploadmoredocumentApi(
      Map<String, dynamic> parameter, List<File> files) async {
    try {
      dynamic chuckCats = await dashBoardGet.postMoreDocument(parameter, files);
      uploadmoredocumentcontrollerSink.add(Response.completed(chuckCats));
    } catch (e) {
      uploadmoredocumentcontrollerSink.add(Response.error(e.toString()));
    }
  }

//visa get
  callGetvisadetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await dashBoardGet.getvisadeatails(parameter);
      getvisadetailscontrollerSink.add(chuckCats);
    } catch (e) {
      getvisadetailscontrollerSink.add(e.toString());
    }
  }

//Visa Upload

  visaUploadApi(Map parameter, File files) async {
    try {
      dynamic chuckCats =
          await dashBoardGet.UploadVisaDocument(parameter, files);
      uploadviscontrollerSink.add(Response.completed(chuckCats));
    } catch (e) {
      uploadviscontrollerSink.add(Response.error(e.toString()));
    }
  }

//final submit visa
  callFianlvisasubmit(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await dashBoardGet.finalvisasubmit(parameter);
      finalvisasubmitcontrollerSink.add(Response.completed(chuckCats));
    } catch (e) {
      finalvisasubmitcontrollerSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    streamController.close();
    branchController.close();
    batchController.close();
    bannersController.close();
    userController.close();
    universityController.close();
    applicationController.close();

    boarduniversityController.close();
    qualificationController.close();
    documentuploadController.close();
    getmoredocumentcontroller.close();
    uploadmoredocumentcontroller.close();
    getvisadetailscontroller.close();
    uploadviscontroller.close();
    finalvisasubmitcontroller.close();
  }
}
