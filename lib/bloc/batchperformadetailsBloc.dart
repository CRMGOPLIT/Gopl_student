import 'dart:async';
import '../repogetory/BatchPayment.dart';

class BatchperformaBloc {
  late BatchpaymentRepo batchpaymentRepo;

  late StreamController<dynamic> batchpaymentperforma;
  late StreamController<dynamic> batchpaymentrecipt;

  StreamSink<dynamic> get batchpaymentperformaSink => batchpaymentperforma.sink;
  Stream<dynamic> get batchpaymentperformaStream => batchpaymentperforma.stream;

  StreamSink<dynamic> get batchpaymentreciptSink => batchpaymentrecipt.sink;
  Stream<dynamic> get batchpaymentreciptStream => batchpaymentrecipt.stream;

  BatchperformaBloc() {
    batchpaymentRepo = BatchpaymentRepo();

    batchpaymentperforma = StreamController<dynamic>();
    batchpaymentrecipt = StreamController<dynamic>();
  }

  callperformadetailsDetails(Map<String, dynamic> parameter) async {
    try {
      dynamic chuckCats =
          await batchpaymentRepo.batchperformadetails(parameter);
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

  dispose() {
    batchpaymentperforma.close();
    batchpaymentrecipt.close();
  }
}
