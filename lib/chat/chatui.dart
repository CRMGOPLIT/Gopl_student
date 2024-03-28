import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MessageGroupingWithTimeStamp extends StatefulWidget {
  const MessageGroupingWithTimeStamp({Key? key}) : super(key: key);

  @override
  State<MessageGroupingWithTimeStamp> createState() =>
      _MessageGroupingWithTimeStampState();
}

class _MessageGroupingWithTimeStampState
    extends State<MessageGroupingWithTimeStamp> {
  //message controller
  final messageController = TextEditingController();

  bool sendbtn = false;

  //scroll controller
  ScrollController _scrollController = new ScrollController();

  List<MessageModel> messagesList = [
    //adding data into model for Today date
    // MessageModel(
    //     timeStamp: DateTime.now().microsecondsSinceEpoch,
    //     message:
    //         'Hello Today Message and testing long thread for this i hope this will work',
    //     isMe: true),
    MessageModel(
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        message: 'Hello how can i help U ?',
        isMe: false),
  ];

  

  // function to convert time stamp to date
  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    return DateTime(dt.year, dt.month, dt.day);
  }

  //function to return message time in 24 hours format AM/PM
  static String messageTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    String difference = '';
    difference = DateFormat('jm').format(dt).toString();
    return difference;
  }

  static String groupMessageDateAndTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/images/chatlogo.png",
          height: 25.h,
        ),
        leading: GestureDetector(
          onTap: () {
            // onpress!();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.PrimaryWhiteColor,
            size: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(), // ← can't
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      bool isSameDate = false;
                      String? newDate = '';

                      final DateTime date = returnDateAndTimeFormat(
                          messagesList[index].timeStamp.toString());

                      if (index == 0 && messagesList.length == 1) {
                        newDate = groupMessageDateAndTime(
                                messagesList[index].timeStamp.toString())
                            .toString();
                      } else if (index == messagesList.length - 1) {
                        newDate = groupMessageDateAndTime(
                                messagesList[index].timeStamp.toString())
                            .toString();
                      } else {
                        final DateTime date = returnDateAndTimeFormat(
                            messagesList[index].timeStamp.toString());
                        final DateTime prevDate = returnDateAndTimeFormat(
                            messagesList[index + 1].timeStamp.toString());
                        isSameDate = date.isAtSameMomentAs(prevDate);

                        if (kDebugMode) {
                          print("$date $prevDate $isSameDate");
                        }
                        newDate = isSameDate
                            ? ''
                            : groupMessageDateAndTime(messagesList[index - 1]
                                    .timeStamp
                                    .toString())
                                .toString();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: messagesList[index].isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (newDate.isNotEmpty)
                              Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffE3D4EE),
                                          borderRadius:
                                              BorderRadius.circular(10).r),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(newDate),
                                      ))),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: CustomPaint(
                                painter: MessageBubble(
                                    color: messagesList[index].isMe
                                        ? const Color(0xffE3D4EE)
                                        : const Color(0xffDAF0F3),
                                    alignment: messagesList[index].isMe
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    tail: true),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * .7,
                                  ),
                                  margin: messagesList[index].isMe
                                      ? const EdgeInsets.fromLTRB(7, 7, 17, 7).r
                                      : const EdgeInsets.fromLTRB(17, 7, 7, 7)
                                          .r,
                                  child: Stack(
                                    children: [
                                      Padding(
                                          padding: messagesList[index].isMe
                                              ? EdgeInsets.only(
                                                      left: 10.r,
                                                      right: 20.r,
                                                      bottom: 15.r)
                                                  .r
                                              : EdgeInsets.only(
                                                  left: 10.r,
                                                  right: 20.r,
                                                  bottom: 15.r),
                                          child: Text(
                                            messagesList[index].message,
                                            textAlign: TextAlign.left,
                                            style: batchtext2(
                                                messagesList[index].isMe
                                                    ? const Color(0xff705982)
                                                    : const Color(0xff677D81)),
                                          )),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Text(
                                            messageTime(messagesList[index]
                                                    .timeStamp
                                                    .toString())
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 10.sp),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Container(
              height: 50.h,
              margin: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //color: AppColors.PrimaryMainColor

                border: Border.all(color: AppColors.PrimaryMainColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (ff) {
                              setState(() {
                                sendbtn = true;
                              });
                            },
                            controller: messageController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            minLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Enter Message...',
                              hintStyle: batchtext2(AppColors.hintcolor),
                              // TextStyle(
                              //     fontSize: 20.0, color: Colors.redAccent),
                              fillColor: AppColors.PrimaryMainColor,
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              // border: OutlineInputBorder()
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        sendbtn == true && messageController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  MessageModel model = MessageModel(
                                      timeStamp:
                                          DateTime.now().microsecondsSinceEpoch,
                                      message:
                                          messageController.text.toString(),
                                      isMe: true);
                                  // since we are reversing the list so we are inserting date at 0 index to append the list
                                  messagesList.insert(0, model);

                                  setState(() {
                                    messageController.clear();

                                    sendbtn = false;
                                  });
                                  _scrollController.animateTo(
                                    _scrollController.position.minScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: AppColors.PrimaryMainColor,
                                  child: Center(
                                    child: Icon(
                                      Icons.send,
                                      color: AppColors.PrimaryWhiteColor,
                                    ),
                                  ),
                                ),
                              )
                            : Lottie.asset("assets/images/chatani.json",
                                fit: BoxFit.contain),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// model for messages
class MessageModel {
  int timeStamp;
  String message;
  bool isMe;
  MessageModel(
      {required this.timeStamp, required this.message, required this.isMe});
}

// creating bubble
class MessageBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  MessageBubble({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    if (alignment == Alignment.topRight) {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 1, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right bubble curve
        path.quadraticBezierTo(
            w - _radius * 1.5, h, w - _radius * 1.5, h - _radius * 0.6);

        /// bottom-right tail curve 1
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            w - _radius * 0.8, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 1, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right curve
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);
        // bottom-right tail curve 1
        path.quadraticBezierTo(_radius * .8, h, 0, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            _radius * 1, h, _radius * 1.5, h - _radius * 0.6);

        /// bottom-left bubble curve
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        /// bottom-left curve
        path.quadraticBezierTo(_radius, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue)!,
      lerpDouble(begin!.top, end!.top, elasticCurveValue)!,
      lerpDouble(begin!.right, end!.right, elasticCurveValue)!,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue)!,
    );
  }
}

//ignore_for_file: depend_on_referenced_packages

// import 'package:signalr_core/signalr_core.dart';

// class SignalRHelper {
//   HubConnection? _connection;

//   Future<void> connect(String url) async {
//     _connection =
//         HubConnectionBuilder().withUrl(url).withAutomaticReconnect().build();

//     _connection?.onclose((_) {
//       print('SignalR connection closed');
//     });

//     _connection?.on('ReceiveMessage', (message) {
//       print('Received message: $message');
//       // Handle incoming messages here
//     });

//     await _connection?.start();
//     print('SignalR connection started');
//   }

//   Future<void> sendMessage(String message) async {
//     if (_connection != null &&
//         _connection?.state == HubConnectionState.connected) {
//       await _connection?.invoke('SendMessage', args: [message]);
//     } else {
//       print('Error: SignalR connection not established');
//     }
//   }

//   void disconnect() {
//     _connection?.stop();
//     _connection = null;
//   }
// }
