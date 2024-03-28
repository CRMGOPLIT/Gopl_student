import 'dart:async';
import '../networking/response.dart';
import '../repogetory/BatchPayment.dart';

class BatchperformaBloc {
  late BatchpaymentRepo batchpaymentRepo;

  late StreamController<dynamic> batchpaymentperforma;
  late StreamController<dynamic> batchpaymentrecipt;
  late StreamController<dynamic> getperformacreate;
  late StreamController<Response<dynamic>> createorderbatch;
  late StreamController<Response<dynamic>> veryfypayment;

  late StreamController<Response<dynamic>> applybatchemail;

  StreamSink<dynamic> get batchpaymentperformaSink => batchpaymentperforma.sink;
  Stream<dynamic> get batchpaymentperformaStream => batchpaymentperforma.stream;

  StreamSink<dynamic> get batchpaymentreciptSink => batchpaymentrecipt.sink;
  Stream<dynamic> get batchpaymentreciptStream => batchpaymentrecipt.stream;

  StreamSink<dynamic> get getperformacreateSink => getperformacreate.sink;
  Stream<dynamic> get getperformacreateStream => getperformacreate.stream;

  // courseApplied Email
  StreamSink<Response<dynamic>> get createorderbatchSink =>
      createorderbatch.sink;
  Stream<Response<dynamic>> get createorderbatchStream =>
      createorderbatch.stream;

  StreamSink<Response<dynamic>> get veryfypaymentSink => veryfypayment.sink;

  Stream<Response<dynamic>> get veryfypaymentStream => veryfypayment.stream;

  // courseApplied Email
  StreamSink<Response<dynamic>> get applybatchemailSink => applybatchemail.sink;
  Stream<Response<dynamic>> get applybatchemailStream => applybatchemail.stream;
  BatchperformaBloc() {
    batchpaymentRepo = BatchpaymentRepo();

    batchpaymentperforma = StreamController<dynamic>();
    batchpaymentrecipt = StreamController<dynamic>();
    getperformacreate = StreamController<dynamic>();
    createorderbatch = StreamController<Response<dynamic>>();
    veryfypayment = StreamController<Response<dynamic>>();

    applybatchemail = StreamController<Response<dynamic>>();
  }

  callhistoryDetails() async {
    try {
      dynamic chuckCats = await batchpaymentRepo.gethisroryDetailsRepo();
      batchpaymentperformaSink.add(chuckCats);
    } catch (e) {
      batchpaymentperformaSink.add('error');
    }
  }

  callreciptdetailsDetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await batchpaymentRepo.batchreciptdetails(parameter);
      batchpaymentreciptSink.add(chuckCats);
    } catch (e) {
      batchpaymentreciptSink.add('error');
    }
  }

//User Details
  callPerformaCreateApi() async {
    try {
      dynamic chuckCats = await batchpaymentRepo.getPerformaCreateDetailsRepo();
      getperformacreateSink.add(chuckCats);
    } catch (e) {
      getperformacreateSink.add('error');
    }
  }

  //course Applied Email
  callCreateOrder(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await batchpaymentRepo.createOrderBatch(parameter);
      createorderbatchSink.add(Response.completed(chuckCats));
    } catch (e) {
      createorderbatchSink.add(Response.error(e.toString()));
    }
  }

//post Registration
  callVeryfiPayment(Map<String, String> parameter) async {
    try {
      dynamic chuckCats = await batchpaymentRepo.veryfyPayment(parameter);
      veryfypaymentSink.add(Response.completed(chuckCats));
    } catch (e) {
      veryfypaymentSink.add(Response.error(e.toString()));
    }
  }

  //course Applied Email
  callbatchapplyemail(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats = await batchpaymentRepo.applyBatch(parameter);
      applybatchemailSink.add(Response.completed(chuckCats));
    } catch (e) {
      applybatchemailSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    batchpaymentperforma.close();
    batchpaymentrecipt.close();
    getperformacreate.close();
    createorderbatch.close();
    veryfypayment.close();
    applybatchemail.close();
  }
}
