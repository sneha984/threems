import 'dart:developer';

import 'package:cr_calendar/cr_calendar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/customPackage/date_picker.dart';
import 'package:threems/screens/chits/add_members.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';

import '../../customPackage/time_picker.dart';

class CreateNewChitScreen extends StatefulWidget {
  CreateNewChitScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewChitScreen> createState() => _CreateNewChitScreenState();
}

class _CreateNewChitScreenState extends State<CreateNewChitScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int chitTabBarIndex = 0;
  int drawnOrAuctionTabBarIndex = 0;
  final CrCalendarController calendarController = CrCalendarController();
  final PageController _privateOrPublicChitpageController =
      PageController(keepPage: true);
  final PageController _drawnOrAuctionpageController =
      PageController(keepPage: true);
  String? dropdownValue;
  List dropDownList = ["1%", "2%", "3%", "4%", "5%"];
  FocusNode chitNameFocus = FocusNode();
  FocusNode valueAmountFocus = FocusNode();
  FocusNode durationFocus = FocusNode();
  FocusNode subscriptionAmountFocus = FocusNode();
  FocusNode dividentAmountFocus = FocusNode();

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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: scrWidth,
                            // color: Colors.red,
                            height: scrWidth * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              top: 5, bottom: scrWidth * 0.033),
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
                                SvgPicture.asset(
                                  "assets/icons/camera.svg",
                                  height: scrWidth * 0.06,
                                  width: scrWidth * 0.08,
                                  // height: 21,
                                  // width: 25,
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
                                          'assets/icons/commision.svg',
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          "Commision",
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: padding15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: scrWidth * 0.052,
                                      width: scrWidth * 0.052,
                                      child: SvgPicture.asset(
                                        'assets/icons/members.svg',
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
                                          Container(
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "10",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSize14,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
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
                                      drawnOrAuctionTabBarIndex = 0;
                                    });
                                    _drawnOrAuctionpageController
                                        .jumpToPage(drawnOrAuctionTabBarIndex);
                                  },
                                  child: Container(
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: scrWidth * 0.1,
                                    decoration: BoxDecoration(
                                      color: drawnOrAuctionTabBarIndex == 0
                                          ? tabBarColor
                                          : Colors.white.withOpacity(0),
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.052),
                                      border: Border.all(
                                        color: drawnOrAuctionTabBarIndex == 0
                                            ? Colors.black.withOpacity(0)
                                            : Colors.black.withOpacity(0.06),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/drawn.svg',
                                          color: drawnOrAuctionTabBarIndex == 0
                                              ? Colors.white
                                              : Color(0xffB3B3B3),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.04,
                                        ),
                                        Text(
                                          "Drawn",
                                          style: TextStyle(
                                            color:
                                                drawnOrAuctionTabBarIndex == 0
                                                    ? Colors.white
                                                    : Color(0xffB3B3B3),
                                            fontSize: FontSize14,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      drawnOrAuctionTabBarIndex = 1;
                                    });
                                    _drawnOrAuctionpageController
                                        .jumpToPage(drawnOrAuctionTabBarIndex);
                                  },
                                  child: Container(
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: scrWidth * 0.1,
                                    decoration: BoxDecoration(
                                      color: drawnOrAuctionTabBarIndex == 1
                                          ? tabBarColor
                                          : Colors.white.withOpacity(0),
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.052),
                                      border: Border.all(
                                        color: drawnOrAuctionTabBarIndex == 1
                                            ? Colors.black.withOpacity(0)
                                            : Colors.black.withOpacity(0.06),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/members.svg',
                                          color: drawnOrAuctionTabBarIndex == 1
                                              ? Colors.white
                                              : Color(0xffB3B3B3),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.04,
                                        ),
                                        Text(
                                          "Auction",
                                          style: TextStyle(
                                            color:
                                                drawnOrAuctionTabBarIndex == 1
                                                    ? Colors.white
                                                    : Color(0xffB3B3B3),
                                            fontSize: FontSize14,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.red[200],
                            height: scrWidth * .62,
                            width: scrWidth,
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _drawnOrAuctionpageController,
                              children: [
                                //Drawn
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                        borderRadius: BorderRadius.circular(
                                            scrWidth * 0.026),
                                      ),
                                      child: TextFormField(
                                        focusNode: dividentAmountFocus,
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
                                          labelText: 'Divident Amount is fixed',
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
                                            padding: EdgeInsets.all(
                                                scrWidth * 0.033),
                                            child: SvgPicture.asset(
                                              'assets/icons/subscription.svg',
                                              fit: BoxFit.contain,
                                              color:
                                                  dividentAmountFocus.hasFocus
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
                                        //DatePicker
                                        GestureDetector(
                                          onTap: () {
                                            _selectDate(context);
                                            print(selectedTime);
                                            print(selectedDate);
                                          },
                                          child: Container(
                                            // color: Colors.pink,
                                            width: scrWidth * 0.44,
                                            // width: 160,
                                            height: textFormFieldHeight45,
                                            decoration: BoxDecoration(
                                              color: textFormFieldFillColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.033),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: padding15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  selectedDate == null
                                                      ? "Drawn Date"
                                                      : DateFormat.yMMMd()
                                                          .format(
                                                              selectedDate!),
                                                  // "${selectedDate?.toLocal()}"
                                                  //     .split(' ')[0],
                                                  style: TextStyle(
                                                    color: selectedDate == null
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
                                                  'assets/icons/date.svg',
                                                  color: Color(0xffB0B0B0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //TimePicker
                                        GestureDetector(
                                          onTap: () {
                                            _selectTime(context);
                                            print(selectedTime);
                                            print(selectedDate);
                                          },
                                          child: Container(
                                            // color: Colors.pink,
                                            width: scrWidth * 0.44,
                                            // width: 160,
                                            height: textFormFieldHeight45,
                                            decoration: BoxDecoration(
                                              color: textFormFieldFillColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.033),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: padding15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  selectedTime == null
                                                      ? "Drawn Time"
                                                      : "${selectedTime!.hour.toString()}: ",
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
                                    DottedBorder(
                                      padding: EdgeInsets.all(0),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      color: Color(0xffDADADA),
                                      strokeWidth: 1,
                                      child: Container(
                                        height: 73,
                                        width: 336,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF7F8F9),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/docCam.svg",
                                              height: scrWidth * 0.06,
                                              width: scrWidth * 0.08,
                                              color: Color(0xff8391A1),
                                              // height: 21,
                                              // width: 25,
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.04,
                                            ),
                                            Text(
                                              "Upload Documents",
                                              style: TextStyle(
                                                color: Color(0xffB0B0B0),
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Auction
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: scrWidth * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          // color: Colors.pink,
                                          width: scrWidth * 0.44,
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Auction Date",
                                                style: TextStyle(
                                                  color: Color(0xffB0B0B0),
                                                  fontSize: FontSize14,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: scrWidth * 0.04,
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/date.svg',
                                                color: Color(0xffB0B0B0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.pink,
                                          width: scrWidth * 0.44,
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Auction Time",
                                                style: TextStyle(
                                                  color: Color(0xffB0B0B0),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: scrWidth * 0.01,
                                    ),
                                    Text(
                                      "First Auction date & time will remains for upcoming auction dates.",
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
                                    DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      color: Color(0xffDADADA),
                                      strokeWidth: 1,
                                      child: Container(
                                        height: 73,
                                        width: 336,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/docCam.svg",
                                              height: scrWidth * 0.06,
                                              width: scrWidth * 0.08,
                                              color: Color(0xff8391A1),
                                              // height: 21,
                                              // width: 25,
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.04,
                                            ),
                                            Text(
                                              "Upload Documents",
                                              style: TextStyle(
                                                color: Color(0xffB0B0B0),
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: scrWidth,
                            // color: Colors.red,
                            height: scrWidth * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              top: 5, bottom: scrWidth * 0.033),
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
                                SvgPicture.asset(
                                  "assets/icons/camera.svg",
                                  height: scrWidth * 0.06,
                                  width: scrWidth * 0.08,
                                  // height: 21,
                                  // width: 25,
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
                                          'assets/icons/commision.svg',
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          "Commision",
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: padding15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: scrWidth * 0.052,
                                      width: scrWidth * 0.052,
                                      child: SvgPicture.asset(
                                        'assets/icons/members.svg',
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
                                          Container(
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "10",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSize14,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
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
                                      drawnOrAuctionTabBarIndex = 0;
                                    });
                                    _drawnOrAuctionpageController
                                        .jumpToPage(drawnOrAuctionTabBarIndex);
                                  },
                                  child: Container(
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: scrWidth * 0.1,
                                    decoration: BoxDecoration(
                                      color: drawnOrAuctionTabBarIndex == 0
                                          ? tabBarColor
                                          : Colors.white.withOpacity(0),
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.052),
                                      border: Border.all(
                                        color: drawnOrAuctionTabBarIndex == 0
                                            ? Colors.black.withOpacity(0)
                                            : Colors.black.withOpacity(0.06),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/drawn.svg',
                                          color: drawnOrAuctionTabBarIndex == 0
                                              ? Colors.white
                                              : Color(0xffB3B3B3),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.04,
                                        ),
                                        Text(
                                          "Drawn",
                                          style: TextStyle(
                                            color:
                                                drawnOrAuctionTabBarIndex == 0
                                                    ? Colors.white
                                                    : Color(0xffB3B3B3),
                                            fontSize: FontSize14,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      drawnOrAuctionTabBarIndex = 1;
                                    });
                                    _drawnOrAuctionpageController
                                        .jumpToPage(drawnOrAuctionTabBarIndex);
                                  },
                                  child: Container(
                                    width: scrWidth * 0.445,
                                    // width: 160,
                                    height: scrWidth * 0.1,
                                    decoration: BoxDecoration(
                                      color: drawnOrAuctionTabBarIndex == 1
                                          ? tabBarColor
                                          : Colors.white.withOpacity(0),
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.052),
                                      border: Border.all(
                                        color: drawnOrAuctionTabBarIndex == 1
                                            ? Colors.black.withOpacity(0)
                                            : Colors.black.withOpacity(0.06),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/members.svg',
                                          color: drawnOrAuctionTabBarIndex == 1
                                              ? Colors.white
                                              : Color(0xffB3B3B3),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.04,
                                        ),
                                        Text(
                                          "Auction",
                                          style: TextStyle(
                                            color:
                                                drawnOrAuctionTabBarIndex == 1
                                                    ? Colors.white
                                                    : Color(0xffB3B3B3),
                                            fontSize: FontSize14,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.red[200],
                            height: scrWidth * .62,
                            width: scrWidth,
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _drawnOrAuctionpageController,
                              children: [
                                //Drawn
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                        borderRadius: BorderRadius.circular(
                                            scrWidth * 0.026),
                                      ),
                                      child: TextFormField(
                                        focusNode: dividentAmountFocus,
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
                                          labelText: 'Divident Amount is fixed',
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
                                            padding: EdgeInsets.all(
                                                scrWidth * 0.033),
                                            child: SvgPicture.asset(
                                              'assets/icons/subscription.svg',
                                              fit: BoxFit.contain,
                                              color:
                                                  dividentAmountFocus.hasFocus
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
                                        //DatePicker
                                        GestureDetector(
                                          onTap: () {
                                            _selectDate(context);
                                            print(selectedTime);
                                            print(selectedDate);
                                          },
                                          child: Container(
                                            // color: Colors.pink,
                                            width: scrWidth * 0.44,
                                            // width: 160,
                                            height: textFormFieldHeight45,
                                            decoration: BoxDecoration(
                                              color: textFormFieldFillColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.033),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: padding15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  selectedDate == null
                                                      ? "Drawn Date"
                                                      : DateFormat.yMMMd()
                                                          .format(
                                                              selectedDate!),
                                                  // "${selectedDate?.toLocal()}"
                                                  //     .split(' ')[0],
                                                  style: TextStyle(
                                                    color: selectedDate == null
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
                                                  'assets/icons/date.svg',
                                                  color: Color(0xffB0B0B0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //TimePicker
                                        GestureDetector(
                                          onTap: () {
                                            _selectTime(context);
                                            print(selectedTime);
                                            print(selectedDate);
                                          },
                                          child: Container(
                                            // color: Colors.pink,
                                            width: scrWidth * 0.44,
                                            // width: 160,
                                            height: textFormFieldHeight45,
                                            decoration: BoxDecoration(
                                              color: textFormFieldFillColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.033),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: padding15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  selectedTime == null
                                                      ? "Drawn Time"
                                                      : "${selectedTime!.hour.toString()}: ",
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
                                    DottedBorder(
                                      padding: EdgeInsets.all(0),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      color: Color(0xffDADADA),
                                      strokeWidth: 1,
                                      child: Container(
                                        height: 73,
                                        width: 336,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF7F8F9),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/docCam.svg",
                                              height: scrWidth * 0.06,
                                              width: scrWidth * 0.08,
                                              color: Color(0xff8391A1),
                                              // height: 21,
                                              // width: 25,
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.04,
                                            ),
                                            Text(
                                              "Upload Documents",
                                              style: TextStyle(
                                                color: Color(0xffB0B0B0),
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Auction
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: scrWidth * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          // color: Colors.pink,
                                          width: scrWidth * 0.44,
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Auction Date",
                                                style: TextStyle(
                                                  color: Color(0xffB0B0B0),
                                                  fontSize: FontSize14,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width: scrWidth * 0.04,
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/date.svg',
                                                color: Color(0xffB0B0B0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.pink,
                                          width: scrWidth * 0.44,
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Auction Time",
                                                style: TextStyle(
                                                  color: Color(0xffB0B0B0),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: scrWidth * 0.01,
                                    ),
                                    Text(
                                      "First Auction date & time will remains for upcoming auction dates.",
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
                                    DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      color: Color(0xffDADADA),
                                      strokeWidth: 1,
                                      child: Container(
                                        height: 73,
                                        width: 336,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/docCam.svg",
                                              height: scrWidth * 0.06,
                                              width: scrWidth * 0.08,
                                              color: Color(0xff8391A1),
                                              // height: 21,
                                              // width: 25,
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.04,
                                            ),
                                            Text(
                                              "Upload Documents",
                                              style: TextStyle(
                                                color: Color(0xffB0B0B0),
                                                fontSize: FontSize15,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMembers(),
              )),
          child: Container(
              width: 285,
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: primarycolor,
              ),
              child: Center(
                child: Text(
                  "Add Members",
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
