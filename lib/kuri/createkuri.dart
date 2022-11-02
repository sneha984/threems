import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:threems/kuri/add_members_kuri.dart';

import '../customPackage/date_picker.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'multipleselection.dart';

class CreateKuriPage extends StatefulWidget {
  const CreateKuriPage({Key? key}) : super(key: key);

  @override
  State<CreateKuriPage> createState() => _CreateKuriPageState();
}

class _CreateKuriPageState extends State<CreateKuriPage> {

  int kuriTabBarIndex = 0;
  int selectedIndex=0;
  final PageController _privateOrPublicKuriPageController =
  PageController(keepPage: true);

  final FocusNode phonenumberfocus = FocusNode();
  final FocusNode kuriNameFocus = FocusNode();
  final FocusNode valueAmountFocus=FocusNode();
  final FocusNode fixedDeadLineFocus=FocusNode();
  final FocusNode accountnumberfocus=FocusNode();
  final FocusNode confirmaccountnumberfocus=FocusNode();
  final FocusNode accountholdernamefocus=FocusNode();
  final FocusNode banknamefocus=FocusNode();
  final FocusNode ifsccodefocus=FocusNode();


  DateTime? selectedate;

//DatePick
  Future<void> _selectedDate(BuildContext context) async {
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
    if (datePicked != null && datePicked != selectedate) {
      setState(() {
        selectedate = datePicked;
      });
    }
  }

  @override
 void initState() {
    kuriNameFocus.addListener(() {
     setState(() {});
   });
   valueAmountFocus.addListener(() {
     setState(() {});
   });
   fixedDeadLineFocus.addListener(() {
     setState(() {});
   });
   super.initState();

 }


