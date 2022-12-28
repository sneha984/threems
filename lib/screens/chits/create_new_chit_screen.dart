import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:threems/customPackage/date_picker.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/screens/chits/add_members.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';

import '../../Authentication/root.dart';
import '../../customPackage/time_picker.dart';
import '../../model/ChitModel.dart';
import '../home_screen.dart';
import 'create_chit_payment_session.dart';

class CreateNewChitScreen extends StatefulWidget {
  final ChitModel chit;
  const CreateNewChitScreen({Key? key, required this.chit}) : super(key: key);

  @override
  State<CreateNewChitScreen> createState() => _CreateNewChitScreenState();
}

class _CreateNewChitScreenState extends State<CreateNewChitScreen> {
  int chitTabBarIndex = 0;
  int drawnOrAuctionTabBarIndex = 0;
  final CrCalendarController calendarController = CrCalendarController();
  final PageController _privateOrPublicChitpageController =
      PageController(keepPage: true);
  final PageController _drawnOrAuctionpageController =
      PageController(keepPage: true);

  List dropDownList = ["0%", "1%", "2%", "3%", "4%", "5%"];
  List drawType = ['Weekly', 'Monthly'];
  List drawDate = [];
  FocusNode chitNameFocus = FocusNode();
  FocusNode valueAmountFocus = FocusNode();
  FocusNode durationFocus = FocusNode();
  FocusNode subscriptionAmountFocus = FocusNode();
  FocusNode dividentAmountFocus = FocusNode();

  int members = 10;
  bool private = false;
  TextEditingController chitName = TextEditingController();
  String? dropdownValue;

  TextEditingController amount = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController subscriptionAmount = TextEditingController();
  bool draw = true;
  TextEditingController dividend = TextEditingController();
  String? drawTypeValue;
  String? drawDateValue;
  String profile = "";
  String url = "";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  var pickFile;
  var fileName;
  Future uploadFileToFireBase(fileBytes) async {
    print(fileBytes);
    uploadTask = FirebaseStorage.instance
        .ref('uploads/${DateTime.now()}')
        .putData(fileBytes);
    final snapshot = await uploadTask?.whenComplete(() {});
    final urlDownlod = await snapshot?.ref.getDownloadURL();
    print(
        "--------------------------------------------------------------------------------");

    print(urlDownlod);

    // FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
    //   'documents.$name':urlDownlod,
    // });

    setState(() {
      fileUrl = urlDownlod!;
    });
  }

  String? ext;
  String? size;
  var bytes;

  _pickFile() async {
    print('      PICK FILE      ');
    final result = await FilePicker.platform.pickFiles(
      withData: true,
    );

    if (result == null) return;

    // final fileBytes=result.files.first.bytes;

    pickFile = result.files.first;
    final fileBytes = pickFile!.bytes;
    fileName = result.files.first.name;
    ext = result.files.single.extension;
    bytes = result.files.single.bytes;

    size = formatBytes(result.files.single.size, 2);

    print(fileBytes);
    print('      PICK FILE      ');
    print(ext);
    print(bytes);
    print(size);
    uploadFileToFireBase(fileBytes);
    setState(() {});
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1000, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

//TimePicker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child!));
    if (timePicked != null && timePicked != selectedTime) {
      setState(() {
        selectedTime = timePicked;
      });
    }
  }

  var profileFile;
  var imgFile;
  var uploadTask;
  var fileUrl;
  Future uploadImageToFirebase(BuildContext context, String type) async {
    Reference firebaseStorageRef;
    if (type == 'Profile') {
      firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('chit/profile/${profileFile.path}');
    } else {
      firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('deposits/proofDocument/${imgFile.path}');
    }

    UploadTask uploadTask =
        firebaseStorageRef.putFile(type == 'Profile' ? profileFile : imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }

    setState(() {
      type == 'Profile' ? profile = value : url = value;
      print("----=========-============-===============-=============");
      type == 'Profile' ? print(profile) : print(url);
      print("----=========-============-===============-=============");
    });
  }

