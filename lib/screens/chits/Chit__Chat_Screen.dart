import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import '../../Authentication/root.dart';
import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';

// import 'package:just_audio/just_audio.dart' as ap;
class ChatScreen extends StatefulWidget {
  final ChitModel chit;
  final String name;
  final String id;
  final String profile;
  final Map<String, UserModel> members;
  const ChatScreen({
    Key? key,
    required this.chit,
    required this.name,
    required this.id,
    required this.profile,
    required this.members,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var w = scrWidth;

  TextEditingController msg = TextEditingController();
  List chat = [];
  getChat() {
    FirebaseFirestore.instance
        .collection('chit')
        .doc(widget.id)
        .collection('chat')
        .orderBy('time', descending: false)
        .snapshots()
        .listen((event) {
      chat = event.docs;

      if (mounted) {
        setState(() {});
      }
    });
  }

  ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  void initState() {
    getChat();
    msg = TextEditingController();
    // students = classMap[CurrentUserClassId]['students'];
    // tutors = classMap[CurrentUserClassId]['tutors'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              w * 0.075,
              w * 0.05,
              w * 0.075,
              w * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: scrHeight * 0.02,
                        left: scrWidth * 0.01,
                        bottom: scrHeight * 0.02,
                        right: scrWidth * 0.05),
                    child: SvgPicture.asset(
                      "assets/icons/arrow.svg",
                      width: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.name,
                    style: GoogleFonts.lexend(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      classMates();
                    },
                    child: Icon(Icons.more_horiz_outlined))
              ],
            ),
          ),
          chat.length == 0
              ? Expanded(child: Container())
              : Expanded(
                  child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemPositionsListener: itemPositionsListener,
                  padding: EdgeInsets.only(
                    left: w * 0.025,
                    right: w * 0.025,
                  ),
                  itemCount: chat.length,
                  itemBuilder: (context, index) {
                    DateTime date = chat[index]['time'] == null
                        ? DateTime.now()
                        : chat[index]['time'].toDate();
                    String time = formattedTime(date).toString();
                    return chat[index]['time'] == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              (index != 0 &&
                                      date.toString().substring(0, 10) !=
                                          chat[(index - 1)]['time']
                                              .toDate()
                                              .toString()
                                              .substring(0, 10))
                                  ? Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 15,
                                                right: 15),
                                            child: Text(
                                              (date
                                                          .toString()
                                                          .substring(0, 10) ==
                                                      DateTime.now()
                                                          .toString()
                                                          .substring(0, 10))
                                                  ? 'Today'
                                                  : (date.toString().substring(
                                                              0, 10) ==
                                                          DateTime.now()
                                                              .add(Duration(
                                                                  days: -1))
                                                              .toString()
                                                              .substring(0, 10))
                                                      ? 'Yesterday'
                                                      : DateFormat(
                                                              "MMM dd yyyy")
                                                          .format(date),
                                              style: GoogleFonts.lexend(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Colors.grey.shade700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : index == 0
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 5,
                                                    left: 15,
                                                    right: 15),
                                                child: Text(
                                                  (date.toString().substring(
                                                              0, 10) ==
                                                          DateTime.now()
                                                              .toString()
                                                              .substring(0, 10))
                                                      ? 'Today'
                                                      : (date
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10) ==
                                                              DateTime.now()
                                                                  .add(Duration(
                                                                      days: -1))
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10))
                                                          ? 'Yesterday'
                                                          : DateFormat(
                                                                  "MMM dd yyyy")
                                                              .format(date),
                                                  style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                              chat[index]['id'] == currentuserid
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          bottom: w * 0.03, left: w * 0.125),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                height: w * 0.015,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade600,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(w * 0.03),
                                                  child: Text(
                                                    chat[index]['msg'],
                                                    style: GoogleFonts.lexend(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: w * 0.01,
                                              ),
                                              Text(
                                                time.toString(),
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey.shade700,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          )),
                                          SizedBox(
                                            width: w * 0.025,
                                          ),
                                          CircleAvatar(
                                            radius: w * 0.05,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    chat[index]['photo']),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          bottom: w * 0.03, right: w * 0.125),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: w * 0.05,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    chat[index]['photo']),
                                          ),
                                          SizedBox(
                                            width: w * 0.025,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                chat[index]['name'],
                                                style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13),
                                              ),
                                              SizedBox(
                                                height: w * 0.015,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: chat[index]['type'] ==
                                                          1
                                                      ? primarycolor
                                                          .withOpacity(0.5)
                                                      : Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(w * 0.03),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // chat[index]['type']==1&&chat[index]['voice_clip']!=''?AudioPlayer(
                                                      //   source: ap.AudioSource.uri(Uri.tryParse(chat[index]['voice_clip'])), onDelete: null,message: true,
                                                      // ):Container(),
                                                      (chat[index]['type'] ==
                                                                  1 &&
                                                              chat[index][
                                                                      'media'] !=
                                                                  '' &&
                                                              chat[index][
                                                                      'voice_clip'] ==
                                                                  '')
                                                          ? Image.network(
                                                              chat[index]
                                                                  ['media'])
                                                          : Container(),
                                                      (chat[index]['type'] ==
                                                                  1 &&
                                                              chat[index][
                                                                      'media'] !=
                                                                  '')
                                                          ? SizedBox(
                                                              height: 5,
                                                            )
                                                          : Container(),
                                                      chat[index]['type'] == 0
                                                          ? Text(
                                                              chat[index]
                                                                  ['msg'],
                                                              style: GoogleFonts.lexend(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade900),
                                                            )
                                                          : chat[index]['type'] ==
                                                                      1 &&
                                                                  chat[index][
                                                                          'voice_clip'] ==
                                                                      ''
                                                              ? Text(
                                                                  chat[index]
                                                                      ['msg'],
                                                                  style: GoogleFonts.lexend(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade900),
                                                                )
                                                              : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: w * 0.01,
                                              ),
                                              Text(
                                                time.toString(),
                                                style: GoogleFonts.lexend(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    )
                            ],
                          );
                  },
                )),
          Padding(
            padding: EdgeInsets.all(w * 0.05),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: w * 0.13,
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      controller: msg,
                      style: GoogleFonts.lexend(
                          fontSize: 14, color: Colors.grey.shade700),
                      cursorColor: Colors.grey.shade700,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: 'Type here...',
                          hintStyle: GoogleFonts.lexend(
                              fontSize: 14, color: Colors.grey.shade600),
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                    ),
                  ),
                )),
                SizedBox(
                  width: w * 0.025,
                ),
                Bounce(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (msg.text != '') {
                      await FirebaseFirestore.instance
                          .collection('chit')
                          .doc(widget.id)
                          .collection('chat')
                          .add({
                        'type': 0,
                        'name': currentuser!.userName,
                        'photo': currentuser!.userImage,
                        'msg': msg.text,
                        'time': FieldValue.serverTimestamp(),
                        'id': currentuserid,
                      });
                    }
                    msg.clear();

                    _scrollController.scrollTo(
                        index: chat.length - 1,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInOutCubic);
                  },
                  duration: Duration(milliseconds: 100),
                  child: Container(
                    height: w * 0.12,
                    width: w * 0.15,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Color(0xff02B558),
                            primarycolor,
                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          tileMode: TileMode.mirror,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: SvgPicture.asset('assets/icons/send.svg')),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  classMates() {
    // YoutubePlayerController _controllerZ;
    // _controllerZ = YoutubePlayerController(
    //
    //   initialVideoId:tutorials['PopUpVideoUrl'] ,
    //   flags: YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //
    //   ),
    // );
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Class Members',
                                    style: GoogleFonts.lexend(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w * 0.04),
                                  ),
                                  SizedBox(
                                    width: w * 0.05,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: w * 0.03,
                                    child: Text(
                                      (widget.chit.members!.length).toString(),
                                      style: GoogleFonts.lexend(
                                          fontWeight: FontWeight.w600,
                                          fontSize: w * 0.02,
                                          color: Colors.white60),
                                    ),
                                  ),
                                ],
                              ),
                              Bounce(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                duration: Duration(milliseconds: 100),
                                child: CircleAvatar(
                                    backgroundColor: primarycolor,
                                    radius: w * 0.035,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: w * 0.04,
                                    )),
                              ),
                            ],
                          ),
                          Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.chit.members!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.grey.shade100,
                                        backgroundImage:
                                            CachedNetworkImageProvider(widget
                                                .members[widget
                                                    .chit.members![index]]!
                                                .userImage!),
                                      ),
                                      SizedBox(
                                        width: w * 0.05,
                                      ),
                                      Text(
                                        currentuserid ==
                                                widget.chit.members![index]
                                            ? 'You'
                                            : widget
                                                .members[widget
                                                    .chit.members![index]]!
                                                .userName!,
                                        style: GoogleFonts.lexend(
                                            fontWeight: FontWeight.w600,
                                            fontSize: w * 0.035,
                                            color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ));
  }
}

String formattedTime(DateTime dateTime) {
  return DateFormat().add_jm().format(dateTime);
}
