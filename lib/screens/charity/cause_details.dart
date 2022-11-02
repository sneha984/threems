import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/charity/bank_details.dart';
import '../../customPackage/date_picker.dart';
import '../../model/charitymodel.dart';
import '../../utils/themes.dart';
import '../../widgets/percentage_widget.dart';
import '../splash_screen.dart';
import 'basic_details.dart';

class CauseDetails extends StatefulWidget {
  const CauseDetails({super.key});

  @override
  State<CauseDetails> createState() => _CauseDetailsState();
}

class _CauseDetailsState extends State<CauseDetails> {
  final FocusNode valueAmountFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode locationFocus = FocusNode();
  final FocusNode phoneNumeberFocus = FocusNode();
  final FocusNode hospitalNameFocus = FocusNode();
  final FocusNode hospitalLocationFocus = FocusNode();


  final  TextEditingController amountcontroller =TextEditingController();
  final  TextEditingController medicaldatecontroller =TextEditingController();
  final  TextEditingController namecontroller =TextEditingController();
  final  TextEditingController locationcontroller =TextEditingController();
  final  TextEditingController phonenumbercontroller =TextEditingController();


  DateTime? selectedDate;

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

  @override
  void initState() {
    nameFocus.addListener(() {
      setState(() {});
    });
    valueAmountFocus.addListener(() {
      setState(() {});
    });
    locationFocus.addListener(() {
      setState(() {});
    });
    phoneNumeberFocus.addListener(() {
      setState(() {});
    });
    hospitalNameFocus.addListener(() {
      setState(() {});
    });
    hospitalLocationFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    valueAmountFocus.dispose();
    nameFocus.dispose();
    locationFocus.dispose();
    phoneNumeberFocus.dispose();
    hospitalNameFocus.dispose();
    hospitalLocationFocus.dispose();
    super.dispose();
  }
  bool loading=false;
  refreshPage() {
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child:Container(
                // color: Colors.red,
                width: scrWidth*0.02,
                height: scrHeight*0.02,
                padding: EdgeInsets.all(scrWidth * 0.056),
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                  width: scrWidth*0.03,
                  height: scrHeight*0.02,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(
              "Create Charity",
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
        padding: EdgeInsets.only(
          left: padding15, right: padding15, top: scrWidth * 0.025,
          // vertical: scrWidth * 0.05,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CAUSE DETAILS",
                    style: TextStyle(
                        fontSize: FontSize16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  PercentageWidget(percent: 25),
                ],
              ),
              SizedBox(
                height: scrWidth * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "I’m raising funds for an",
                    style: TextStyle(
                        fontSize: FontSize13,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8391A1)),
                  ),
                  Container(
                      width: scrWidth * 0.38,
                      height: textFormFieldHeight45,
                      decoration: BoxDecoration(
                          color: Color(0xffF7F8F9),
                          borderRadius: BorderRadius.circular(scrWidth * 0.033),
                          border: Border.all(color: Color(0xffDADADA))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SvgPicture.asset(
                          //   'assets/icons/medical.svg',
                          //   color: Colors.black,
                          //   fit: BoxFit.contain,
                          // ),
                          Text(
                            dropdownValue.toString(),
                            style: TextStyle(
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )),
                  Text(
                    "cause",
                    style: TextStyle(
                        fontSize: FontSize13,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8391A1)),
                  ),
                ],
              ),
              SizedBox(
                height: scrWidth * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "I want to raise",
                    style: TextStyle(
                        fontSize: FontSize13,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8391A1)),
                  ),
                  Container(
                    width: scrWidth*0.63,
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.015,
                      vertical: scrWidth*0.002,
                    ),
                    decoration: BoxDecoration(
                        color: textFormFieldFillColor,
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                    child: TextFormField(
                      controller: amountcontroller,
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
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),
                        fillColor: textFormFieldFillColor,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
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
                ],
              ),
              SizedBox(
                height: scrWidth * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrWidth*0.002,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    border: Border.all(
                      color: Color(0xffDADADA),
                    ),
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: scrWidth*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate == null
                              ? "Date"
                              : DateFormat.yMMMd().format(selectedDate!),
                          style: TextStyle(
                            color: selectedDate == null
                                ? Color(0xffB0B0B0)
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
              SizedBox(
                height: scrWidth * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "This Charity will benefit for",
                    style: TextStyle(
                        fontSize: FontSize13,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8391A1)),
                  ),
                  Container(
                    width: scrWidth*0.46,
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.015,
                      vertical: scrWidth*0.003,
                    ),
                    decoration: BoxDecoration(
                        color: textFormFieldFillColor,
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                    child: TextFormField(
                      controller: namecontroller,
                      focusNode: nameFocus,
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
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: nameFocus.hasFocus
                              ? primarycolor
                              : Color(0xffB0B0B0),
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),
                        fillColor: textFormFieldFillColor,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: scrWidth*0.03, bottom: scrWidth * 0.033),
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
                ],
              ),
              SizedBox(
                height: scrWidth * 0.04,
              ),
              Container(
                width: scrWidth,
                height: textFormFieldHeight45,
                padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.015,
                  vertical: scrWidth*0.002,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: locationcontroller,
                  focusNode: locationFocus,
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
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      color: locationFocus.hasFocus
                          ? primarycolor
                          : textFormUnFocusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                        left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
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
                  vertical: scrWidth*0.002,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: phonenumbercontroller,
                  focusNode: phoneNumeberFocus,
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
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: phoneNumeberFocus.hasFocus
                          ? primarycolor
                          : textFormUnFocusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                        left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
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
                height: scrWidth * 0.05,
              ),
              Text(
                "OPTIONAL",
                style: TextStyle(
                    fontSize: FontSize16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: scrWidth * 0.05,
              ),
              Container(
                width: scrWidth,
                height: textFormFieldHeight45,
                padding: EdgeInsets.symmetric(
                  horizontal: scrWidth * 0.015,
                  vertical: scrWidth*0.002,                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  focusNode: hospitalNameFocus,
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
                    labelText: 'Hospital Name',
                    labelStyle: TextStyle(
                      color: hospitalNameFocus.hasFocus
                          ? primarycolor
                          : textFormUnFocusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                        left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
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
                    vertical: scrWidth*0.002                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  focusNode: hospitalLocationFocus,
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
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      color: hospitalLocationFocus.hasFocus
                          ? primarycolor
                          : textFormUnFocusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                        left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
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
                height: scrHeight*0.03,
              ),
              GestureDetector(
                onTap: () {
                  if
                  (
                  amountcontroller.text.isEmpty&&
                      namecontroller.text.isEmpty&&
                      locationcontroller.text.isEmpty&&
                      phonenumbercontroller.text.isEmpty
                  ){
                    refreshPage();
                    return showSnackbar();
                  }else{
                    charityDetails.add(
                      {
                        "endDate":Timestamp.fromDate(selectedDate!),
                        "valueAmount": double.tryParse(amountcontroller.text),
                        "beneficiaryName": namecontroller.text,
                        "beneficiaryPhNumber": phonenumbercontroller.text,
                        "beneficiaryLocation":locationcontroller.text,

                      }

                    );
                  }
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CreateCharity3(),
                      ));
                },
                child: Container(
                  height: scrHeight*0.065,
                  decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(17)),
                  margin: EdgeInsets.symmetric(vertical: scrWidth*0.03, horizontal: scrHeight*0.06),
                  child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  showSnackbar() {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text("Plz Enter All Details",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