  _pickImage(String type) async {
    final imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      if (type == 'Profile') {
        profileFile = File(imageFile!.path);
      } else {
        imgFile = File(imageFile!.path);
      }
      uploadImageToFirebase(context, type);
    });
  }

  getDatas() {
    if (widget.chit.chitName != null) {
      members = widget.chit.membersCount ?? 10;
      private = widget.chit.private ?? false;
      chitName.text = widget.chit.chitName ?? '';
      dropdownValue = widget.chit.commission;
      amount.text = widget.chit.amount.toString() ?? '';
      duration.text =
          widget.chit.duration == null ? '' : widget.chit.duration!.toString();
      subscriptionAmount.text = widget.chit.subscriptionAmount == null
          ? ''
          : widget.chit.subscriptionAmount.toString();
      dividend.text = widget.chit.dividendAmount == null
          ? ''
          : widget.chit.dividendAmount!.toString();
      drawTypeValue = widget.chit.chitType;
      if (drawTypeValue == 'Weekly') {
        for (int i = 0; i < 7; i++) {
          drawDate.add((i + 1).toString());
        }
      } else {
        for (int i = 0; i < 31; i++) {
          drawDate.add((i + 1).toString());
        }
      }
      drawDateValue = widget.chit.chitDate.toString() ?? '';
      profile = widget.chit.profile ?? '';
      fileUrl = widget.chit.document ?? '';
      selectedTime = TimeOfDay(
          hour: int.parse(widget.chit.chitTime!.split(':')[0]),
          minute: int.parse(widget.chit.chitTime!.split(':')[1]));
//TimeOfDay(hour: 15, minute: 0); // 3:00pm
      print(url);
      print('hehe');
      print(profile);
      setState(() {});
    }
  }

  @override
  void initState() {
    chitNameFocus.addListener(() {
      setState(() {});
    });
    valueAmountFocus.addListener(() {
      setState(() {});
    });
    durationFocus.addListener(() {
      setState(() {});
    });
    subscriptionAmountFocus.addListener(() {
      setState(() {});
    });
    dividentAmountFocus.addListener(() {
      setState(() {});
    });
    super.initState();
    getDatas();
  }

  void dispose() {
    _privateOrPublicChitpageController.dispose();
    _drawnOrAuctionpageController.dispose();
    chitNameFocus.dispose();
    valueAmountFocus.dispose();
    durationFocus.dispose();
    subscriptionAmountFocus.dispose();
    dividentAmountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, 4),
                    blurRadius: 25),
              ]),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    // color: Colors.red,
                    width: 13,
                    height: 12,
                    padding: EdgeInsets.all(scrWidth * 0.056),
                    child: SvgPicture.asset(
                      'assets/icons/back.svg',
                      width: 13,
                      height: 11,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text(
                  "Create New Chit",
                  style: TextStyle(
                      fontSize: FontSize17,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding15,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: scrWidth,
                    height: scrWidth * 0.15,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              chitTabBarIndex = 0;
                              private = false;
                              if (chitTabBarIndex != 0) {
                                drawnOrAuctionTabBarIndex = 0;
                              }
                            });
                            _privateOrPublicChitpageController
                                .jumpToPage(chitTabBarIndex);
                          },
                          child: Container(
                            width: scrWidth * 0.445,
                            // width: 160,
                            height: scrWidth * 0.1,
                            decoration: BoxDecoration(
                              color: chitTabBarIndex == 0
                                  ? tabBarColor
                                  : Colors.white.withOpacity(0),
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.052),
                              border: Border.all(
                                color: chitTabBarIndex == 0
                                    ? Colors.black.withOpacity(0)
                                    : Colors.black.withOpacity(0.06),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Public Chit",
                                style: TextStyle(
                                  color: chitTabBarIndex == 0
                                      ? Colors.white
                                      : Color(0xffB3B3B3),
                                  fontSize: FontSize14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              chitTabBarIndex = 1;
                              private = true;
                              if (chitTabBarIndex != 0) {
                                drawnOrAuctionTabBarIndex = 0;
                              }
                            });
                            _privateOrPublicChitpageController
                                .jumpToPage(chitTabBarIndex);
                          },
                          child: Container(
                            width: scrWidth * 0.445,
                            // width: 160,
                            height: scrWidth * 0.1,
                            decoration: BoxDecoration(
                              color: chitTabBarIndex == 1
                                  ? tabBarColor
                                  : Colors.white.withOpacity(0),
                              borderRadius:
                                  BorderRadius.circular(scrWidth * 0.052),
                              border: Border.all(
                                color: chitTabBarIndex == 1
                                    ? Colors.black.withOpacity(0)
                                    : Colors.black.withOpacity(0.06),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Private Chit",
                                style: TextStyle(
                                  color: chitTabBarIndex == 1
                                      ? Colors.white
                                      : Color(0xffB3B3B3),
                                  fontSize: FontSize14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.grey[200],
                    height: scrWidth * 1.73,
                    width: scrWidth,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _privateOrPublicChitpageController,
                      children: [
                        //PublicChit
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: scrWidth,
                                // color: Colors.red,
                                height: scrWidth * 0.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: textFormFieldWidth280,
                                        height: textFormFieldHeight45,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: scrWidth * 0.015,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                            color: textFormFieldFillColor,
                                            borderRadius: BorderRadius.circular(
                                                scrWidth * 0.026)),
                                        child: TextFormField(
                                          focusNode: chitNameFocus,
                                          controller: chitName,
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
                                              labelText: 'Chit Name',
                                              labelStyle: TextStyle(
                                                color: chitNameFocus.hasFocus
                                                    ? primarycolor
                                                    : Color(0xffB0B0B0),
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                              ),
                                              prefixIcon: Container(
                                                height: scrWidth * 0.045,
                                                width: 10,
                                                padding: EdgeInsets.all(
                                                    scrWidth * 0.033),
                                                child: SvgPicture.asset(
                                                  'assets/icons/chitname.svg',
                                                  fit: BoxFit.contain,
                                                  color: chitNameFocus.hasFocus
                                                      ? primarycolor
                                                      : Color(0xffB0B0B0),
                                                ),
                                              ),
                                              fillColor: textFormFieldFillColor,
                                              filled: true,
                                              contentPadding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: scrWidth * 0.033),
                                              disabledBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: primarycolor,
                                                width: 2,
                                              ))),
                                        )),
                                    profile != ''
                                        ? InkWell(
                                            onTap: () {
                                              _pickImage('Profile');
                                            },
                                            child: CircleAvatar(
                                              radius: scrWidth * 0.06,
                                              backgroundImage:
                                                  NetworkImage(profile),
                                            ),
                                          )
                                        : profileFile != null
                                            ? InkWell(
                                                onTap: () {
                                                  _pickImage('Profile');
                                                },
                                                child: CircleAvatar(
                                                  radius: scrWidth * 0.06,
                                                  backgroundImage:
                                                      FileImage(profileFile),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  _pickImage('Profile');
                                                },
                                                child: SvgPicture.asset(
                                                  "assets/icons/camera.svg",
                                                  height: scrWidth * 0.06,
                                                  width: scrWidth * 0.08,
                                                  // height: 21,
                                                  // width: 25,
                                                ),
                                              )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.051,
                                        right: scrWidth * 0.04),
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: scrWidth * 0.07,
                                      ),
                                      iconDisabledColor: Color(0xff908F8F),
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: Container(
                                        // width: 110,
                                        width: scrWidth * 0.6,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector (8).svg',
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "Commission",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: dropdownValue,
                                      onChanged: (value) {
                                        dropdownValue = value.toString();
                                        setState(() {});
                                      },
                                      items: dropDownList
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: padding15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: scrWidth * 0.052,
                                          width: scrWidth * 0.052,
                                          child: SvgPicture.asset(
                                            'assets/icons/Vector (9).svg',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          width: scrWidth * 0.23,
                                          height: scrWidth * 0.08,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (members > 1) {
                                                    members -= 1;
                                                  }
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: scrWidth * 0.07,
                                                  height: scrWidth * 0.065,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff28B446),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.026),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "-",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: FontSize17,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                members.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize14,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  members += 1;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: scrWidth * 0.07,
                                                  height: scrWidth * 0.065,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff28B446),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.026),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "+",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: FontSize17,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: scrWidth * 0.04,
                              ),
                              Container(
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: valueAmountFocus,
                                  controller: amount,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'Value Amount',
                                    labelStyle: TextStyle(
                                      color: valueAmountFocus.hasFocus
                                          ? primarycolor
                                          : Color(0xffB0B0B0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/value.svg',
                                        fit: BoxFit.contain,
                                        color: valueAmountFocus.hasFocus
                                            ? primarycolor
                                            : Color(0xffB0B0B0),
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.04,
                              ),
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: durationFocus,
                                  controller: duration,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'Duration (in Month)',
                                    labelStyle: TextStyle(
                                      color: durationFocus.hasFocus
                                          ? primarycolor
                                          : textFormUnFocusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/duration.svg',
                                        fit: BoxFit.contain,
                                        color: durationFocus.hasFocus
                                            ? primarycolor
                                            : textFormUnFocusColor,
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.04,
                              ),
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: subscriptionAmountFocus,
                                  controller: subscriptionAmount,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'Subscription Amount',
                                    labelStyle: TextStyle(
                                      color: subscriptionAmountFocus.hasFocus
                                          ? primarycolor
                                          : textFormUnFocusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/subscription.svg',
                                        fit: BoxFit.contain,
                                        color: subscriptionAmountFocus.hasFocus
                                            ? primarycolor
                                            : textFormUnFocusColor,
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: dividentAmountFocus,
                                  cursorHeight: scrWidth * 0.055,
                                  controller: dividend,
                                  keyboardType: TextInputType.number,
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize15,
                                    fontFamily: 'Urbanist',
                                  ),
                                  decoration: InputDecoration(
                                    labelText:
                                        'Dividend Amount is fixed (Optional)',
                                    labelStyle: TextStyle(
                                      color: dividentAmountFocus.hasFocus
                                          ? primarycolor
                                          : textFormUnFocusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/subscription.svg',
                                        fit: BoxFit.contain,
                                        color: dividentAmountFocus.hasFocus
                                            ? primarycolor
                                            : textFormUnFocusColor,
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //DRAW TYPE
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.051,
                                        right: scrWidth * 0.04),
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: scrWidth * 0.07,
                                      ),
                                      iconDisabledColor: Color(0xff908F8F),
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: Container(
                                        // width: 110,
                                        width: scrWidth * 0.6,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector (8).svg',
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "Draw Type",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: drawTypeValue,
                                      onChanged: (value) {
                                        drawTypeValue = value.toString();
                                        drawDateValue = null;
                                        print(value);
                                        drawDate = [];
                                        if (drawTypeValue == 'Weekly') {
                                          for (int i = 0; i < 7; i++) {
                                            drawDate.add((i + 1).toString());
                                          }
                                        } else {
                                          for (int i = 0; i < 31; i++) {
                                            drawDate.add((i + 1).toString());
                                          }
                                        }
                                        setState(() {});
                                      },
                                      items: drawType
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),

                                  //DRAW DATE
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.051,
                                        right: scrWidth * 0.04),
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: scrWidth * 0.07,
                                      ),
                                      iconDisabledColor: Color(0xff908F8F),
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: Container(
                                        // width: 110,
                                        width: scrWidth * 0.6,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector (8).svg',
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "Draw Date",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: drawDateValue,
                                      onChanged: (value) {
                                        drawDateValue = value.toString();
                                        print(drawDateValue);

                                        print(value);
                                        setState(() {});
                                      },
                                      items: drawDate
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),

                                  // //DatePicker
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     _selectDate(context);
                                  //     print(selectedTime!.hour);
                                  //     print(selectedTime!.minute);
                                  //     print(selectedDate);
                                  //     print(selectedDate!.weekday);
                                  //   },
                                  //   child: Container(
                                  //     // color: Colors.pink,
                                  //     width: scrWidth * 0.44,
                                  //     // width: 160,
                                  //     height: textFormFieldHeight45,
                                  //     decoration: BoxDecoration(
                                  //       color: textFormFieldFillColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(
                                  //               scrWidth * 0.033),
                                  //     ),
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: padding15),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceAround,
                                  //       children: [
                                  //         Text(
                                  //           selectedDate == null
                                  //               ? "Drawn Date"
                                  //               : DateFormat.yMMMd()
                                  //                   .format(
                                  //                       selectedDate!),
                                  //           // "${selectedDate?.toLocal()}"
                                  //           //     .split(' ')[0],
                                  //           style: TextStyle(
                                  //             color: selectedDate == null
                                  //                 ? Color(0xffB0B0B0)
                                  //                 : Colors.black,
                                  //             fontSize: FontSize14,
                                  //             fontFamily: 'Urbanist',
                                  //             fontWeight: FontWeight.w600,
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           width: scrWidth * 0.04,
                                  //         ),
                                  //         SvgPicture.asset(
                                  //           'assets/icons/date.svg',
                                  //           color: Color(0xffB0B0B0),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // //TimePicker
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     _selectTime(context);
                                  //     print(selectedTime);
                                  //     print(selectedDate);
                                  //   },
                                  //   child: Container(
                                  //     // color: Colors.pink,
                                  //     width: scrWidth * 0.44,
                                  //     // width: 160,
                                  //     height: textFormFieldHeight45,
                                  //     decoration: BoxDecoration(
                                  //       color: textFormFieldFillColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(
                                  //               scrWidth * 0.033),
                                  //     ),
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: padding15),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceAround,
                                  //       children: [
                                  //         Text(
                                  //           selectedTime == null
                                  //               ? "Drawn Time"
                                  //               : "${selectedTime!.hour.toString()}: ",
                                  //           style: TextStyle(
                                  //             color: selectedTime == null
                                  //                 ? Color(0xffB0B0B0)
                                  //                 : Colors.black,
                                  //             fontSize: FontSize14,
                                  //             fontFamily: 'Urbanist',
                                  //             fontWeight: FontWeight.w600,
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           width: scrWidth * 0.04,
                                  //         ),
                                  //         SvgPicture.asset(
                                  //           'assets/icons/time.svg',
                                  //           color: Color(0xffB0B0B0),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(context);
                                  print(selectedTime.toString());
                                },
                                child: Container(
                                  // color: Colors.pink,
                                  width: scrWidth * 0.44,
                                  // width: 160,
                                  height: textFormFieldHeight45,
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: padding15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        selectedTime == null
                                            ? "Draw Time"
                                            : "${selectedTime!.hour == 0 ? 12 : selectedTime!.hour}: ${selectedTime!.minute.toString().length == 1 ? '0${selectedTime!.minute.toString()}' : selectedTime!.minute.toString()}",
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

                              SizedBox(
                                height: scrWidth * 0.02,
                              ),

                              Text(
                                "First drawn date & time will remains for upcoming drawn dates.",
                                style: TextStyle(
                                  color: Color(0xff827E7E),
                                  fontSize: FontSize10,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              (fileUrl != '' || fileUrl != null)
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Documents Uploaded",
                                          style: TextStyle(
                                            fontSize: FontSize15,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w500,
                                            color: primarycolor,
                                          ),
                                        ),
                                        SizedBox(width: scrWidth * 0.01),
                                        SizedBox(
                                          child: SvgPicture.asset(
                                            'assets/icons/uploaded.svg',
                                            color: primarycolor,
                                          ),
                                        )
                                      ],
                                    )
                                  : pickFile == null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Upload Documents",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff8391A1),
                                              ),
                                            ),
                                            SizedBox(width: scrWidth * 0.01),
                                            SizedBox(
                                              child: SvgPicture.asset(
                                                'assets/icons/uploaded.svg',
                                                color: Color(0xff8391A1),
                                              ),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Documents Uploaded",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                                color: primarycolor,
                                              ),
                                            ),
                                            SizedBox(width: scrWidth * 0.01),
                                            SizedBox(
                                              child: SvgPicture.asset(
                                                'assets/icons/uploaded.svg',
                                                color: primarycolor,
                                              ),
                                            )
                                          ],
                                        ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),

                              InkWell(
                                onTap: () {
                                  _pickFile();
                                },
                                child: (fileUrl != '' || fileUrl != null)
                                    ? Container(
                                        width: scrWidth,
                                        height: textFormFieldHeight45,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: scrWidth * 0.04,
                                          vertical: scrHeight * 0.015,
                                        ),
                                        decoration: BoxDecoration(
                                          color: textFormFieldFillColor,
                                          border: Border.all(
                                            color: Color(0xffDADADA),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              scrWidth * 0.026),
                                        ),
                                        child: Text(
                                          fileName ?? '',
                                          style: TextStyle(
                                            color: Color(0xff8391A1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: FontSize15,
                                            fontFamily: 'Urbanist',
                                          ),
                                        ),
                                      )
                                    : pickFile == null
                                        ? Container(
                                            width: scrWidth,
                                            height: textFormFieldHeight45,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: scrWidth * 0.015,
                                              vertical: scrHeight * 0.002,
                                            ),
                                            decoration: BoxDecoration(
                                              color: textFormFieldFillColor,
                                              border: Border.all(
                                                color: Color(0xffDADADA),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.026),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: scrHeight * 0.03),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Upload Documents",
                                                    style: TextStyle(
                                                      color: Color(0xff8391A1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: FontSize15,
                                                      fontFamily: 'Urbanist',
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/icons/camera2.svg',
                                                    color: Color(0xff8391A1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: scrWidth,
                                            height: textFormFieldHeight45,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: scrWidth * 0.04,
                                              vertical: scrHeight * 0.015,
                                            ),
                                            decoration: BoxDecoration(
                                              color: textFormFieldFillColor,
                                              border: Border.all(
                                                color: Color(0xffDADADA),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.026),
                                            ),
                                            child: Text(
                                              fileName!,
                                              style: TextStyle(
                                                color: Color(0xff8391A1),
                                                fontWeight: FontWeight.w500,
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                              ),
                                            ),
                                          ),
                              ),
                              // Container(
                              //   width: scrWidth,
                              //   height: scrWidth * 0.15,
                              //   // color: Colors.red,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             drawnOrAuctionTabBarIndex = 0;
                              //             draw = true;
                              //           });
                              //           _drawnOrAuctionpageController
                              //               .jumpToPage(drawnOrAuctionTabBarIndex);
                              //         },
                              //         child: Container(
                              //           width: scrWidth * 0.445,
                              //           // width: 160,
                              //           height: scrWidth * 0.1,
                              //           decoration: BoxDecoration(
                              //             color: drawnOrAuctionTabBarIndex == 0
                              //                 ? tabBarColor
                              //                 : Colors.white.withOpacity(0),
                              //             borderRadius: BorderRadius.circular(
                              //                 scrWidth * 0.052),
                              //             border: Border.all(
                              //               color: drawnOrAuctionTabBarIndex == 0
                              //                   ? Colors.black.withOpacity(0)
                              //                   : Colors.black.withOpacity(0.06),
                              //             ),
                              //           ),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             children: [
                              //               SvgPicture.asset(
                              //                 'assets/icons/drawn.svg',
                              //                 color: drawnOrAuctionTabBarIndex == 0
                              //                     ? Colors.white
                              //                     : Color(0xffB3B3B3),
                              //               ),
                              //               SizedBox(
                              //                 width: scrWidth * 0.04,
                              //               ),
                              //               Text(
                              //                 "Drawn",
                              //                 style: TextStyle(
                              //                   color:
                              //                       drawnOrAuctionTabBarIndex == 0
                              //                           ? Colors.white
                              //                           : Color(0xffB3B3B3),
                              //                   fontSize: FontSize14,
                              //                   fontFamily: 'Urbanist',
                              //                   fontWeight: FontWeight.w600,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             drawnOrAuctionTabBarIndex = 1;
                              //             draw = false;
                              //           });
                              //           _drawnOrAuctionpageController
                              //               .jumpToPage(drawnOrAuctionTabBarIndex);
                              //         },
                              //         child: Container(
                              //           width: scrWidth * 0.445,
                              //           // width: 160,
                              //           height: scrWidth * 0.1,
                              //           decoration: BoxDecoration(
                              //             color: drawnOrAuctionTabBarIndex == 1
                              //                 ? tabBarColor
                              //                 : Colors.white.withOpacity(0),
                              //             borderRadius: BorderRadius.circular(
                              //                 scrWidth * 0.052),
                              //             border: Border.all(
                              //               color: drawnOrAuctionTabBarIndex == 1
                              //                   ? Colors.black.withOpacity(0)
                              //                   : Colors.black.withOpacity(0.06),
                              //             ),
                              //           ),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             children: [
                              //               SvgPicture.asset(
                              //                 'assets/icons/members.svg',
                              //                 color: drawnOrAuctionTabBarIndex == 1
                              //                     ? Colors.white
                              //                     : Color(0xffB3B3B3),
                              //               ),
                              //               SizedBox(
                              //                 width: scrWidth * 0.04,
                              //               ),
                              //               Text(
                              //                 "Auction",
                              //                 style: TextStyle(
                              //                   color:
                              //                       drawnOrAuctionTabBarIndex == 1
                              //                           ? Colors.white
                              //                           : Color(0xffB3B3B3),
                              //                   fontSize: FontSize14,
                              //                   fontFamily: 'Urbanist',
                              //                   fontWeight: FontWeight.w600,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   // color: Colors.red[200],
                              //   height: scrWidth * .62,
                              //   width: scrWidth,
                              //   child: PageView(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     controller: _drawnOrAuctionpageController,
                              //     children: [
                              //       //Drawn
                              //       Column(
                              //         mainAxisAlignment: MainAxisAlignment.start,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           Container(
                              //             width: scrWidth,
                              //             height: textFormFieldHeight45,
                              //             padding: EdgeInsets.symmetric(
                              //               horizontal: scrWidth * 0.015,
                              //               vertical: 2,
                              //             ),
                              //             decoration: BoxDecoration(
                              //               color: textFormFieldFillColor,
                              //               borderRadius: BorderRadius.circular(
                              //                   scrWidth * 0.026),
                              //             ),
                              //             child: TextFormField(
                              //               focusNode: dividentAmountFocus,
                              //               cursorHeight: scrWidth * 0.055,
                              //               controller: dividend,
                              //               keyboardType: TextInputType.number,
                              //               cursorWidth: 1,
                              //               cursorColor: Colors.black,
                              //               style: TextStyle(
                              //                 color: Colors.black,
                              //                 fontWeight: FontWeight.w600,
                              //                 fontSize: FontSize15,
                              //                 fontFamily: 'Urbanist',
                              //               ),
                              //               decoration: InputDecoration(
                              //                 labelText:
                              //                     'Dividend Amount is fixed (Optional)',
                              //                 labelStyle: TextStyle(
                              //                   color: dividentAmountFocus.hasFocus
                              //                       ? primarycolor
                              //                       : textFormUnFocusColor,
                              //                   fontWeight: FontWeight.w600,
                              //                   fontSize: FontSize15,
                              //                   fontFamily: 'Urbanist',
                              //                 ),
                              //                 prefixIcon: Container(
                              //                   height: scrWidth * 0.045,
                              //                   width: 10,
                              //                   padding: EdgeInsets.all(
                              //                       scrWidth * 0.033),
                              //                   child: SvgPicture.asset(
                              //                     'assets/icons/subscription.svg',
                              //                     fit: BoxFit.contain,
                              //                     color:
                              //                         dividentAmountFocus.hasFocus
                              //                             ? primarycolor
                              //                             : textFormUnFocusColor,
                              //                   ),
                              //                 ),
                              //                 fillColor: textFormFieldFillColor,
                              //                 filled: true,
                              //                 contentPadding: EdgeInsets.only(
                              //                     top: 5, bottom: scrWidth * 0.033),
                              //                 disabledBorder: InputBorder.none,
                              //                 enabledBorder: InputBorder.none,
                              //                 errorBorder: InputBorder.none,
                              //                 border: InputBorder.none,
                              //                 focusedBorder: UnderlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: primarycolor,
                              //                     width: 2,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.03,
                              //           ),
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               //DRAW TYPE
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.445,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.only(
                              //                     left: scrWidth * 0.051,
                              //                     right: scrWidth * 0.04),
                              //                 child: DropdownButton(
                              //                   icon: Icon(
                              //                     Icons.arrow_drop_down_rounded,
                              //                     size: scrWidth * 0.07,
                              //                   ),
                              //                   iconDisabledColor:
                              //                       Color(0xff908F8F),
                              //                   underline: Container(),
                              //                   isExpanded: true,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                   style: TextStyle(
                              //                     fontSize: FontSize15,
                              //                     fontFamily: 'Urbanist',
                              //                     color: Colors.black,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                   hint: Container(
                              //                     // width: 110,
                              //                     width: scrWidth * 0.6,
                              //                     // color: Colors.red,
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       children: [
                              //                         SvgPicture.asset(
                              //                           'assets/icons/Vector (8).svg',
                              //                           fit: BoxFit.contain,
                              //                         ),
                              //                         Text(
                              //                           "Draw Type",
                              //                           style: TextStyle(
                              //                             fontSize: FontSize15,
                              //                             fontFamily: 'Urbanist',
                              //                             fontWeight:
                              //                                 FontWeight.w600,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   value: drawTypeValue,
                              //                   onChanged: (value) {
                              //                     drawTypeValue = value.toString();
                              //                     print(value);
                              //                     drawDate = [];
                              //                     if (drawTypeValue == 'Weekly') {
                              //                       for (int i = 0; i < 7; i++) {
                              //                         drawDate
                              //                             .add((i + 1).toString());
                              //                       }
                              //                     } else {
                              //                       for (int i = 0; i < 31; i++) {
                              //                         drawDate
                              //                             .add((i + 1).toString());
                              //                       }
                              //                     }
                              //                     setState(() {});
                              //                   },
                              //                   items: drawType
                              //                       .map(
                              //                         (value) => DropdownMenuItem(
                              //                           value: value,
                              //                           child:
                              //                               Text(value.toString()),
                              //                         ),
                              //                       )
                              //                       .toList(),
                              //                 ),
                              //               ),
                              //
                              //               //DRAW DATE
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.445,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.only(
                              //                     left: scrWidth * 0.051,
                              //                     right: scrWidth * 0.04),
                              //                 child: DropdownButton(
                              //                   icon: Icon(
                              //                     Icons.arrow_drop_down_rounded,
                              //                     size: scrWidth * 0.07,
                              //                   ),
                              //                   iconDisabledColor:
                              //                       Color(0xff908F8F),
                              //                   underline: Container(),
                              //                   isExpanded: true,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                   style: TextStyle(
                              //                     fontSize: FontSize15,
                              //                     fontFamily: 'Urbanist',
                              //                     color: Colors.black,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                   hint: Container(
                              //                     // width: 110,
                              //                     width: scrWidth * 0.6,
                              //                     // color: Colors.red,
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       children: [
                              //                         SvgPicture.asset(
                              //                           'assets/icons/Vector (8).svg',
                              //                           fit: BoxFit.contain,
                              //                         ),
                              //                         Text(
                              //                           "Draw Date",
                              //                           style: TextStyle(
                              //                             fontSize: FontSize15,
                              //                             fontFamily: 'Urbanist',
                              //                             fontWeight:
                              //                                 FontWeight.w600,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   value: drawDateValue,
                              //                   onChanged: (value) {
                              //                     drawDateValue = value.toString();
                              //                     print(drawDateValue);
                              //
                              //                     print(value);
                              //                     setState(() {});
                              //                   },
                              //                   items: drawDate
                              //                       .map(
                              //                         (value) => DropdownMenuItem(
                              //                           value: value,
                              //                           child:
                              //                               Text(value.toString()),
                              //                         ),
                              //                       )
                              //                       .toList(),
                              //                 ),
                              //               ),
                              //
                              //               // //DatePicker
                              //               // GestureDetector(
                              //               //   onTap: () {
                              //               //     _selectDate(context);
                              //               //     print(selectedTime!.hour);
                              //               //     print(selectedTime!.minute);
                              //               //     print(selectedDate);
                              //               //     print(selectedDate!.weekday);
                              //               //   },
                              //               //   child: Container(
                              //               //     // color: Colors.pink,
                              //               //     width: scrWidth * 0.44,
                              //               //     // width: 160,
                              //               //     height: textFormFieldHeight45,
                              //               //     decoration: BoxDecoration(
                              //               //       color: textFormFieldFillColor,
                              //               //       borderRadius:
                              //               //           BorderRadius.circular(
                              //               //               scrWidth * 0.033),
                              //               //     ),
                              //               //     padding: EdgeInsets.symmetric(
                              //               //         horizontal: padding15),
                              //               //     child: Row(
                              //               //       mainAxisAlignment:
                              //               //           MainAxisAlignment.spaceAround,
                              //               //       children: [
                              //               //         Text(
                              //               //           selectedDate == null
                              //               //               ? "Drawn Date"
                              //               //               : DateFormat.yMMMd()
                              //               //                   .format(
                              //               //                       selectedDate!),
                              //               //           // "${selectedDate?.toLocal()}"
                              //               //           //     .split(' ')[0],
                              //               //           style: TextStyle(
                              //               //             color: selectedDate == null
                              //               //                 ? Color(0xffB0B0B0)
                              //               //                 : Colors.black,
                              //               //             fontSize: FontSize14,
                              //               //             fontFamily: 'Urbanist',
                              //               //             fontWeight: FontWeight.w600,
                              //               //           ),
                              //               //         ),
                              //               //         SizedBox(
                              //               //           width: scrWidth * 0.04,
                              //               //         ),
                              //               //         SvgPicture.asset(
                              //               //           'assets/icons/date.svg',
                              //               //           color: Color(0xffB0B0B0),
                              //               //         ),
                              //               //       ],
                              //               //     ),
                              //               //   ),
                              //               // ),
                              //               // //TimePicker
                              //               // GestureDetector(
                              //               //   onTap: () {
                              //               //     _selectTime(context);
                              //               //     print(selectedTime);
                              //               //     print(selectedDate);
                              //               //   },
                              //               //   child: Container(
                              //               //     // color: Colors.pink,
                              //               //     width: scrWidth * 0.44,
                              //               //     // width: 160,
                              //               //     height: textFormFieldHeight45,
                              //               //     decoration: BoxDecoration(
                              //               //       color: textFormFieldFillColor,
                              //               //       borderRadius:
                              //               //           BorderRadius.circular(
                              //               //               scrWidth * 0.033),
                              //               //     ),
                              //               //     padding: EdgeInsets.symmetric(
                              //               //         horizontal: padding15),
                              //               //     child: Row(
                              //               //       mainAxisAlignment:
                              //               //           MainAxisAlignment.spaceAround,
                              //               //       children: [
                              //               //         Text(
                              //               //           selectedTime == null
                              //               //               ? "Drawn Time"
                              //               //               : "${selectedTime!.hour.toString()}: ",
                              //               //           style: TextStyle(
                              //               //             color: selectedTime == null
                              //               //                 ? Color(0xffB0B0B0)
                              //               //                 : Colors.black,
                              //               //             fontSize: FontSize14,
                              //               //             fontFamily: 'Urbanist',
                              //               //             fontWeight: FontWeight.w600,
                              //               //           ),
                              //               //         ),
                              //               //         SizedBox(
                              //               //           width: scrWidth * 0.04,
                              //               //         ),
                              //               //         SvgPicture.asset(
                              //               //           'assets/icons/time.svg',
                              //               //           color: Color(0xffB0B0B0),
                              //               //         ),
                              //               //       ],
                              //               //     ),
                              //               //   ),
                              //               // ),
                              //             ],
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           GestureDetector(
                              //             onTap: () {
                              //               _selectTime(context);
                              //               print(selectedTime.toString());
                              //
                              //             },
                              //             child: Container(
                              //               // color: Colors.pink,
                              //               width: scrWidth * 0.44,
                              //               // width: 160,
                              //               height: textFormFieldHeight45,
                              //               decoration: BoxDecoration(
                              //                 color: textFormFieldFillColor,
                              //                 borderRadius: BorderRadius.circular(
                              //                     scrWidth * 0.033),
                              //               ),
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: padding15),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.spaceAround,
                              //                 children: [
                              //                   Text(
                              //                     selectedTime == null
                              //                         ? "Draw Time"
                              //                         : "${selectedTime!.hour.toString()}: ${selectedTime!.minute.toString()}",
                              //                     style: TextStyle(
                              //                       color: selectedTime == null
                              //                           ? Color(0xffB0B0B0)
                              //                           : Colors.black,
                              //                       fontSize: FontSize14,
                              //                       fontFamily: 'Urbanist',
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: scrWidth * 0.04,
                              //                   ),
                              //                   SvgPicture.asset(
                              //                     'assets/icons/time.svg',
                              //                     color: Color(0xffB0B0B0),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           Text(
                              //             "First drawn date & time will remains for upcoming drawn dates.",
                              //             style: TextStyle(
                              //               color: Color(0xff827E7E),
                              //               fontSize: FontSize10,
                              //               fontFamily: 'Urbanist',
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.04,
                              //           ),
                              //           DottedBorder(
                              //             padding: EdgeInsets.all(0),
                              //             borderType: BorderType.RRect,
                              //             radius: Radius.circular(12),
                              //             color: Color(0xffDADADA),
                              //             strokeWidth: 1,
                              //             child: Container(
                              //               height: 73,
                              //               width: 336,
                              //               decoration: BoxDecoration(
                              //                 color: Color(0xffF7F8F9),
                              //                 borderRadius:
                              //                     BorderRadius.circular(12),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   SvgPicture.asset(
                              //                     "assets/icons/docCam.svg",
                              //                     height: scrWidth * 0.06,
                              //                     width: scrWidth * 0.08,
                              //                     color: Color(0xff8391A1),
                              //                     // height: 21,
                              //                     // width: 25,
                              //                   ),
                              //                   SizedBox(
                              //                     width: scrWidth * 0.04,
                              //                   ),
                              //                   Text(
                              //                     "Upload Documents",
                              //                     style: TextStyle(
                              //                       color: Color(0xffB0B0B0),
                              //                       fontSize: FontSize15,
                              //                       fontFamily: 'Urbanist',
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       //Auction
                              //       Column(
                              //         mainAxisAlignment: MainAxisAlignment.start,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.44,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: padding15),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceAround,
                              //                   children: [
                              //                     Text(
                              //                       "Auction Date",
                              //                       style: TextStyle(
                              //                         color: Color(0xffB0B0B0),
                              //                         fontSize: FontSize14,
                              //                         fontFamily: 'Urbanist',
                              //                         fontWeight: FontWeight.w600,
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       width: scrWidth * 0.04,
                              //                     ),
                              //                     SvgPicture.asset(
                              //                       'assets/icons/date.svg',
                              //                       color: Color(0xffB0B0B0),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.44,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: padding15),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceAround,
                              //                   children: [
                              //                     Text(
                              //                       "Auction Time",
                              //                       style: TextStyle(
                              //                         color: Color(0xffB0B0B0),
                              //                         fontSize: FontSize14,
                              //                         fontFamily: 'Urbanist',
                              //                         fontWeight: FontWeight.w600,
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       width: scrWidth * 0.04,
                              //                     ),
                              //                     SvgPicture.asset(
                              //                       'assets/icons/time.svg',
                              //                       color: Color(0xffB0B0B0),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.01,
                              //           ),
                              //           Text(
                              //             "First Auction date & time will remains for upcoming auction dates.",
                              //             style: TextStyle(
                              //               color: Color(0xff827E7E),
                              //               fontSize: FontSize10,
                              //               fontFamily: 'Urbanist',
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.04,
                              //           ),
                              //           DottedBorder(
                              //             borderType: BorderType.RRect,
                              //             radius: Radius.circular(12),
                              //             color: Color(0xffDADADA),
                              //             strokeWidth: 1,
                              //             child: Container(
                              //               height: 73,
                              //               width: 336,
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(12),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   SvgPicture.asset(
                              //                     "assets/icons/docCam.svg",
                              //                     height: scrWidth * 0.06,
                              //                     width: scrWidth * 0.08,
                              //                     color: Color(0xff8391A1),
                              //                     // height: 21,
                              //                     // width: 25,
                              //                   ),
                              //                   SizedBox(
                              //                     width: scrWidth * 0.04,
                              //                   ),
                              //                   Text(
                              //                     "Upload Documents",
                              //                     style: TextStyle(
                              //                       color: Color(0xffB0B0B0),
                              //                       fontSize: FontSize15,
                              //                       fontFamily: 'Urbanist',
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        //PRIVATE CHIT
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: scrWidth,
                                // color: Colors.red,
                                height: scrWidth * 0.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: textFormFieldWidth280,
                                        height: textFormFieldHeight45,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: scrWidth * 0.015,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                            color: textFormFieldFillColor,
                                            borderRadius: BorderRadius.circular(
                                                scrWidth * 0.026)),
                                        child: TextFormField(
                                          focusNode: chitNameFocus,
                                          controller: chitName,
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
                                              labelText: 'Chit Name',
                                              labelStyle: TextStyle(
                                                color: chitNameFocus.hasFocus
                                                    ? primarycolor
                                                    : Color(0xffB0B0B0),
                                                fontWeight: FontWeight.w600,
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                              ),
                                              prefixIcon: Container(
                                                height: scrWidth * 0.045,
                                                width: 10,
                                                padding: EdgeInsets.all(
                                                    scrWidth * 0.033),
                                                child: SvgPicture.asset(
                                                  'assets/icons/chitname.svg',
                                                  fit: BoxFit.contain,
                                                  color: chitNameFocus.hasFocus
                                                      ? primarycolor
                                                      : Color(0xffB0B0B0),
                                                ),
                                              ),
                                              fillColor: textFormFieldFillColor,
                                              filled: true,
                                              contentPadding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: scrWidth * 0.033),
                                              disabledBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: primarycolor,
                                                width: 2,
                                              ))),
                                        )),
                                    profile != ''
                                        ? InkWell(
                                            onTap: () {
                                              _pickImage('Profile');
                                            },
                                            child: CircleAvatar(
                                              radius: scrWidth * 0.06,
                                              backgroundImage:
                                                  NetworkImage(profile),
                                            ),
                                          )
                                        : profileFile != null
                                            ? InkWell(
                                                onTap: () {
                                                  _pickImage('Profile');
                                                },
                                                child: CircleAvatar(
                                                  radius: scrWidth * 0.06,
                                                  backgroundImage:
                                                      FileImage(profileFile),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  _pickImage('Profile');
                                                },
                                                child: SvgPicture.asset(
                                                  "assets/icons/camera.svg",
                                                  height: scrWidth * 0.06,
                                                  width: scrWidth * 0.08,
                                                  // height: 21,
                                                  // width: 25,
                                                ),
                                              )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.051,
                                        right: scrWidth * 0.04),
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: scrWidth * 0.07,
                                      ),
                                      iconDisabledColor: Color(0xff908F8F),
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: Container(
                                        // width: 110,
                                        width: scrWidth * 0.6,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector (8).svg',
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "Commission",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: dropdownValue,
                                      onChanged: (value) {
                                        dropdownValue = value.toString();
                                        setState(() {});
                                      },
                                      items: dropDownList
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: padding15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: scrWidth * 0.052,
                                          width: scrWidth * 0.052,
                                          child: SvgPicture.asset(
                                            'assets/icons/Vector (9).svg',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          width: scrWidth * 0.23,
                                          height: scrWidth * 0.08,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (members > 1) {
                                                    members -= 1;
                                                  }
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: scrWidth * 0.07,
                                                  height: scrWidth * 0.065,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff28B446),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.026),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "-",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: FontSize17,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                members.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize14,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  members += 1;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: scrWidth * 0.07,
                                                  height: scrWidth * 0.065,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff28B446),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.026),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "+",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: FontSize17,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: scrWidth * 0.04,
                              ),
                              Container(
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: valueAmountFocus,
                                  controller: amount,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'Value Amount',
                                    labelStyle: TextStyle(
                                      color: valueAmountFocus.hasFocus
                                          ? primarycolor
                                          : Color(0xffB0B0B0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/value.svg',
                                        fit: BoxFit.contain,
                                        color: valueAmountFocus.hasFocus
                                            ? primarycolor
                                            : Color(0xffB0B0B0),
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.04,
                              ),
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: durationFocus,
                                  controller: duration,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'Duration (in Month)',
                                    labelStyle: TextStyle(
                                      color: durationFocus.hasFocus
                                          ? primarycolor
                                          : textFormUnFocusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/duration.svg',
                                        fit: BoxFit.contain,
                                        color: durationFocus.hasFocus
                                            ? primarycolor
                                            : textFormUnFocusColor,
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.04,
                              ),
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: subscriptionAmountFocus,
                                  controller: subscriptionAmount,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'Subscription Amount',
                                    labelStyle: TextStyle(
                                      color: subscriptionAmountFocus.hasFocus
                                          ? primarycolor
                                          : textFormUnFocusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/subscription.svg',
                                        fit: BoxFit.contain,
                                        color: subscriptionAmountFocus.hasFocus
                                            ? primarycolor
                                            : textFormUnFocusColor,
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              Container(
                                width: scrWidth,
                                height: textFormFieldHeight45,
                                padding: EdgeInsets.symmetric(
                                  horizontal: scrWidth * 0.015,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: textFormFieldFillColor,
                                  borderRadius:
                                      BorderRadius.circular(scrWidth * 0.026),
                                ),
                                child: TextFormField(
                                  focusNode: dividentAmountFocus,
                                  cursorHeight: scrWidth * 0.055,
                                  controller: dividend,
                                  keyboardType: TextInputType.number,
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize15,
                                    fontFamily: 'Urbanist',
                                  ),
                                  decoration: InputDecoration(
                                    labelText:
                                        'Dividend Amount is fixed (Optional)',
                                    labelStyle: TextStyle(
                                      color: dividentAmountFocus.hasFocus
                                          ? primarycolor
                                          : textFormUnFocusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: FontSize15,
                                      fontFamily: 'Urbanist',
                                    ),
                                    prefixIcon: Container(
                                      height: scrWidth * 0.045,
                                      width: 10,
                                      padding: EdgeInsets.all(scrWidth * 0.033),
                                      child: SvgPicture.asset(
                                        'assets/icons/subscription.svg',
                                        fit: BoxFit.contain,
                                        color: dividentAmountFocus.hasFocus
                                            ? primarycolor
                                            : textFormUnFocusColor,
                                      ),
                                    ),
                                    fillColor: textFormFieldFillColor,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 5, bottom: scrWidth * 0.033),
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primarycolor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: scrWidth * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //DRAW TYPE
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.051,
                                        right: scrWidth * 0.04),
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: scrWidth * 0.07,
                                      ),
                                      iconDisabledColor: Color(0xff908F8F),
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: Container(
                                        // width: 110,
                                        width: scrWidth * 0.6,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector (8).svg',
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "Draw Type",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: drawTypeValue,
                                      onChanged: (value) {
                                        drawTypeValue = value.toString();
                                        print(value);
                                        drawDate = [];
                                        if (drawTypeValue == 'Weekly') {
                                          for (int i = 0; i < 7; i++) {
                                            drawDate.add((i + 1).toString());
                                          }
                                        } else {
                                          for (int i = 0; i < 31; i++) {
                                            drawDate.add((i + 1).toString());
                                          }
                                        }
                                        setState(() {});
                                      },
                                      items: drawType
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),

                                  //DRAW DATE
                                  Container(
                                    // color: Colors.pink,
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: textFormFieldHeight45,
                                    decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.051,
                                        right: scrWidth * 0.04),
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: scrWidth * 0.07,
                                      ),
                                      iconDisabledColor: Color(0xff908F8F),
                                      underline: Container(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.033),
                                      style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hint: Container(
                                        // width: 110,
                                        width: scrWidth * 0.6,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector (8).svg',
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              "Draw Date",
                                              style: TextStyle(
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: drawDateValue,
                                      onChanged: (value) {
                                        drawDateValue = value.toString();
                                        print(drawDateValue);

                                        print(value);
                                        setState(() {});
                                      },
                                      items: drawDate
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString()),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),

                                  // //DatePicker
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     _selectDate(context);
                                  //     print(selectedTime!.hour);
                                  //     print(selectedTime!.minute);
                                  //     print(selectedDate);
                                  //     print(selectedDate!.weekday);
                                  //   },
                                  //   child: Container(
                                  //     // color: Colors.pink,
                                  //     width: scrWidth * 0.44,
                                  //     // width: 160,
                                  //     height: textFormFieldHeight45,
                                  //     decoration: BoxDecoration(
                                  //       color: textFormFieldFillColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(
                                  //               scrWidth * 0.033),
                                  //     ),
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: padding15),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceAround,
                                  //       children: [
                                  //         Text(
                                  //           selectedDate == null
                                  //               ? "Drawn Date"
                                  //               : DateFormat.yMMMd()
                                  //                   .format(
                                  //                       selectedDate!),
                                  //           // "${selectedDate?.toLocal()}"
                                  //           //     .split(' ')[0],
                                  //           style: TextStyle(
                                  //             color: selectedDate == null
                                  //                 ? Color(0xffB0B0B0)
                                  //                 : Colors.black,
                                  //             fontSize: FontSize14,
                                  //             fontFamily: 'Urbanist',
                                  //             fontWeight: FontWeight.w600,
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           width: scrWidth * 0.04,
                                  //         ),
                                  //         SvgPicture.asset(
                                  //           'assets/icons/date.svg',
                                  //           color: Color(0xffB0B0B0),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // //TimePicker
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     _selectTime(context);
                                  //     print(selectedTime);
                                  //     print(selectedDate);
                                  //   },
                                  //   child: Container(
                                  //     // color: Colors.pink,
                                  //     width: scrWidth * 0.44,
                                  //     // width: 160,
                                  //     height: textFormFieldHeight45,
                                  //     decoration: BoxDecoration(
                                  //       color: textFormFieldFillColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(
                                  //               scrWidth * 0.033),
                                  //     ),
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: padding15),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceAround,
                                  //       children: [
                                  //         Text(
                                  //           selectedTime == null
                                  //               ? "Drawn Time"
                                  //               : "${selectedTime!.hour.toString()}: ",
                                  //           style: TextStyle(
                                  //             color: selectedTime == null
                                  //                 ? Color(0xffB0B0B0)
                                  //                 : Colors.black,
                                  //             fontSize: FontSize14,
                                  //             fontFamily: 'Urbanist',
                                  //             fontWeight: FontWeight.w600,
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           width: scrWidth * 0.04,
                                  //         ),
                                  //         SvgPicture.asset(
                                  //           'assets/icons/time.svg',
                                  //           color: Color(0xffB0B0B0),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(context);
                                  print(selectedTime.toString());
                                },
                                child: Container(
                                  // color: Colors.pink,
                                  width: scrWidth * 0.44,
                                  // width: 160,
                                  height: textFormFieldHeight45,
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: padding15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        selectedTime == null
                                            ? "Draw Time"
                                            : "${selectedTime!.hour.toString()}: ${selectedTime!.minute.toString().length == 1 ? '0${selectedTime!.minute.toString()}' : selectedTime!.minute.toString()}",
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
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),
                              Text(
                                "First drawn date & time will remains for upcoming drawn dates.",
                                style: TextStyle(
                                  color: Color(0xff827E7E),
                                  fontSize: FontSize10,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              (fileUrl != '' || fileUrl != null)
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Documents Uploaded",
                              style: TextStyle(
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                                color: primarycolor,
                              ),
                            ),
                            SizedBox(width: scrWidth * 0.01),
                            SizedBox(
                              child: SvgPicture.asset(
                                'assets/icons/uploaded.svg',
                                color: primarycolor,
                              ),
                            )
                          ],
                        )
                            : pickFile == null
                            ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Text(
                              "Upload Documents",
                              style: TextStyle(
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                                color: Color(0xff8391A1),
                              ),
                            ),
                            SizedBox(width: scrWidth * 0.01),
                            SizedBox(
                              child: SvgPicture.asset(
                                'assets/icons/uploaded.svg',
                                color: Color(0xff8391A1),
                              ),
                            )
                          ],
                        )
                            : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Text(
                              "Documents Uploaded",
                              style: TextStyle(
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                                color: primarycolor,
                              ),
                            ),
                            SizedBox(width: scrWidth * 0.01),
                            SizedBox(
                              child: SvgPicture.asset(
                                'assets/icons/uploaded.svg',
                                color: primarycolor,
                              ),
                            )
                          ],
                        ),
                              SizedBox(
                                height: scrWidth * 0.02,
                              ),

                              InkWell(
                                onTap: () {
                                  _pickFile();
                                },
                                child: pickFile == null
                                    ? Container(
                                        width: scrWidth,
                                        height: textFormFieldHeight45,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: scrWidth * 0.015,
                                          vertical: scrHeight * 0.002,
                                        ),
                                        decoration: BoxDecoration(
                                          color: textFormFieldFillColor,
                                          border: Border.all(
                                            color: Color(0xffDADADA),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              scrWidth * 0.026),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: scrHeight * 0.03),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Upload Documents",
                                                style: TextStyle(
                                                  color: Color(0xff8391A1),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: FontSize15,
                                                  fontFamily: 'Urbanist',
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/camera2.svg',
                                                color: Color(0xff8391A1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: scrWidth,
                                        height: textFormFieldHeight45,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: scrWidth * 0.04,
                                          vertical: scrHeight * 0.015,
                                        ),
                                        decoration: BoxDecoration(
                                          color: textFormFieldFillColor,
                                          border: Border.all(
                                            color: Color(0xffDADADA),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              scrWidth * 0.026),
                                        ),
                                        child: Text(
                                          fileName!,
                                          style: TextStyle(
                                            color: Color(0xff8391A1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: FontSize15,
                                            fontFamily: 'Urbanist',
                                          ),
                                        ),
                                      ),
                              ),
                              // Container(
                              //   width: scrWidth,
                              //   height: scrWidth * 0.15,
                              //   // color: Colors.red,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             drawnOrAuctionTabBarIndex = 0;
                              //             draw = true;
                              //           });
                              //           _drawnOrAuctionpageController
                              //               .jumpToPage(drawnOrAuctionTabBarIndex);
                              //         },
                              //         child: Container(
                              //           width: scrWidth * 0.445,
                              //           // width: 160,
                              //           height: scrWidth * 0.1,
                              //           decoration: BoxDecoration(
                              //             color: drawnOrAuctionTabBarIndex == 0
                              //                 ? tabBarColor
                              //                 : Colors.white.withOpacity(0),
                              //             borderRadius: BorderRadius.circular(
                              //                 scrWidth * 0.052),
                              //             border: Border.all(
                              //               color: drawnOrAuctionTabBarIndex == 0
                              //                   ? Colors.black.withOpacity(0)
                              //                   : Colors.black.withOpacity(0.06),
                              //             ),
                              //           ),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             children: [
                              //               SvgPicture.asset(
                              //                 'assets/icons/drawn.svg',
                              //                 color: drawnOrAuctionTabBarIndex == 0
                              //                     ? Colors.white
                              //                     : Color(0xffB3B3B3),
                              //               ),
                              //               SizedBox(
                              //                 width: scrWidth * 0.04,
                              //               ),
                              //               Text(
                              //                 "Drawn",
                              //                 style: TextStyle(
                              //                   color:
                              //                       drawnOrAuctionTabBarIndex == 0
                              //                           ? Colors.white
                              //                           : Color(0xffB3B3B3),
                              //                   fontSize: FontSize14,
                              //                   fontFamily: 'Urbanist',
                              //                   fontWeight: FontWeight.w600,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             drawnOrAuctionTabBarIndex = 1;
                              //             draw = false;
                              //           });
                              //           _drawnOrAuctionpageController
                              //               .jumpToPage(drawnOrAuctionTabBarIndex);
                              //         },
                              //         child: Container(
                              //           width: scrWidth * 0.445,
                              //           // width: 160,
                              //           height: scrWidth * 0.1,
                              //           decoration: BoxDecoration(
                              //             color: drawnOrAuctionTabBarIndex == 1
                              //                 ? tabBarColor
                              //                 : Colors.white.withOpacity(0),
                              //             borderRadius: BorderRadius.circular(
                              //                 scrWidth * 0.052),
                              //             border: Border.all(
                              //               color: drawnOrAuctionTabBarIndex == 1
                              //                   ? Colors.black.withOpacity(0)
                              //                   : Colors.black.withOpacity(0.06),
                              //             ),
                              //           ),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             children: [
                              //               SvgPicture.asset(
                              //                 'assets/icons/members.svg',
                              //                 color: drawnOrAuctionTabBarIndex == 1
                              //                     ? Colors.white
                              //                     : Color(0xffB3B3B3),
                              //               ),
                              //               SizedBox(
                              //                 width: scrWidth * 0.04,
                              //               ),
                              //               Text(
                              //                 "Auction",
                              //                 style: TextStyle(
                              //                   color:
                              //                       drawnOrAuctionTabBarIndex == 1
                              //                           ? Colors.white
                              //                           : Color(0xffB3B3B3),
                              //                   fontSize: FontSize14,
                              //                   fontFamily: 'Urbanist',
                              //                   fontWeight: FontWeight.w600,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   // color: Colors.red[200],
                              //   height: scrWidth * .62,
                              //   width: scrWidth,
                              //   child: PageView(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     controller: _drawnOrAuctionpageController,
                              //     children: [
                              //       //Drawn
                              //       Column(
                              //         mainAxisAlignment: MainAxisAlignment.start,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           Container(
                              //             width: scrWidth,
                              //             height: textFormFieldHeight45,
                              //             padding: EdgeInsets.symmetric(
                              //               horizontal: scrWidth * 0.015,
                              //               vertical: 2,
                              //             ),
                              //             decoration: BoxDecoration(
                              //               color: textFormFieldFillColor,
                              //               borderRadius: BorderRadius.circular(
                              //                   scrWidth * 0.026),
                              //             ),
                              //             child: TextFormField(
                              //               focusNode: dividentAmountFocus,
                              //               cursorHeight: scrWidth * 0.055,
                              //               controller: dividend,
                              //               keyboardType: TextInputType.number,
                              //               cursorWidth: 1,
                              //               cursorColor: Colors.black,
                              //               style: TextStyle(
                              //                 color: Colors.black,
                              //                 fontWeight: FontWeight.w600,
                              //                 fontSize: FontSize15,
                              //                 fontFamily: 'Urbanist',
                              //               ),
                              //               decoration: InputDecoration(
                              //                 labelText:
                              //                     'Dividend Amount is fixed (Optional)',
                              //                 labelStyle: TextStyle(
                              //                   color: dividentAmountFocus.hasFocus
                              //                       ? primarycolor
                              //                       : textFormUnFocusColor,
                              //                   fontWeight: FontWeight.w600,
                              //                   fontSize: FontSize15,
                              //                   fontFamily: 'Urbanist',
                              //                 ),
                              //                 prefixIcon: Container(
                              //                   height: scrWidth * 0.045,
                              //                   width: 10,
                              //                   padding: EdgeInsets.all(
                              //                       scrWidth * 0.033),
                              //                   child: SvgPicture.asset(
                              //                     'assets/icons/subscription.svg',
                              //                     fit: BoxFit.contain,
                              //                     color:
                              //                         dividentAmountFocus.hasFocus
                              //                             ? primarycolor
                              //                             : textFormUnFocusColor,
                              //                   ),
                              //                 ),
                              //                 fillColor: textFormFieldFillColor,
                              //                 filled: true,
                              //                 contentPadding: EdgeInsets.only(
                              //                     top: 5, bottom: scrWidth * 0.033),
                              //                 disabledBorder: InputBorder.none,
                              //                 enabledBorder: InputBorder.none,
                              //                 errorBorder: InputBorder.none,
                              //                 border: InputBorder.none,
                              //                 focusedBorder: UnderlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: primarycolor,
                              //                     width: 2,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.03,
                              //           ),
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               //DRAW TYPE
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.445,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.only(
                              //                     left: scrWidth * 0.051,
                              //                     right: scrWidth * 0.04),
                              //                 child: DropdownButton(
                              //                   icon: Icon(
                              //                     Icons.arrow_drop_down_rounded,
                              //                     size: scrWidth * 0.07,
                              //                   ),
                              //                   iconDisabledColor:
                              //                       Color(0xff908F8F),
                              //                   underline: Container(),
                              //                   isExpanded: true,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                   style: TextStyle(
                              //                     fontSize: FontSize15,
                              //                     fontFamily: 'Urbanist',
                              //                     color: Colors.black,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                   hint: Container(
                              //                     // width: 110,
                              //                     width: scrWidth * 0.6,
                              //                     // color: Colors.red,
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       children: [
                              //                         SvgPicture.asset(
                              //                           'assets/icons/Vector (8).svg',
                              //                           fit: BoxFit.contain,
                              //                         ),
                              //                         Text(
                              //                           "Draw Type",
                              //                           style: TextStyle(
                              //                             fontSize: FontSize15,
                              //                             fontFamily: 'Urbanist',
                              //                             fontWeight:
                              //                                 FontWeight.w600,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   value: drawTypeValue,
                              //                   onChanged: (value) {
                              //                     drawTypeValue = value.toString();
                              //                     print(value);
                              //                     drawDate = [];
                              //                     if (drawTypeValue == 'Weekly') {
                              //                       for (int i = 0; i < 7; i++) {
                              //                         drawDate
                              //                             .add((i + 1).toString());
                              //                       }
                              //                     } else {
                              //                       for (int i = 0; i < 31; i++) {
                              //                         drawDate
                              //                             .add((i + 1).toString());
                              //                       }
                              //                     }
                              //                     setState(() {});
                              //                   },
                              //                   items: drawType
                              //                       .map(
                              //                         (value) => DropdownMenuItem(
                              //                           value: value,
                              //                           child:
                              //                               Text(value.toString()),
                              //                         ),
                              //                       )
                              //                       .toList(),
                              //                 ),
                              //               ),
                              //
                              //               //DRAW DATE
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.445,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.only(
                              //                     left: scrWidth * 0.051,
                              //                     right: scrWidth * 0.04),
                              //                 child: DropdownButton(
                              //                   icon: Icon(
                              //                     Icons.arrow_drop_down_rounded,
                              //                     size: scrWidth * 0.07,
                              //                   ),
                              //                   iconDisabledColor:
                              //                       Color(0xff908F8F),
                              //                   underline: Container(),
                              //                   isExpanded: true,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                   style: TextStyle(
                              //                     fontSize: FontSize15,
                              //                     fontFamily: 'Urbanist',
                              //                     color: Colors.black,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                   hint: Container(
                              //                     // width: 110,
                              //                     width: scrWidth * 0.6,
                              //                     // color: Colors.red,
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       children: [
                              //                         SvgPicture.asset(
                              //                           'assets/icons/Vector (8).svg',
                              //                           fit: BoxFit.contain,
                              //                         ),
                              //                         Text(
                              //                           "Draw Date",
                              //                           style: TextStyle(
                              //                             fontSize: FontSize15,
                              //                             fontFamily: 'Urbanist',
                              //                             fontWeight:
                              //                                 FontWeight.w600,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   value: drawDateValue,
                              //                   onChanged: (value) {
                              //                     drawDateValue = value.toString();
                              //                     print(drawDateValue);
                              //
                              //                     print(value);
                              //                     setState(() {});
                              //                   },
                              //                   items: drawDate
                              //                       .map(
                              //                         (value) => DropdownMenuItem(
                              //                           value: value,
                              //                           child:
                              //                               Text(value.toString()),
                              //                         ),
                              //                       )
                              //                       .toList(),
                              //                 ),
                              //               ),
                              //
                              //               // //DatePicker
                              //               // GestureDetector(
                              //               //   onTap: () {
                              //               //     _selectDate(context);
                              //               //     print(selectedTime!.hour);
                              //               //     print(selectedTime!.minute);
                              //               //     print(selectedDate);
                              //               //     print(selectedDate!.weekday);
                              //               //   },
                              //               //   child: Container(
                              //               //     // color: Colors.pink,
                              //               //     width: scrWidth * 0.44,
                              //               //     // width: 160,
                              //               //     height: textFormFieldHeight45,
                              //               //     decoration: BoxDecoration(
                              //               //       color: textFormFieldFillColor,
                              //               //       borderRadius:
                              //               //           BorderRadius.circular(
                              //               //               scrWidth * 0.033),
                              //               //     ),
                              //               //     padding: EdgeInsets.symmetric(
                              //               //         horizontal: padding15),
                              //               //     child: Row(
                              //               //       mainAxisAlignment:
                              //               //           MainAxisAlignment.spaceAround,
                              //               //       children: [
                              //               //         Text(
                              //               //           selectedDate == null
                              //               //               ? "Drawn Date"
                              //               //               : DateFormat.yMMMd()
                              //               //                   .format(
                              //               //                       selectedDate!),
                              //               //           // "${selectedDate?.toLocal()}"
                              //               //           //     .split(' ')[0],
                              //               //           style: TextStyle(
                              //               //             color: selectedDate == null
                              //               //                 ? Color(0xffB0B0B0)
                              //               //                 : Colors.black,
                              //               //             fontSize: FontSize14,
                              //               //             fontFamily: 'Urbanist',
                              //               //             fontWeight: FontWeight.w600,
                              //               //           ),
                              //               //         ),
                              //               //         SizedBox(
                              //               //           width: scrWidth * 0.04,
                              //               //         ),
                              //               //         SvgPicture.asset(
                              //               //           'assets/icons/date.svg',
                              //               //           color: Color(0xffB0B0B0),
                              //               //         ),
                              //               //       ],
                              //               //     ),
                              //               //   ),
                              //               // ),
                              //               // //TimePicker
                              //               // GestureDetector(
                              //               //   onTap: () {
                              //               //     _selectTime(context);
                              //               //     print(selectedTime);
                              //               //     print(selectedDate);
                              //               //   },
                              //               //   child: Container(
                              //               //     // color: Colors.pink,
                              //               //     width: scrWidth * 0.44,
                              //               //     // width: 160,
                              //               //     height: textFormFieldHeight45,
                              //               //     decoration: BoxDecoration(
                              //               //       color: textFormFieldFillColor,
                              //               //       borderRadius:
                              //               //           BorderRadius.circular(
                              //               //               scrWidth * 0.033),
                              //               //     ),
                              //               //     padding: EdgeInsets.symmetric(
                              //               //         horizontal: padding15),
                              //               //     child: Row(
                              //               //       mainAxisAlignment:
                              //               //           MainAxisAlignment.spaceAround,
                              //               //       children: [
                              //               //         Text(
                              //               //           selectedTime == null
                              //               //               ? "Drawn Time"
                              //               //               : "${selectedTime!.hour.toString()}: ",
                              //               //           style: TextStyle(
                              //               //             color: selectedTime == null
                              //               //                 ? Color(0xffB0B0B0)
                              //               //                 : Colors.black,
                              //               //             fontSize: FontSize14,
                              //               //             fontFamily: 'Urbanist',
                              //               //             fontWeight: FontWeight.w600,
                              //               //           ),
                              //               //         ),
                              //               //         SizedBox(
                              //               //           width: scrWidth * 0.04,
                              //               //         ),
                              //               //         SvgPicture.asset(
                              //               //           'assets/icons/time.svg',
                              //               //           color: Color(0xffB0B0B0),
                              //               //         ),
                              //               //       ],
                              //               //     ),
                              //               //   ),
                              //               // ),
                              //             ],
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           GestureDetector(
                              //             onTap: () {
                              //               _selectTime(context);
                              //               print(selectedTime.toString());
                              //
                              //             },
                              //             child: Container(
                              //               // color: Colors.pink,
                              //               width: scrWidth * 0.44,
                              //               // width: 160,
                              //               height: textFormFieldHeight45,
                              //               decoration: BoxDecoration(
                              //                 color: textFormFieldFillColor,
                              //                 borderRadius: BorderRadius.circular(
                              //                     scrWidth * 0.033),
                              //               ),
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: padding15),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.spaceAround,
                              //                 children: [
                              //                   Text(
                              //                     selectedTime == null
                              //                         ? "Draw Time"
                              //                         : "${selectedTime!.hour.toString()}: ${selectedTime!.minute.toString()}",
                              //                     style: TextStyle(
                              //                       color: selectedTime == null
                              //                           ? Color(0xffB0B0B0)
                              //                           : Colors.black,
                              //                       fontSize: FontSize14,
                              //                       fontFamily: 'Urbanist',
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: scrWidth * 0.04,
                              //                   ),
                              //                   SvgPicture.asset(
                              //                     'assets/icons/time.svg',
                              //                     color: Color(0xffB0B0B0),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           Text(
                              //             "First drawn date & time will remains for upcoming drawn dates.",
                              //             style: TextStyle(
                              //               color: Color(0xff827E7E),
                              //               fontSize: FontSize10,
                              //               fontFamily: 'Urbanist',
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.04,
                              //           ),
                              //           DottedBorder(
                              //             padding: EdgeInsets.all(0),
                              //             borderType: BorderType.RRect,
                              //             radius: Radius.circular(12),
                              //             color: Color(0xffDADADA),
                              //             strokeWidth: 1,
                              //             child: Container(
                              //               height: 73,
                              //               width: 336,
                              //               decoration: BoxDecoration(
                              //                 color: Color(0xffF7F8F9),
                              //                 borderRadius:
                              //                     BorderRadius.circular(12),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   SvgPicture.asset(
                              //                     "assets/icons/docCam.svg",
                              //                     height: scrWidth * 0.06,
                              //                     width: scrWidth * 0.08,
                              //                     color: Color(0xff8391A1),
                              //                     // height: 21,
                              //                     // width: 25,
                              //                   ),
                              //                   SizedBox(
                              //                     width: scrWidth * 0.04,
                              //                   ),
                              //                   Text(
                              //                     "Upload Documents",
                              //                     style: TextStyle(
                              //                       color: Color(0xffB0B0B0),
                              //                       fontSize: FontSize15,
                              //                       fontFamily: 'Urbanist',
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       //Auction
                              //       Column(
                              //         mainAxisAlignment: MainAxisAlignment.start,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           SizedBox(
                              //             height: scrWidth * 0.02,
                              //           ),
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.44,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: padding15),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceAround,
                              //                   children: [
                              //                     Text(
                              //                       "Auction Date",
                              //                       style: TextStyle(
                              //                         color: Color(0xffB0B0B0),
                              //                         fontSize: FontSize14,
                              //                         fontFamily: 'Urbanist',
                              //                         fontWeight: FontWeight.w600,
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       width: scrWidth * 0.04,
                              //                     ),
                              //                     SvgPicture.asset(
                              //                       'assets/icons/date.svg',
                              //                       color: Color(0xffB0B0B0),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               Container(
                              //                 // color: Colors.pink,
                              //                 width: scrWidth * 0.44,
                              //                 // width: 160,
                              //                 height: textFormFieldHeight45,
                              //                 decoration: BoxDecoration(
                              //                   color: textFormFieldFillColor,
                              //                   borderRadius: BorderRadius.circular(
                              //                       scrWidth * 0.033),
                              //                 ),
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: padding15),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceAround,
                              //                   children: [
                              //                     Text(
                              //                       "Auction Time",
                              //                       style: TextStyle(
                              //                         color: Color(0xffB0B0B0),
                              //                         fontSize: FontSize14,
                              //                         fontFamily: 'Urbanist',
                              //                         fontWeight: FontWeight.w600,
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       width: scrWidth * 0.04,
                              //                     ),
                              //                     SvgPicture.asset(
                              //                       'assets/icons/time.svg',
                              //                       color: Color(0xffB0B0B0),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.01,
                              //           ),
                              //           Text(
                              //             "First Auction date & time will remains for upcoming auction dates.",
                              //             style: TextStyle(
                              //               color: Color(0xff827E7E),
                              //               fontSize: FontSize10,
                              //               fontFamily: 'Urbanist',
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: scrWidth * 0.04,
                              //           ),
                              //           DottedBorder(
                              //             borderType: BorderType.RRect,
                              //             radius: Radius.circular(12),
                              //             color: Color(0xffDADADA),
                              //             strokeWidth: 1,
                              //             child: Container(
                              //               height: 73,
                              //               width: 336,
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(12),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   SvgPicture.asset(
                              //                     "assets/icons/docCam.svg",
                              //                     height: scrWidth * 0.06,
                              //                     width: scrWidth * 0.08,
                              //                     color: Color(0xff8391A1),
                              //                     // height: 21,
                              //                     // width: 25,
                              //                   ),
                              //                   SizedBox(
                              //                     width: scrWidth * 0.04,
                              //                   ),
                              //                   Text(
                              //                     "Upload Documents",
                              //                     style: TextStyle(
                              //                       color: Color(0xffB0B0B0),
                              //                       fontSize: FontSize15,
                              //                       fontFamily: 'Urbanist',
                              //                       fontWeight: FontWeight.w500,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: scrWidth * 0.15,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () async {
              if (chitName.text != '' &&
                  dropdownValue != null &&
                  members > 3 &&
                  amount.text != '' &&
                  duration.text != '' &&
                  subscriptionAmount.text != '' &&
                  drawTypeValue != null &&
                  drawDateValue != null &&
                  selectedTime != null &&
                  (fileUrl != null || fileUrl != '')) {
                final chit = ChitModel(
                  amount: double.tryParse(amount.text),
                  private: private,
                  chitDate: int.parse(drawDateValue!),
                  chitName: chitName.text,
                  chitTime:
                      '${selectedTime!.hour.toString()}:${selectedTime!.minute.toString()}',
                  chitType: drawTypeValue,
                  commission: dropdownValue,
                  createdDate: DateTime.now(),
                  dividendAmount: double.tryParse(dividend.text) ?? 0.0,
                  document: url,
                  drawn: false,
                  duration: int.parse(duration.text),
                  profile: profile,
                  subscriptionAmount: double.tryParse(subscriptionAmount.text),
                  status: widget.chit.status ?? 0,
                  membersCount: members,
                  phone: widget.chit.phone ?? '',
                  userId: currentuserid,
                  ifsc: widget.chit.ifsc ?? '',
                  accountHolderName: widget.chit.accountHolderName ?? '',
                  upiApps: widget.chit.upiApps,
                  bankName: widget.chit.bankName ?? '',
                  accountNumber: widget.chit.accountNumber ?? '',
                  members: widget.chit.members ?? [],
                  winners: widget.chit.winners ?? [],
                  chitId: widget.chit.chitId ?? '',
                  payableAmount: widget.chit.subscriptionAmount,
                );

                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentDetails(
                              chit: chit,
                              size: size ?? '',
                              ext: ext ?? '',
                              bytes: bytes ?? '',
                              fileName: fileName ?? '',
                            )));

                Navigator.pop(context);
              } else {
                chitName.text == ''
                    ? showSnackbar(context, 'Please enter name of your chit')
                    : dropdownValue == null
                        ? showSnackbar(context, 'Please Choose Commission')
                        : members < 4
                            ? showSnackbar(
                                context, 'Members must be greater than 3')
                            : amount.text == ''
                                ? showSnackbar(context, 'Please enter amount')
                                : duration.text == ''
                                    ? showSnackbar(
                                        context, 'Please enter duration')
                                    : subscriptionAmount.text == ''
                                        ? showSnackbar(context,
                                            'Please enter Subscription amount')
                                        : drawTypeValue == null
                                            ? showSnackbar(context,
                                                'Please Choose Chit type')
                                            : drawDateValue == null
                                                ? showSnackbar(context,
                                                    'Please Choose Draw Date')
                                                : selectedTime == null
                                                    ? showSnackbar(context,
                                                        'Please Choose Draw Time')
                                                    : showSnackbar(context,
                                                        'Upload a authorised document');
              }
            },
            child: Container(
                width: 285,
                height: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: primarycolor,
                ),
                child: Center(
                  child: Text(
                    "Add Payment Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
