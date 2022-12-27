//@dart=2.9
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:record/record.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Notes/notes.dart';
import 'package:just_audio/just_audio.dart' as ap;

import '../customPackage/date_picker.dart';
import '../customPackage/time_picker.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'audio_player.dart';
import 'noti.dart';
import 'notifications.dart';
String storagePath(String uid, String filePath, bool isVideo) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  return 'users/$uid/uploads/$timestamp.$ext';
}
class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);
  final String storagePath;
  final Uint8List bytes;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}
Future<SelectedMedia> selectMedia({
  double maxWidth,
  double maxHeight,
  bool isVideo = false,
  MediaSource mediaSource = MediaSource.camera,
}) async {
  final picker = ImagePicker();
  final source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage(
      maxWidth: maxWidth, maxHeight: maxHeight, source: source);
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final path = storagePath(currentuserid, pickedMedia.name, isVideo);
  return SelectedMedia(path, mediaBytes);
}
Future<String> uploadData(String path, Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  final result = await storageRef.putData(data, metadata);
  return result.state == TaskState.success ? result?.ref.getDownloadURL() : null;
}
const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif','audio/mp4'};


class NotesDetailPage extends StatefulWidget {
     Map notes;
    final bool update;
   NotesDetailPage({Key key, this.notes,  this.update,  }) : super(key: key);

  @override
  State<NotesDetailPage> createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  Timestamp rDate;

  final record = Record();
  Timer _timer;
  Timer _ampTimer;
  final _audioRecorder = Record();
  bool showPlayer = false;
  ap.AudioSource audioSource;
   final TextEditingController titleController=TextEditingController();
  final TextEditingController contentController=TextEditingController();
  FocusNode titleFocus=FocusNode();
  FocusNode contentFocus=FocusNode();

  DateTime selectedDate;
  TimeOfDay selectedTime;
  DateTime datetime=DateTime.now();


//DatePick----------------
  Future<void> _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        firstDate: DateTime(DateTime
            .now()
            .year - 2),
        // DateTime.now(),
        lastDate: DateTime(DateTime
            .now()
            .year + 2),
        initialDate: DateTime.now(),
        builder: (context, child) =>
            Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(primary: Colors.green)),
                child: child));
    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = datePicked;
        datetime=selectedDate;
      });
    }
  }
  //TimePick--------
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child));
    if (timePicked != null && timePicked != selectedTime) {

      setState(() {
        selectedTime = timePicked;
        // datetime=selectedTime as DateTime;
      });

    }
  }
  bool _remainder=false;




  getData(){
    if(widget.update){
      selectedDate=widget.notes['date'].toDate();
      titleController.text=widget.notes['title'];
      contentController.text=widget.notes['content'];
      savedVoice=widget.notes['audio'];
      _audioUrl=widget.notes['audio'];
      selectedTime=TimeOfDay(
           hour: int.parse(widget.notes['time'].split(':')[0]),
           minute: int.parse(widget.notes['time'].split(':')[1]));
      _time.text=widget.notes['remainderTime'];
      _date.text=widget.notes['remainderDate'];
      _remainder=widget.notes['remainder'];


    }
  }
  // getData(){
  //   if(widget.update){
  //    selectedDate=widget.notes!['date'].toDate();
  //    titleController=TextEditingController(text:widget.notes!['title'].toString()??'' );
  //   // titleController?.text=widget.notes!['title'].toString()??'';
  //    contentController=TextEditingController(text:widget.notes!['content'].toString()??'' );
  //   // contentController?.text=widget.notes!['content'].toString()??'';
  //   }
  // }
  DateTime dateTime = DateTime.now();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _date=TextEditingController();


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    getData();
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings iosInitializationSettings =DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (dataYouNeedToUseWhenNotificationIsClicked) {},
    );
    // print('sneha'+widget.notes['rDate'].toString());
    if(widget.notes!=null){
      for(int i=0;i<2;i++){
        showNotification();


      }
    }

  }

  showNotification() {
    if (widget.notes['title'].isEmpty || widget.notes['time'].isEmpty) {
      return;
    }
    String s=widget.notes['remainderTime'];
     var t=widget.notes['rDate'].toDate();

    TimeOfDay _startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
    dateTime=DateTime(
      t.year,
      t.month,
      t.day,
      _startTime.hour,
      _startTime.minute,
    ).add(Duration(seconds: 1));
    print("************************************************${dateTime.toString()}");

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );
    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt =
    tz.TZDateTime.from(dateTime, tz.local)
        .add(const Duration(seconds: 10));
    flutterLocalNotificationsPlugin.zonedSchedule(
        01,widget.notes['title'],
        widget.notes['content'],
        scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: 'Ths is the data');
  }
  // @override
  // void initState() {
  //
  //
  //     getData();
  //   // TODO: implement initState
  //   super.initState();
  // }
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;

  Widget _buildRecordStopControl() {
    Container icon;
    if (_isRecording || _isPaused) {
      icon = Container(child: Icon(Icons.stop, color: Colors.black, size: 30));
      // color = myColor.withOpacity(0.1);
    } else {
      icon = Container(
        margin: EdgeInsets.only(left: scrWidth*0.75),
        width: 25,
        height: 23,
        decoration: const BoxDecoration(

        ),
        child:Icon(Icons.mic,size: 25,),
      );
    }

    return InkWell(
      child:SizedBox( child: icon),
      onTap: () {
        _isRecording ? _stop() : _start();
      },
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    Icon icon;
    if (!_isPaused) {
      icon = Icon(Icons.pause, color: Colors.black, size: 30);
    } else {
      icon = Icon(Icons.play_arrow, color: Colors.black, size: 30);
    }

    return InkWell(
      child: SizedBox( child: icon),
      onTap: () {
        _isPaused ? _resume() : _pause();
      },
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }
    return Container();
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.black),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });
        _startTimer();
      }
    } catch (e){
    }
  }


