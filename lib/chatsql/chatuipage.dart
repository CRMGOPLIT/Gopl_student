import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_student/bloc/gofairbloc.dart';
import 'package:global_student/chatsql/allchatuimodel.dart';
import 'package:global_student/utils/color.dart';
import 'package:global_student/utils/text_style.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class chatPageUIScreen extends StatefulWidget {
  @override
  _chatPageUIScreenState createState() => _chatPageUIScreenState();
}

class _chatPageUIScreenState extends State<chatPageUIScreen> {
  final _messageController = TextEditingController();

  late GoFairBloc goFairBloc;

  bool sendbtn = false;

  bool loading = true;

  final ScrollController _scrollController = ScrollController();

  late IO.Socket socket;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  var data = Get.arguments;
  List<Allchat> chatMessages = [];

  @override
  void initState() {
    super.initState();
    goFairBloc = GoFairBloc();
    connectToNamespace();
    // fetchUsersFromGitHub();
    getallchatdata();
    getallchat();

    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    socket.on('loadNewChat', (datam) {
      Allchat newMessage = Allchat.fromJson(datam);
      if (data[1] == newMessage.receiverId && data[0] == newMessage.senderId) {
        setState(() {
          chatMessages.add(newMessage);
        });
      }
    });
  }

  String? previousDate;

  void connectToNamespace() async {
    socket = IO.io(
      'https://sqlchat-4oqq.onrender.com/user-namespace',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'auth': data[1].toString()}).build(),
    );

    socket.connect();
  }

  Future<void> _sendMessage(
      String senderId, String receiverId, String message) async {
    try {
      final response = await http.post(
        Uri.parse('https://sqlchat-4oqq.onrender.com/save-chat-sql'),
        body: {
          'sender_id': senderId,
          'receiver_id': receiverId,
          'message': message,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          setState(() {
            Allchat newMessage = Allchat.fromJson(responseData["data"][0]);

            setState(() {
              chatMessages.add(newMessage);
            });
            socket.emit('newChat', responseData['data']);
          });

          _messageController.clear();
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception('Failed to send message');
      }
    } catch (error) {}
  }

  getallchatdata() {
    goFairBloc.callallchatStream.listen((event) {
      if (event != null) {
        AllChat allChat = AllChat.fromJson(event);
        chatMessages.addAll(allChat.allchat as Iterable<Allchat>);
        setState(() {
          loading = false;
        });
      }
    });
  }

  getallchat() async {
    Map<String, dynamic> res = {
      "receiver_id": data[0].toString(),
      "sender_id": data[1].toString()
    };
    goFairBloc.callallChat(res);
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
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
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.PrimaryWhiteColor,
            size: 20.sp,
          ),
        ),
      ),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: AppColors.PrimaryMainColor,
            ))
          : SafeArea(
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
                          physics: const ClampingScrollPhysics(),
                          itemCount: chatMessages.length,
                          itemBuilder: (context, index) {
                            final reversedIndex =
                                chatMessages.length - 1 - index;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment:
                                    chatMessages[reversedIndex].senderId ==
                                            data[1]
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: chatMessages[reversedIndex].date ==
                                              null
                                          ? Container()
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE3D4EE),
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(chatMessages[
                                                          reversedIndex]
                                                      .date
                                                      .toString()
                                                      .split("T")[0])))),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: CustomPaint(
                                      painter: MessageBubble(
                                          color: chatMessages[reversedIndex]
                                                      .senderId ==
                                                  data[1]
                                              ? const Color(0xffE3D4EE)
                                              : const Color(0xffDAF0F3),
                                          alignment: chatMessages[reversedIndex]
                                                      .senderId ==
                                                  data[1]
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          tail: true),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .7,
                                        ),
                                        margin: chatMessages[reversedIndex]
                                                    .senderId ==
                                                data[1]
                                            ? const EdgeInsets.fromLTRB(
                                                    7, 7, 17, 7)
                                                .r
                                            : const EdgeInsets.fromLTRB(
                                                    17, 7, 7, 7)
                                                .r,
                                        child: Stack(
                                          children: [
                                            Padding(
                                                padding:
                                                    chatMessages[reversedIndex]
                                                                .senderId ==
                                                            data[1]
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
                                                  data[1] ==
                                                              chatMessages[
                                                                      reversedIndex]
                                                                  .receiverId &&
                                                          data[0] ==
                                                              chatMessages[
                                                                      reversedIndex]
                                                                  .senderId
                                                      ? chatMessages[
                                                              reversedIndex]
                                                          .message
                                                          .toString()
                                                          .trim()
                                                      : data[0] ==
                                                                  chatMessages[
                                                                          reversedIndex]
                                                                      .receiverId &&
                                                              data[1] ==
                                                                  chatMessages[
                                                                          reversedIndex]
                                                                      .senderId
                                                          ? chatMessages[
                                                                  reversedIndex]
                                                              .message
                                                              .toString()
                                                              .trim()
                                                          : "",
                                                  textAlign: TextAlign.left,
                                                  style: batchtext2(chatMessages[
                                                                  reversedIndex]
                                                              .senderId ==
                                                          data[1]
                                                      ? const Color(0xff705982)
                                                      : const Color(
                                                          0xff677D81)),
                                                )),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Text(
                                                  chatMessages[reversedIndex]
                                                      .timestamp
                                                      .toString(),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
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
                      borderRadius: BorderRadius.circular(10.r),
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
                                  controller: _messageController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Message...',
                                    hintStyle: batchtext2(AppColors.hintcolor),
                                    // TextStyle(
                                    //     fontSize: 20.0, color: Colors.redAccent),
                                    fillColor: AppColors.PrimaryMainColor,
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15.r),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              sendbtn == true &&
                                      _messageController.text.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        _sendMessage(
                                            data[1].toString(),
                                            data[0].toString(),
                                            _messageController.text
                                                .replaceAll("'", ""));

                                        setState(() {
                                          _messageController.clear();

                                          sendbtn = false;
                                        });
                                        _scrollController.animateTo(
                                          _scrollController
                                              .position.minScrollExtent,
                                          curve: Curves.easeOut,
                                          duration:
                                              const Duration(milliseconds: 500),
                                        );
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor:
                                            AppColors.PrimaryMainColor,
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
                  ),
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

class CustomRectTween extends RectTween {
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
