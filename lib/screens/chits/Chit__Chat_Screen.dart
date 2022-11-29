import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Authentication/root.dart';
import '../../model/usermodel.dart';
import '../splash_screen.dart';
import 'imageView.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String id;
  final String profile;
  final Map<String, UserModel> members;
  const ChatScreen(
      {Key? key,
      required this.name,
      required this.id,
      required this.profile,
      required this.members})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textData = TextEditingController();
  DateTime? d;
  bool emojiShowing = false;
  final ImagePicker _picker = ImagePicker();
  File? chatimage;
  File? file;
  dynamic url;
  String? chatfileName;
  String? ext;
  String? size;
  var bytes;

  var loginKey = GlobalKey<FormState>();

  _onEmojiSelected(Emoji emoji) {
    textData
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textData.text.length));
  }

  _onBackspacePressed() {
    textData
      ..text = textData.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: textData.text.length));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          leadingWidth: 90, //MediaQuery.of(context).size.width,
          leading: Row(children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff101010),
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.profile),
              child: widget.profile == '' ? Icon(Icons.groups) : SizedBox(),
            )
          ]),
          title: Text(widget.name),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("chit")
                        .doc(widget.id)
                        .collection('chats')
                        .orderBy('sendTime', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      var msg = snapshot.data!.docs;
                      print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
                      print(msg.length);
                      print(snapshot);
                      return Expanded(
                        child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            // physics: const BouncingScrollPhysics(),
                            itemCount: msg.length,
                            itemBuilder: (context, index) {
                              List readBy = msg[index]['readBy'];
                              if (msg[index]['senderId'] != currentuserid) {
                                if (readBy.contains(currentuserid)) {
                                } else {
                                  FirebaseFirestore.instance
                                      .collection("chit")
                                      .doc(widget.id)
                                      .collection('chats')
                                      .doc(msg[index].id)
                                      .update({
                                    'readBy':
                                        FieldValue.arrayUnion([currentuserid])
                                  });
                                }
                              }

                              Timestamp t = msg[index]['sendTime'];
                              d = t.toDate();
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              return Align(
                                alignment:
                                    (msg[index]["senderId"] == currentuserid
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              45,
                                      minWidth: 115),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color:
                                        (msg[index]["senderId"] == currentuserid
                                            ? Colors.green[200]
                                            : Colors.grey.shade200),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (msg[index]['type'] == "image") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FileViewPage(
                                                      url: msg[index]['file'],
                                                      type: 'img',
                                                    ),
                                                  ));
                                            } else if (msg[index]['type'] ==
                                                "file") {
                                              if (msg[index]['ext'] == "mp4") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FileViewPage(
                                                        url: msg[index]['file'],
                                                        type: 'vid',
                                                      ),
                                                    ));
                                              } else if (msg[index]['ext'] ==
                                                  "jpg") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FileViewPage(
                                                        url: msg[index]['file'],
                                                        type: 'img',
                                                      ),
                                                    ));
                                              } else if (msg[index]['ext'] ==
                                                  "pdf") {
                                                Uri link = Uri.parse(
                                                    msg[index]['file']);
                                                launchUrl(link);
                                              }
                                            }
                                          },
                                          child: msg[index]["senderId"] ==
                                                  currentuserid
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    right: 30,
                                                    top: 5,
                                                    bottom: 20,
                                                  ),
                                                  child: msg[index]['type'] ==
                                                          "text"
                                                      ? Text(
                                                          msg[index]["message"],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                          ),
                                                        )
                                                      : msg[index]['type'] ==
                                                              "image"
                                                          ? CachedNetworkImage(
                                                              imageUrl:
                                                                  msg[index]
                                                                      ['file'])
                                                          : Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .file_present),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        msg[index]
                                                                            [
                                                                            'fileName'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(msg[index]
                                                                            [
                                                                            'size']
                                                                        .toString()),
                                                                    Text("•"),
                                                                    Text(msg[
                                                                            index]
                                                                        ['ext'])
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    right: 30,
                                                    top: 5,
                                                    bottom: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        widget
                                                            .members[msg[index]
                                                                ['senderId']]!
                                                            .userName!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                          height: scrHeight *
                                                              0.006),
                                                      msg[index]['type'] ==
                                                              "text"
                                                          ? Text(
                                                              msg[index]
                                                                  ["message"],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : msg[index][
                                                                      'type'] ==
                                                                  "image"
                                                              ? CachedNetworkImage(
                                                                  imageUrl: msg[
                                                                          index]
                                                                      ['file'])
                                                              : Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons
                                                                            .file_present),
                                                                        Text(
                                                                          msg[index]
                                                                              [
                                                                              'fileName'],
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(msg[index]['size']
                                                                            .toString()),
                                                                        Text(
                                                                            "•"),
                                                                        Text(msg[index]
                                                                            [
                                                                            'ext'])
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                    ],
                                                  ),
                                                ),
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          right: 10,
                                          child: Row(
                                            children: [
                                              Text(
                                                DateFormat('h:mm a')
                                                    .format(d!)
                                                    .toLowerCase(),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              // msg[index]["senderId"] ==
                                              //         currentuserid
                                              //     ? Icon(
                                              //         Icons.done_all,
                                              //         color: msg[index]
                                              //                 ["readBy"]
                                              //             ? Colors.blue
                                              //             : Colors.grey,
                                              //         size: 20,
                                              //       )
                                              //     : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.793,
                      child: TextFormField(
                        onTap: () {
                          setState(() {
                            emojiShowing = false;
                          });
                        },
                        autofocus: false,
                        controller: textData,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  width: 0, color: Colors.white)),
                          prefixIcon: InkWell(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              await Future.delayed(
                                  const Duration(milliseconds: 99));

                              setState(() {
                                emojiShowing = !emojiShowing;
                              });
                            },
                            child: const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Message',
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),

                          // suffixIcon: Row(
                          //   children: [
                          //     Transform.rotate(
                          //         angle: 45,
                          //         child: IconButton(
                          //           icon: const Icon(
                          //               Icons.attach_file_outlined),
                          //           onPressed: () {},
                          //         ))
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FloatingActionButton(
                        backgroundColor: Colors.teal,
                        onPressed: () {
                          sendMessage();
                          setState(() {
                            textData.clear();
                          });
                        },
                        child: const Icon(Icons.send),
                      ),
                    )
                  ],
                ),
                Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                        onEmojiSelected: (Category? category, Emoji emoji) {
                          _onEmojiSelected(emoji);
                        },
                        onBackspacePressed: _onBackspacePressed,
                        config: const Config(
                            columns: 7,
                            // Issue: https://github.com/flutter/flutter/issues/28894
                            emojiSizeMax: 32 * 1.0,
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            gridPadding: EdgeInsets.zero,
                            initCategory: Category.RECENT,
                            bgColor: Color(0xFFF2F2F2),
                            indicatorColor: Colors.teal,
                            iconColor: Colors.grey,
                            iconColorSelected: Colors.black,
                            backspaceColor: Colors.grey,
                            skinToneDialogBgColor: Colors.white,
                            skinToneIndicatorColor: Colors.grey,
                            enableSkinTones: true,
                            showRecentsTab: true,
                            recentsLimit: 28,
                            replaceEmojiOnLimitExceed: false,
                            noRecents: Text(
                              'No Recent',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black26),
                              textAlign: TextAlign.center,
                            ),
                            tabIndicatorAnimDuration: kTabScrollDuration,
                            categoryIcons: CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  imgPicker() async {
    XFile? file =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 45);
    if (file != null) {
      chatimage = File(file.path);
      setState(() {});
    }
  }

  sendMessage() {
    FirebaseFirestore.instance
        .collection("chit")
        .doc(widget.id)
        .collection('chats')
        .add({
      'message': textData.text,
      'senderId': currentuserid,
      'readBy': [],
      'sendTime': DateTime.now(),
      'type': 'text'
    }).then((value) {
      value.update({'msgId': value.id});
    });
  }

  sendPhoto() {
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance
        .ref()
        .child('chit/${widget.id}/chat/$fileName');
    UploadTask uploadTask = ref.putFile(File(chatimage!.path));
    setState(() {
      chatimage = null;
    });
    uploadTask.then((res) async {
      url = (await ref.getDownloadURL()).toString();
    }).then((value) => FirebaseFirestore.instance
            .collection("chit")
            .doc(widget.id)
            .collection('chats')
            .add({
          "file": url,
          "senderId": currentuserid,
          "sendTime": DateTime.now(),
          "readBy": [],
          "type": "image"
        }).then((value) {
          value.update({"msgId": value.id});
        }));
  }

  sendFile() {
    var ref = FirebaseStorage.instance
        .ref()
        .child('chat/${DateTime.now().toString()}');
    UploadTask uploadTask = ref.putFile(File(file!.path));
    setState(() {
      file = null;
    });
    uploadTask.then((res) async {
      url = (await ref.getDownloadURL()).toString();
    }).then((value) => FirebaseFirestore.instance
            .collection("chit")
            .doc(widget.id)
            .collection('chats')
            .add({
          "file": url,
          "fileName": chatfileName,
          "senderId": currentuserid,
          "sendTime": DateTime.now(),
          "readBy": [],
          "type": "file",
          "ext": ext,
          "size": size,
        }).then((value) {
          value.update({"msgId": value.id});
        }));
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      chatfileName = result.files.single.name;
      ext = result.files.single.extension;
      bytes = result.files.single.bytes;

      size = formatBytes(result.files.single.size, 2);
      setState(() {});
      print('bytes!!!!!!!!' + bytes.toString());
    } else {
      // User canceled the picker
    }
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1000, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