List _audioUrl=[];
  List Path=[];
  List savedVoice=[];

  String audioUrl="";
  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();

    // widget.onStop(path);

    setState((){
      audioSource = ap.AudioSource.uri(Uri.parse(path));

      Path.add(audioSource);

    });

    File audio =File(path);
    Path.add(audio);
    Uint8List bytes=await audio.readAsBytes();
    if (validateFileFormat(path,context)) {
      // showUploadMessage(
      //     context, 'Uploading file...',
      //     showLoading: true);
      final downloadUrl = await uploadData(path,bytes);
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();
      if (downloadUrl != null) {
        setState(() {
          audioUrl = downloadUrl;
          _audioUrl.add(audioUrl);
          savedVoice.add(audioUrl);
        }

        );
        // showUploadMessage(
        //     context, 'Success');
      } else {
        // showUploadMessage(context,
        //     'Failed to upload media');
      }
    }
    showPlayer = false;
    _isRecording = false;
    setState(() {
    }
    );
  }
  bool validateFileFormat(String filePath, BuildContext context) {
    if (allowedFormats.contains(mime(filePath))) {
      return true;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('Invalid file format: ${mime(filePath)}'),
      ));
    return false;
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
  @override
  Widget build(BuildContext context) {
    print('player'+showPlayer.toString());
    print('record'+_isRecording.toString());
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: scrHeight*0.05,),
            Container(
              color: Color(0xff008036),
              width: scrWidth,
              height: scrHeight * 0.07,
              child: Padding(
                padding: EdgeInsets.symmetric(),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_outlined,size: 17,color: Colors.white,)),
                    // SvgPicture.asset('assets/svg/back.svg'),
                    // SizedBox(
                    //   width: scrWidth * 0.039,
                    // ),
                    Text(
                      "Write Note",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w500,
                          fontSize: scrWidth * 0.045,
                          color: Colors.white),
                    ),
                     Expanded(child: SizedBox(width: scrWidth*0.5,)),
                    Row(
                      children: [
                        // Checkbox(
                        //   value: _remainder,
                        //   onChanged: (bool value) {
                        //     setState(() {
                        //       _remainder = value;
                        //       print(_remainder);
                        //     });
                        //   },
                        // ),

                        IconButton(
                            onPressed: () {
                              print(currentuserid);
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: const Text("Do You Want to save this"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,MaterialPageRoute(builder: (context)=>NotesPage()), (route) => false);
                                      },
                                      child: const Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () {


                                        if(widget.update){
                                            DateTime date=DateTime(selectedDate.year,
                                              selectedDate.month,selectedDate.day,
                                              int.parse(selectedTime.hour.toString()),
                                              int.parse(selectedTime.minute.toString()),
                                            );
                                            FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .doc(currentuserid)
                                                .collection('notes').doc(widget.notes['noteId']).update
                                                ({
                                              'rDate':dateTime,
                                              'remainder':_remainder,
                                              'remainderDate':_date.text,
                                              'remainderTime':_time.text,
                                              'date':date,
                                              'title':titleController.text,
                                              'content':contentController.text,
                                              'audio':_audioUrl,
                                              'time':'${selectedTime.hour.toString()}:${selectedTime.minute.toString()}'
                                            });
                                            Navigator.pushAndRemoveUntil(context,
                                                MaterialPageRoute(builder: (context)=>NotesPage()),
                                                    (route) => false);
                                          }else{
                                            DateTime date=DateTime(selectedDate.year,
                                              selectedDate.month,selectedDate.day,
                                              int.parse(selectedTime.hour.toString()),
                                              int.parse(selectedTime.minute.toString()),
                                            );
                                            FirebaseFirestore
                                                .instance
                                                .collection('users')
                                                .doc(currentuserid)
                                                .collection('notes')
                                                .add({
                                              'rDate':dateTime,

                                              'remainder':_remainder,
                                              'remainderDate':_date.text,
                                              'remainderTime':_time.text,
                                              'date':date,
                                              'title':titleController.text,
                                              'content':contentController.text,
                                              'audio':_audioUrl,
                                              'time':'${selectedTime.hour.toString()}:${selectedTime.minute.toString()}'
                                                }).then((value) =>
                                                value.update({'noteId':value.id}));
                                            Navigator.pushAndRemoveUntil(context,
                                                MaterialPageRoute(builder: (context)=>NotesPage()),
                                                    (route) => false);
                                          }
                                          },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: primarycolor),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                        }, icon:Icon(Icons.check_outlined,color: Colors.white,)),
                      ],
                    ),
                    // IconButton(onPressed: (){}, icon:Icon(Icons.mic,color: Colors.white,))
                  ],
                ),
              ),
            ),
            SizedBox(height: scrHeight*0.03,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.034,right: scrWidth*0.034),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              width: scrWidth*0.44,
                              // width: scrWidth,
                              height: textFormFieldHeight45,
                              padding: EdgeInsets.symmetric(
                                horizontal: scrWidth * 0.015,
                                vertical: scrWidth * 0.002,
                              ),
                              decoration: BoxDecoration(
                                color: textFormFieldFillColor,
                                border: Border.all(
                                  color: Color(0xffDADADA),
                                ),
                                borderRadius: BorderRadius.circular(scrWidth * 0.026),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.03),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedDate == null
                                          ? "Date"
                                          : DateFormat.yMMMd().format(selectedDate),
                                      style: TextStyle(
                                        color: selectedDate == null
                                            ? Colors.grey
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/date.svg',
                                      color: Color(0xff8391A1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () {
                               _selectTime(context);
                              // print(selectedTime.toString());
                            },
                            child: Container(
                              // color: Colors.pink,
                              width: scrWidth * 0.44,
                              // width: 160,
                              height: textFormFieldHeight45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffDADADA),
                                ),
                                color: textFormFieldFillColor,
                                borderRadius:
                                BorderRadius.circular(scrWidth * 0.033),
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: padding15),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    selectedTime == null
                                        ? "Draw Time"
                                        : "${selectedTime.hour.toString()}: ${selectedTime.minute.toString().length == 1 ? '0${selectedTime.minute.toString()}' : selectedTime.minute.toString()}",
                                    style: TextStyle(
                                      color: selectedTime == null
                                          ? Color(0xffB0B0B0)
                                          : Colors.black,
                                      fontSize: FontSize14,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.04,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/time.svg',
                                    color: Color(0xffB0B0B0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: scrHeight*0.023,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text("Set Remainder",style: TextStyle(
                              fontSize: 17,color: Colors.black,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
                            ),),
                          ),
                          // SizedBox(width: 8,),

                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              thumbColor: _remainder
                                  ? Color(0xff02B558)
                                  : Colors.grey,
                              activeColor: Color(0xffD9D9D9),
                              trackColor: Color(0xffD9D9D9),
                              value:_remainder,
                              onChanged: ( bool value) {
                                setState(() {
                                  _remainder = value;
                                  print(_remainder);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      _remainder==true? Container(
                        width: scrWidth * 0.94,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrWidth * 0.002,
                        ),
                        decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            border: Border.all(
                              color: Color(0xffDADADA),
                            ),
                            borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          controller: _time,
                          cursorHeight: scrWidth * 0.055,
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                          ),
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: const Icon(
                                Icons.timer_outlined,
                              ),
                              onTap: () async {
                                final TimeOfDay slectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()
                                );

                                if (slectedTime == null) {
                                  return;
                                }
                                _time.text =
                                "${slectedTime.hour}:${slectedTime.minute}:${slectedTime.period.toString()}";

                                DateTime newDT = DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                  slectedTime.hour,
                                  slectedTime.minute,
                                );
                                setState(() {
                                  dateTime = newDT;
                                });
                              },
                            ),

                            labelText: 'Set Time',
                            labelStyle: TextStyle(
                              color: Color(0xffB0B0B0),
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                left: scrWidth * 0.03,
                                top: scrHeight * 0.006,
                                bottom: scrWidth * 0.033),
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            border: InputBorder.none,
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: primarycolor,
                            //     width: 2,
                            //   ),
                            // ),
                          ),
                        ),
                      ):Container(),
                      SizedBox(height: scrHeight*0.023,),
                      _remainder==true? Container(
                        width: scrWidth * 0.94,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrWidth * 0.002,
                        ),
                        decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            border: Border.all(
                              color: Color(0xffDADADA),
                            ),
                            borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          controller: _date,
                          cursorHeight: scrWidth * 0.055,
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                          ),
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Icon(Icons.date_range),
                              onTap: () async {
                                final DateTime newlySelectedDate =
                                await showDatePicker(
                                  context: context,
                                  initialDate: dateTime,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2095),
                                );

                                if (newlySelectedDate == null) {
                                  return;
                                }

                                setState(() {
                                  dateTime = newlySelectedDate;
                                  _date.text =
                                  "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                });
                              },
                            ),
                            labelText: 'Set Date',
                            labelStyle: TextStyle(
                              color:  Color(0xffB0B0B0),
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                left: scrWidth * 0.03,
                                top: scrHeight * 0.006,
                                bottom: scrWidth * 0.033),
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            border: InputBorder.none,
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: primarycolor,
                            //     width: 2,
                            //   ),
                            // ),
                          ),
                        ),
                      ):Container(),
                      SizedBox(height: scrHeight*0.023,),
                      Container(
                        width: scrWidth * 0.94,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrWidth * 0.002,
                        ),
                        decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            border: Border.all(
                              color: Color(0xffDADADA),
                            ),
                            borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          controller: titleController,
                           focusNode: titleFocus,
                          cursorHeight: scrWidth * 0.055,
                          cursorWidth: 1,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                          ),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              color: titleFocus.hasFocus
                                  ? primarycolor
                                  : Color(0xffB0B0B0),
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                left: scrWidth * 0.03,
                                top: scrHeight * 0.006,
                                bottom: scrWidth * 0.033),
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            border: InputBorder.none,
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: primarycolor,
                            //     width: 2,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(height: scrWidth*0.05,),
                      Center(
                        child: Container(
                          width: scrWidth * 0.94,
                          height: textFormFieldHeight45,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffDADADA)),
                            color:textFormFieldFillColor,
                            borderRadius: BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child:
                          showPlayer
                              ? AudioPlayer(
                            source: audioSource,
                            message: false,
                            onDelete: () {
                              setState(() => showPlayer = false);
                            },
                          ) :
                          _isRecording==false?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              showPlayer ?
                              AudioPlayer(
                                source: audioSource,
                                onDelete: () {
                                  setState(() => showPlayer = false);
                                }, message: null,
                              ) :Container(),
                              showPlayer?Container():
                              showPlayer?Container():
                              showPlayer==true?Container():
                              _buildRecordStopControl(),
                                                                                        ],
                          ):Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildText(),
                                _buildPauseResumeControl(),
                                _buildRecordStopControl(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: scrWidth*0.05,),

                      TextField(
                        controller: contentController,

                        maxLines: null,
                        //expands: true,
                        keyboardType: TextInputType.multiline,
                        //cursorHeight: scrWidth * 0.055,
                        cursorWidth: 1,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Enter a message',
                          hintStyle: TextStyle(
                              color: Color(0xffB0B0B0)),
                          fillColor: textFormFieldFillColor,
                          filled: true,
                          focusedBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            borderSide: BorderSide(
                              color:  Color(0xffDADADA),
                            )
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.026),
                            borderSide: BorderSide(color:  Color(0xffDADADA),)
                          ),
                          contentPadding: EdgeInsets.only(
                              left: scrWidth * 0.03,
                              top: scrHeight * 0.006,
                              bottom: scrWidth * 0.033),
                        ),
                        // maxLines: null,
                        // //expands: true,
                        // keyboardType: TextInputType.multiline,
                      ),


                      // SizedBox(height: 10,),

                     // _remainder==true?
                     // TextField(
                     //    controller: _time,
                     //    decoration: InputDecoration(
                     //        border: OutlineInputBorder(
                     //          borderRadius: BorderRadius.circular(12.0),
                     //        ),
                     //        suffixIcon: InkWell(
                     //          child: const Icon(
                     //            Icons.timer_outlined,
                     //          ),
                     //          onTap: () async {
                     //            final TimeOfDay slectedTime = await showTimePicker(
                     //                context: context,
                     //                initialTime: TimeOfDay.now()
                     //            );
                     //
                     //            if (slectedTime == null) {
                     //              return;
                     //            }
                     //            _time.text =
                     //            "${slectedTime.hour}:${slectedTime.minute}:${slectedTime.period.toString()}";
                     //
                     //            DateTime newDT = DateTime(
                     //              dateTime.year,
                     //              dateTime.month,
                     //              dateTime.day,
                     //              slectedTime.hour,
                     //              slectedTime.minute,
                     //            );
                     //            setState(() {
                     //              dateTime = newDT;
                     //            });
                     //          },
                     //        ),
                     //        label: Text("Time")),
                     //  )
                     //     :Container(),
                     //  SizedBox(height: 10,),

                      // _remainder==true?TextField(
                      //   controller: _date,
                      //   decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(12.0),
                      //       ),
                      //       suffixIcon: InkWell(
                      //         child: Icon(Icons.date_range),
                      //         onTap: () async {
                      //           final DateTime newlySelectedDate =
                      //           await showDatePicker(
                      //             context: context,
                      //             initialDate: dateTime,
                      //             firstDate: DateTime.now(),
                      //             lastDate: DateTime(2095),
                      //           );
                      //
                      //           if (newlySelectedDate == null) {
                      //             return;
                      //           }
                      //
                      //           setState(() {
                      //             dateTime = newlySelectedDate;
                      //             _date.text =
                      //             "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                      //           });
                      //         },
                      //       ),
                      //       label: Text("Date")),
                      // ):Container(),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:_audioUrl.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding:  EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: primarycolor.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: AudioPlayer(
                                          source: ap.AudioSource.uri(Uri.tryParse(_audioUrl[index])),
                                          onDelete: null,
                                          message: true,
                                        ),

                                      ),
                                    ),
                                    IconButton(onPressed: (){
                                      _audioUrl.remove(_audioUrl[index]);
                                      // savedVoice.remove(savedVoice[index]);
                                      setState(() {

                                      });

                                    }, icon: Icon(Icons.delete))
                                  ],
                                ),
                              );
                            }),

                      ),




                      // SizedBox(
                      //   height: scrHeight*0.65,
                      //   child: Container(
                      //     width: scrWidth * 0.94,
                      //       height: textFormFieldHeight45,
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: scrWidth * 0.015,
                      //         vertical: scrWidth * 0.002,
                      //       ),
                      //       decoration: BoxDecoration(
                      //           color: textFormFieldFillColor,
                      //           border: Border.all(
                      //             color: Color(0xffDADADA),
                      //           ),
                      //           borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                      //     child: TextField(
                      //       controller: contentController,
                      //       cursorHeight: scrWidth * 0.055,
                      //       cursorWidth: 1,
                      //       cursorColor: Colors.black,
                      //       decoration: InputDecoration(
                      //         hintText: 'Enter a message',
                      //         hintStyle: TextStyle(
                      //             color: Color(0xffB0B0B0)),
                      //         border: InputBorder.none,
                      //         contentPadding: EdgeInsets.only(
                      //             left: scrWidth * 0.03,
                      //             top: scrHeight * 0.006,
                      //             bottom: scrWidth * 0.033),
                      //       ),
                      //
                      //       maxLines: null,
                      //       expands: true,
                      //       keyboardType: TextInputType.multiline,
                      //     ),
                      //   ),
                      // )



                    ],
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () => _selectDate(context),
            //     child:  Text("Add reminder")
            // ),
            // ElevatedButton(onPressed: (){
            //    Navigator.push(context,MaterialPageRoute(builder: (context)=>LocalNotifications()));
            //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>
            //   //     NotificationPage(not: widget.notes,)));
            //   }, child: Text("uygy")),
            // ElevatedButton(onPressed: (){}, child: Text("Add Rem"))



          ],
        ),
      ),
    );
  }
}