  @override
 void dispose() {
   _privateOrPublicKuriPageController.dispose();
   valueAmountFocus.dispose();
   kuriNameFocus.dispose();
   fixedDeadLineFocus.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation:0.1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Padding(
            padding: EdgeInsets.only(top: scrHeight*0.03,
                left: scrWidth*0.05,bottom: scrHeight*0.01,right: scrWidth*0.05),
            child:SvgPicture.asset("assets/icons/arrow.svg",),
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top: scrHeight*0.02),
          child: Text(
            "Create New Kuri",
            style: TextStyle(
                fontSize: scrWidth*0.046,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),

      ),
      body: Padding(
        padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05,top: scrHeight*0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(right: scrWidth*0.7,bottom: scrHeight*0.01),
                child: Text("About Kuri",style: TextStyle(
                  fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w600
                ),),
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
                          kuriTabBarIndex = 0;

                        });
                        _privateOrPublicKuriPageController
                            .jumpToPage(kuriTabBarIndex);
                      },
                      child: Container(
                        width: scrWidth * 0.42,
                        // width: 160,
                        height: scrWidth * 0.09,
                        decoration: BoxDecoration(
                          color: kuriTabBarIndex == 0
                              ? tabBarColor
                              : Colors.white.withOpacity(0),
                          borderRadius:
                          BorderRadius.circular(scrWidth * 0.052),
                          border: Border.all(
                            color: kuriTabBarIndex == 0
                                ? Colors.black.withOpacity(0)
                                : Colors.black.withOpacity(0.06),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Public Chit",
                            style: TextStyle(
                              color: kuriTabBarIndex == 0
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
                          kuriTabBarIndex = 1;

                        });
                        _privateOrPublicKuriPageController
                            .jumpToPage(kuriTabBarIndex);
                      },
                      child: Container(
                        width: scrWidth * 0.42,
                        // width: 160,
                        height: scrWidth * 0.09,
                        decoration: BoxDecoration(
                          color: kuriTabBarIndex == 1
                              ? tabBarColor
                              : Colors.white.withOpacity(0),
                          borderRadius:
                          BorderRadius.circular(scrWidth * 0.052),
                          border: Border.all(
                            color: kuriTabBarIndex == 1
                                ? Colors.black.withOpacity(0)
                                : Colors.black.withOpacity(0.06),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Private Chit",
                            style: TextStyle(
                              color: kuriTabBarIndex == 1
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
              SizedBox(height: scrHeight*0.01,),

              Container(
                // color: Colors.grey[200],
                height: scrWidth * 5,
                width: scrWidth,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _privateOrPublicKuriPageController,
                  children: [
                    //PublicKuri
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: kuriNameFocus,
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
                              labelText: 'Kuri Name',
                              labelStyle: TextStyle(
                                color: kuriNameFocus.hasFocus
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
                                  color: kuriNameFocus.hasFocus
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                // _selectedDate(context);

                                },
                              child: Container(
                                  width:scrWidth*0.7,
                                  height: textFormFieldHeight45,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scrWidth * 0.015,
                                    // vertical: scrHeight*0.01,
                                  ),
                                  decoration: BoxDecoration(
                                      color: textFormFieldFillColor,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.026)),
                                  child: Row(
                                    children: [
                                      SizedBox(width: scrWidth*0.03,),
                                    SvgPicture.asset(
                                      'assets/icons/durationiconsvg.svg',
                                      fit: BoxFit.contain,
                                      color:Color(0xffB0B0B0)
                                    ),
                                      SizedBox(width: scrWidth*0.03,),

                                      Text(
                                          selectedate == null
                                              ? "Fixed Deadline"
                                              : DateFormat.yMMMd()
                                              .format(
                                              selectedate!),style: TextStyle(
                                            color: selectedate == null
                                                ? Color(0xffB0B0B0)
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSize15,
                                            fontFamily: 'Urbanist',
                                          ),),
                                    ],
                                  )

                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                print("hiii");
                                _selectedDate(context);
                              },
                              child: Container(
                                height: scrHeight*0.055,
                                width: scrWidth*0.16,
                                decoration: BoxDecoration(
                                  color: primarycolor,
                                  borderRadius: BorderRadius.circular(scrWidth*0.03)
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.only(top: scrHeight*0.01,bottom: scrHeight*0.01),
                                  child: SvgPicture.asset("assets/icons/calenderimage.svg"),
                                ),
                              ),
                            ),
                            SizedBox(width: scrWidth*0.0009,),
                          ],
                        ),
                        SizedBox(
                          height: scrWidth * 0.05,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: scrWidth*0.5,bottom: scrHeight*0.017),
                          child: Text("Choose your purpose",style: TextStyle(
                              fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                        Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState((){
                                selectedIndex = 1;
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: scrWidth * 0.18,
                                  height: scrHeight * 0.08,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,color: Colors.grey.shade100,
                                    border:selectedIndex == 1?Border.all(color: primarycolor,width: 3,):Border.all(color: Colors.transparent),),
                                    child:SvgPicture.asset("assets/pay/marriagesvg.svg")
                                ),
                                SizedBox(
                                  height: scrHeight * 0.01,
                                ),
                                Text(
                                    "Marriage",
                                    style: TextStyle(
                                      color: Color(0xffB0B0B0),
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10)),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),
                          InkWell(
                            onTap: (){
                              setState((){
                                selectedIndex=0;
                              });

                            },
                            child: Column(
                              children: [
                                Container(
                                  width: scrWidth * 0.18,
                                  height: scrHeight * 0.08,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade100,
                                    border:selectedIndex == 0?Border.all(
                                      color: primarycolor,width: 3,):Border.all(color: Colors.transparent),),
                                    child:SvgPicture.asset("assets/pay/hospitalsvg.svg"),

                                ),
                                SizedBox(
                                  height: scrHeight * 0.01,
                                ),
                                Text(
                                    "Hospital",
                                    style: TextStyle(
                                        color: Color(0xffB0B0B0),
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10)),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),
                          InkWell(
                            onTap: (){
                              setState((){
                                selectedIndex=2;
                              });
                            },
                            child:Column(
                              children: [
                                Container(
                                  width: scrWidth * 0.18,
                                  height: scrHeight * 0.08,
                                  decoration: BoxDecoration(shape: BoxShape.circle,
                                    color: Colors.grey.shade100,
                                    border:selectedIndex == 2?Border.all(color: primarycolor,width: 3,):Border.all(color: Colors.transparent),),
                                      child: SvgPicture.asset("assets/pay/othersvg.svg"),
                                ),
                                SizedBox(
                                  height: scrHeight * 0.01,
                                ),
                                Text(
                                    "Other",
                                    style: TextStyle(
                                        color: Color(0xffB0B0B0),
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10)),
                              ],
                            ),

                          )
                        ],
                      ),
                        Padding(
                          padding:  EdgeInsets.only(right: scrWidth*0.7,top: scrHeight*0.016,bottom: scrHeight*0.01),
                          child: Text("Payment",style: TextStyle(
                              fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: phonenumberfocus,
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
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/indflag.svg',
                                    height: scrHeight*0.03,
                                    width: scrWidth*0.02,
                                  ),
                                  SizedBox(
                                    width: scrWidth*0.02,
                                  ),
                                  Text(
                                    "+91",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: FontSize17,
                                      fontFamily: 'Outfit',
                                    ),
                                  ),
                                  VerticalDivider(
                                    endIndent: 6,
                                    indent: 6,
                                    color: Color(0xffDADADA),
                                    thickness: 1,
                                  ),
                                ],
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
                        Padding(
                          padding:  EdgeInsets.only(right: scrWidth*0.6,top: scrHeight*0.025,bottom: scrHeight*0.02),
                          child: Text("Choose UPI apps",style: TextStyle(
                            color: Color(0xffB0B0B0),
                              fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                        Container(
                          height:90,
                            child: Kuri()),

                        Padding(
                          padding:  EdgeInsets.only(right: scrWidth*0.65,top: scrHeight*0.026,bottom: scrHeight*0.01),
                          child: Text("Bank Details",style: TextStyle(
                              color: Color(0xffB0B0B0),
                              fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                        SizedBox(height: 14,),
                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: accountnumberfocus,
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
                              labelText: 'Account Number',
                              labelStyle: TextStyle(
                                color: accountnumberfocus.hasFocus
                                    ? primarycolor
                                    : Color(0xffB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
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
                        SizedBox(height: 14,),

                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: confirmaccountnumberfocus,
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
                              labelText: 'Confirm Account Number',
                              labelStyle: TextStyle(
                                color: confirmaccountnumberfocus.hasFocus
                                    ? primarycolor
                                    : Color(0xffB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
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
                        SizedBox(height: 14,),

                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: accountholdernamefocus,
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
                              labelText: 'Account Holder Name',
                              labelStyle: TextStyle(
                                color: accountholdernamefocus.hasFocus
                                    ? primarycolor
                                    : Color(0xffB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
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
                        SizedBox(height: 14,),

                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: banknamefocus,
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
                              labelText: 'Bank Name',
                              labelStyle: TextStyle(
                                color: banknamefocus.hasFocus
                                    ? primarycolor
                                    : Color(0xffB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
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
                        SizedBox(height: 14,),

                        Container(
                          height: textFormFieldHeight45,
                          padding: EdgeInsets.symmetric(
                            horizontal: scrWidth * 0.015,
                            vertical: scrHeight*0.002,
                          ),
                          decoration: BoxDecoration(
                            color: textFormFieldFillColor,
                            borderRadius:
                            BorderRadius.circular(scrWidth * 0.026),
                          ),
                          child: TextFormField(
                            focusNode: ifsccodefocus,
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
                              labelText: 'IFSC Code',
                              labelStyle: TextStyle(
                                color: ifsccodefocus.hasFocus
                                    ? primarycolor
                                    : Color(0xffB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize15,
                                fontFamily: 'Urbanist',
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
                        ),],
                    ),
                    Text("Page Two"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>Kuri(),
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


    );
  }
}
