import 'dart:async';

import 'package:global_student/networking/response.dart';

import '../repogetory/registration.dart';

class HomeDataBloc {
  late Registrationget registrationget;
  late StreamController<dynamic> streamController;
  late StreamController<Response<dynamic>> postRegistraion;

  StreamSink<dynamic> get getRegistrationDetailsSink => streamController.sink;

  Stream<dynamic> get getRegistrationDetailsStream => streamController.stream;

  StreamSink<Response<dynamic>> get postRegistrationSink =>
      postRegistraion.sink;

  Stream<Response<dynamic>> get postRegistrationStream =>
      postRegistraion.stream;

  HomeDataBloc() {
    streamController = StreamController<dynamic>();
    postRegistraion = StreamController<Response<dynamic>>();
    registrationget = Registrationget();
  }
//Get All drop Fields
  callGetApplicationDetailsApi() async {
    try {
      dynamic chuckCats = await registrationget.getRegistraionDetailsApi();
      getRegistrationDetailsSink.add(chuckCats);
    } catch (e) {
      getRegistrationDetailsSink.add('error');
      // print(e);
    }
  }

//post Registration
  callPostRegistration(Map<String, String> parameter) async {
    try {
      dynamic chuckCats = await registrationget.postRegistration(parameter);
      postRegistrationSink.add(Response.completed(chuckCats));
    } catch (e) {
      postRegistrationSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    streamController.close();
  }
}
