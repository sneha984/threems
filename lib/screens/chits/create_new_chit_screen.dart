import 'dart:developer';
import 'dart:io';

import 'package:cr_calendar/cr_calendar.dart';
import 'package:dotted_border/dotted_border.dart';
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

import '../../customPackage/time_picker.dart';
import '../../model/ChitModel.dart';
import 'create_chit_payment_session.dart';

class CreateNewChitScreen extends StatefulWidget {
  CreateNewChitScreen({Key? key}) : super(key: key);

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

  List dropDownList = ["1%", "2%", "3%", "4%", "5%"];
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

//DatePick
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        initialDate: DateTime.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child!));
    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = datePicked;
      });
    }
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
    return DefaultTabController(
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
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              color: primarycolor,
                                              width: 2,
                                            ))),
                                      )),
                                  profileFile != null
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.pink,
                                  width: scrWidth * 0.445,
                                  // width: 160,
                                  height: textFormFieldHeight45,
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: FontSize17,
                                                        fontFamily: 'Urbanist',
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
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: FontSize17,
                                                        fontFamily: 'Urbanist',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //DRAW TYPE
                                Container(
                                  // color: Colors.pink,
                                  width: scrWidth * 0.445,
                                  // width: 160,
                                  height: textFormFieldHeight45,
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: padding15),
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
                            SizedBox(
                              height: scrWidth * 0.04,
                            ),
                            InkWell(
                              onTap: () {
                                print('HEREEEEEEEEEEEEEEE');
                                _pickImage('Document');
                              },
                              child: imgFile == null
                                  ? DottedBorder(
                                      padding: EdgeInsets.all(0),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(8),
                                      color: Color(0xffDADADA),
                                      dashPattern: [4, 4],
                                      strokeWidth: 2,
                                      child: Container(
                                        height: scrHeight * 0.08,
                                        width: scrWidth * 0.85,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF7F8F9),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/Group 135.svg",
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.02,
                                            ),
                                            Text(
                                              "Upload Screenshot",
                                              style: TextStyle(
                                                color: Color(0xff8391A1),
                                                fontSize: scrWidth * 0.04,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: scrHeight * 0.5,
                                      width: scrWidth * 0.85,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(imgFile)
                                                as ImageProvider,
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xffDADADA),
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
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                              color: primarycolor,
                                              width: 2,
                                            ))),
                                      )),
                                  profileFile != null
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.pink,
                                  width: scrWidth * 0.445,
                                  // width: 160,
                                  height: textFormFieldHeight45,
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: FontSize17,
                                                        fontFamily: 'Urbanist',
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
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: FontSize17,
                                                        fontFamily: 'Urbanist',
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
                                  labelText: 'Duration',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //DRAW TYPE
                                Container(
                                  // color: Colors.pink,
                                  width: scrWidth * 0.445,
                                  // width: 160,
                                  height: textFormFieldHeight45,
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                    borderRadius:
                                        BorderRadius.circular(scrWidth * 0.033),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: padding15),
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
                            SizedBox(
                              height: scrWidth * 0.04,
                            ),
                            InkWell(
                              onTap: () {
                                print('HEREEEEEEEEEEEEEEE');
                                _pickImage('Document');
                              },
                              child: imgFile == null
                                  ? DottedBorder(
                                      padding: EdgeInsets.all(0),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(8),
                                      color: Color(0xffDADADA),
                                      dashPattern: [4, 4],
                                      strokeWidth: 2,
                                      child: Container(
                                        height: scrHeight * 0.08,
                                        width: scrWidth * 0.85,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF7F8F9),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/Group 135.svg",
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.02,
                                            ),
                                            Text(
                                              "Upload Screenshot",
                                              style: TextStyle(
                                                color: Color(0xff8391A1),
                                                fontSize: scrWidth * 0.04,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: scrHeight * 0.5,
                                      width: scrWidth * 0.85,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(imgFile)
                                                as ImageProvider,
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xffDADADA),
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
          onTap: () {
            if (chitName.text != '' &&
                dropdownValue != null &&
                members > 3 &&
                amount.text != '' &&
                duration.text != '' &&
                subscriptionAmount.text != '' &&
                drawTypeValue != null &&
                drawDateValue != null &&
                selectedTime != null &&
                url != '') {
              final chit = ChitModel(
                members: [],
                amount: double.tryParse(amount.text),
                private: private,
                chitDate: int.parse(drawDateValue!),
                chitName: chitName.text,
                chitTime:
                    '${selectedTime!.hour.toString()}:${selectedTime!.minute.toString()}',
                chitType: drawTypeValue,
                commission: dropdownValue,
                createdDate: DateTime.now(),
                dividendAmount: double.tryParse(dividend.text),
                document: url,
                drawn: false,
                duration: int.parse(duration.text),
                profile: profile,
                subscriptionAmount: double.tryParse(subscriptionAmount.text),
                status: 0,
                membersCount: members,
                winners: [],
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentDetails(
                            chit: chit,
                          )));
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
