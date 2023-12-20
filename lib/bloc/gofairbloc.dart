import 'dart:async';
import 'dart:io';
import 'package:global_student/repogetory/gofairrepo.dart';
import '../networking/response.dart';

class GoFairBloc {
  late GofairRepo gofairRepo;
  late StreamController<dynamic> gofairappointment;
  late StreamController<dynamic> gofairappointmentpending;
  late StreamController<dynamic> gofairdetails;
  late StreamController<Response<dynamic>> gofairdrop;
  late StreamController<Response<dynamic>> bookappointmentdata;
  late StreamController<Response<dynamic>> updatefairappointment;
  late StreamController<Response<dynamic>> uploadfairdocumentcontroller;

  late StreamController<Response<dynamic>> sendtokencontroller;
  late StreamController<dynamic> getfairdocumetlist;

  late StreamController<dynamic> versiondetails;

  StreamSink<dynamic> get gofairappointmentSink => gofairappointment.sink;
  Stream<dynamic> get gofairappointmentStream => gofairappointment.stream;

  StreamSink<dynamic> get gofairappointmentpendingSink =>
      gofairappointmentpending.sink;
  Stream<dynamic> get gofairappointmentpendingStream =>
      gofairappointmentpending.stream;

  StreamSink<dynamic> get gofairdetailsSink => gofairdetails.sink;
  Stream<dynamic> get gofairdetailsStream => gofairdetails.stream;

  StreamSink<Response<dynamic>> get gofairdropSink => gofairdrop.sink;
  Stream<Response<dynamic>> get gofairdropStream => gofairdrop.stream;

  StreamSink<Response<dynamic>> get bookappointmentdataSink =>
      bookappointmentdata.sink;
  Stream<Response<dynamic>> get bookappointmentdataStream =>
      bookappointmentdata.stream;

  StreamSink<Response<dynamic>> get updatefairappointmentSink =>
      updatefairappointment.sink;
  Stream<Response<dynamic>> get updatefairappointmentStream =>
      updatefairappointment.stream;

  StreamSink<Response<dynamic>> get uploadfairdocumentcontrollerSink =>
      uploadfairdocumentcontroller.sink;
  Stream<Response<dynamic>> get uploadfairdocumentcontrollerStream =>
      uploadfairdocumentcontroller.stream;

  StreamSink<dynamic> get getfairdocumetlistSink => getfairdocumetlist.sink;
  Stream<dynamic> get getfairdocumetlistStream => getfairdocumetlist.stream;

  StreamSink<Response<dynamic>> get sendtokencontrollerSink =>
      sendtokencontroller.sink;
  Stream<Response<dynamic>> get sendtokencontrollerStream =>
      sendtokencontroller.stream;

  StreamSink<dynamic> get versiondetailsSink => versiondetails.sink;
  Stream<dynamic> get versiondetailsStream => versiondetails.stream;

  GoFairBloc() {
    gofairappointment = StreamController<dynamic>();
    gofairappointmentpending = StreamController<dynamic>();
    gofairdetails = StreamController<dynamic>();
    gofairdrop = StreamController<Response<dynamic>>();
    bookappointmentdata = StreamController<Response<dynamic>>();
    updatefairappointment = StreamController<Response<dynamic>>();
    uploadfairdocumentcontroller = StreamController<Response<dynamic>>();
    sendtokencontroller = StreamController<Response<dynamic>>();
    getfairdocumetlist = StreamController<dynamic>();
    versiondetails = StreamController<dynamic>();
    gofairRepo = GofairRepo();
  }

  callAppointmentDetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.getappointmentdetails(parameter);
      gofairappointmentSink.add(chuckCats);
    } catch (e) {
      gofairappointmentSink.add('error');
    }
  }

  callAppointmentPendingDetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.getappointmentdetails(parameter);
      gofairappointmentpendingSink.add(chuckCats);
    } catch (e) {
      gofairappointmentpendingSink.add('error');
    }
  }

  callGofairdetailsDetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.getfairdetailsdetails(parameter);
      gofairdetailsSink.add(chuckCats);
    } catch (e) {
      gofairdetailsSink.add('error');
    }
  }

  //post
  callgofairdrop(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.gofairdrop(parameter);
      gofairdropSink.add(Response.completed(chuckCats));
    } catch (e) {
      gofairdropSink.add(Response.error(e.toString()));
    }
  }

  //post
  callbookappointmentdata(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.bookappointmentdata(parameter);
      bookappointmentdataSink.add(Response.completed(chuckCats));
    } catch (e) {
      bookappointmentdataSink.add(Response.error(e.toString()));
    }
  }

  //post
  callupdatefairappointment(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.updatefairappointment(parameter);
      updatefairappointmentSink.add(Response.completed(chuckCats));
    } catch (e) {
      updatefairappointmentSink.add(Response.error(e.toString()));
    }
  }

  // Upload fair document

  callUploadfairdocumentApi(
      Map<String, dynamic> parameter, List<File> files) async {
    try {
      dynamic chuckCats = await gofairRepo.postFairDocument(parameter, files);
      uploadfairdocumentcontrollerSink.add(Response.completed(chuckCats));
    } catch (e) {
      uploadfairdocumentcontrollerSink.add(Response.error(e.toString()));
    }
  }

  //course Applied Email
  callfairdocumentlist(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.fairdocumentget(parameter);
      getfairdocumetlistSink.add(chuckCats);
    } catch (e) {
      getfairdocumetlistSink.add('error');
    }
  }

  //Token send
  callSendToken(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await gofairRepo.sendToken(parameter);
      sendtokencontrollerSink.add(Response.completed(chuckCats));
    } catch (e) {
      sendtokencontrollerSink.add(Response.error(e.toString()));
    }
  }

  callversionDetailsApi() async {
    try {
      dynamic chuckCats = await gofairRepo.getVersionDetails();
      versiondetailsSink.add(chuckCats);
    } catch (e) {
      versiondetailsSink.add('error');
    }
  }

  dispose() {
    gofairappointment.close();
    gofairappointmentpending.close();
    gofairdetails.close();
    gofairdrop.close();
    bookappointmentdata.close();
    updatefairappointment.close();
    uploadfairdocumentcontroller.close();
    getfairdocumetlist.close();
    versiondetails.close();
  }
}
