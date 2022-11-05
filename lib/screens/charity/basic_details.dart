import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:threems/screens/charity/cause_details.dart';

import '../../utils/themes.dart';
import '../splash_screen.dart';
 List dropdownItemList = [];
 List dropdownItems=[];
 List charityDetails=[];
 String? dropdownValue;
 class BasicDetails extends StatefulWidget {
  const BasicDetails({super.key});

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  final FocusNode orgNameFocus = FocusNode();
  final FocusNode charityTitleFocus = FocusNode();
  final FocusNode emailIdFocus = FocusNode();

 final TextEditingController orgnamecontroller =TextEditingController();
   final TextEditingController charitynamecontroller =TextEditingController();
 final  TextEditingController emailcontroller =TextEditingController();
  final  TextEditingController phonecontroller =TextEditingController();

  // List dropdownItemList = [
  //   {
  //     'label': 'Medical',
  //     'value': 'Mediacal',
  //     'icon': SvgPicture.asset(
  //       'assets/icons/medical.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //     'selectedIcon': SvgPicture.asset(
  //       'assets/icons/medical.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //   },
  //   {
  //     'label': 'Education',
  //     'value': 'Education',
  //     'icon': SvgPicture.asset(
  //       'assets/icons/education.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //     'selectedIcon': SvgPicture.asset(
  //       'assets/icons/education.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //   },
  //   {
  //     'label': 'Disaster',
  //     'value': 'Disaster',
  //     'icon': SvgPicture.asset(
  //       'assets/icons/disaster.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //     'selectedIcon': SvgPicture.asset(
  //       'assets/icons/disaster.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //   },
  //   {
  //     'label': 'Others',
  //     'value': 'Others',
  //     'icon': SvgPicture.asset(
  //       'assets/icons/others.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //     'selectedIcon': SvgPicture.asset(
  //       'assets/icons/others.svg',
  //       color: Colors.black,
  //       fit: BoxFit.contain,
  //     ),
  //   },
  // ];
  int causeId=0;
  getReasons() async {
    FirebaseFirestore.instance.collection('dropdown').snapshots().listen((event) {
      dropdownItemList = [];

      for( DocumentSnapshot <Map<String ,dynamic>> doc in event.docs){
        dropdownItemList.add(doc);
      }
      dropdownItems=[];
      if(dropdownItemList!=null){
        for(int i=0;i< dropdownItemList.length; i++){
        dropdownItems.add({
          'causeId':dropdownItemList[i]['causeId'],
          'label':dropdownItemList[i]['label'],
          'value':dropdownItemList[i]['value'],
          'image':Image(image:NetworkImage(dropdownItemList[i]['image'])),
        });
      }
      }else{
        return;
      }

      print(dropdownItems);
      print(dropdownValue);

      if(mounted){
        setState(() {

        });
      }
    });

  }
  bool loading=false;
  refreshPage() {
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getReasons();
    orgNameFocus.addListener(() {
      setState(() {});
    });
    charityTitleFocus.addListener(() {
      setState(() {});
    });
    emailIdFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    orgNameFocus.dispose();
    charityTitleFocus.dispose();
    emailIdFocus.dispose();
    super.dispose();
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
              child: Container(
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
          left: padding15, right: padding15, top: scrWidth * 0.05,
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
                    "BASIC DETAILS",
                    style: TextStyle(
                        fontSize: FontSize16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),

                  Container(
                    height: scrHeight*0.057,
                    width: scrWidth*0.33,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: scrWidth*0.02, color: Color(0xffECECEC)),
                    ),
                    child: Center(
                      child: Text(
                        '0% Completed',
                        style: TextStyle(
                          color: Color(0xff8391A1),
                          fontSize: FontSize10,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // PercentageWidget(percent: 50)
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scrWidth * 0.033),
                    ),
                    child: CoolDropdown(
                        resultReverse: false,
                        isAnimation: false,
                        dropdownItemAlign: Alignment.center,
                        dropdownHeight: scrHeight*0.35,
                        dropdownWidth: scrWidth*0.3,
                        dropdownItemGap: 2,
                        dropdownItemReverse: true,
                        dropdownItemTopGap: 2,
                        isTriangle: false,
                        defaultValue: dropdownItems[0],
                        resultIconRotation: false,
                        dropdownItemPadding: EdgeInsets.all(0),
                        dropdownItemMainAxis: MainAxisAlignment.spaceEvenly,
                        resultMainAxis: MainAxisAlignment.spaceEvenly,
                        dropdownItemBottomGap: 0,
                        iconSize: 12,
                        resultTS: TextStyle(
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8391A1)),
                        selectedItemTS: TextStyle(
                            fontSize: FontSize14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff8391A1)),
                        unselectedItemTS: TextStyle(
                            fontSize: FontSize14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff8391A1)),
                        // gap: 5,
                        dropdownBD: BoxDecoration(
                            color: Color(0xffD4D4D4),
                            borderRadius: BorderRadius.circular(8)),
                        dropdownPadding: EdgeInsets.all(10),
                        selectedItemPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: scrWidth*0.03),
                        selectedItemBD: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.033)),
                        resultBD: BoxDecoration(
                            color: textFormFieldFillColor,
                            border: Border.all(color: Color(0xffDADADA)),
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.033)),
                        // dropdownList: dropdownItems,
                        // onChange: (dropItem) {
                        //   var x = dropItem;
                        //   print('value of drop ${x}');
                        //   // print('value of drop ${x['selectedIcon']}');
                        // }),
                        dropdownList: dropdownItems,
                        onChange: (dropItem) {
                          var y=dropItem['image'];
                          var x = dropItem['value'];
                          causeId=dropItem['causeId'];
                          dropdownValue=x;
                          print(dropdownValue);
                          // var y=dropItem['image']+dropItem['value'];
                          // dropdown=y;
                        }
                  ),),
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
                  controller: orgnamecontroller,
                  focusNode: orgNameFocus,
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
                    labelText: 'Name/Organization Name',
                    labelStyle: TextStyle(
                      color: orgNameFocus.hasFocus
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
                  vertical: scrWidth*0.001,                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: charitynamecontroller,
                  focusNode: charityTitleFocus,
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
                    labelText: 'Charity Title',
                    labelStyle: TextStyle(
                      color: charityTitleFocus.hasFocus
                          ? primarycolor
                          : textFormUnFocusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    fillColor: textFormFieldFillColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                        left: scrWidth*0.03, top: scrHeight*0.001, bottom: scrWidth * 0.033),
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
                  vertical: scrWidth*0.002,                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailIdFocus,
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
                    labelText: 'Email ID',
                    labelStyle: TextStyle(
                      color: emailIdFocus.hasFocus
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
                  vertical: scrWidth*0.01,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                  ),
                  color: textFormFieldFillColor,
                  borderRadius: BorderRadius.circular(scrWidth * 0.026),
                ),
                child: TextFormField(
                  controller: phonecontroller,
                  keyboardType: TextInputType.phone,
                  // focusNode: emailIdFocus,
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
                    fillColor: textFormFieldFillColor,
                    filled: true,
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
                          color: Color(0xffDADADA),
                          thickness: 1,
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.only(
                        left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.033),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: scrWidth * 0.01,
              ),
              Text(
                "don’t worry your number will not share to anyone!",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                  fontSize: FontSize10,
                  fontFamily: 'Outfit',
                ),
              ),
              SizedBox(
                height: scrWidth * 0.04,
              ),
              // Container(
              //   width: scrWidth,
              //   height: textFormFieldHeight45,
              //   padding: EdgeInsets.symmetric(
              //     horizontal: scrWidth * 0.015,
              //     vertical: scrHeight*0.015,
              //   ),
              //   decoration: BoxDecoration(
              //     color: textFormFieldFillColor,
              //     border: Border.all(
              //       color: Color(0xffDADADA),
              //     ),
              //     borderRadius: BorderRadius.circular(scrWidth * 0.026),
              //   ),
              //   child: Padding(
              //     padding:  EdgeInsets.symmetric(horizontal: scrWidth*0.025),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Upload your photo",
              //           style: TextStyle(
              //             color: Color(0xff8391A1),
              //             fontWeight: FontWeight.w500,
              //             fontSize: FontSize15,
              //             fontFamily: 'Urbanist',
              //           ),
              //         ),
              //         SvgPicture.asset(
              //           'assets/icons/camera2.svg',
              //           color: Color(0xff8391A1),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height:scrHeight*0.256,
              ),
              GestureDetector(
                onTap: () {
                   if(orgnamecontroller.text.isEmpty&&
                       charitynamecontroller.text.isEmpty&&
                       emailcontroller.text.isEmpty&&
                        phonecontroller.text.isEmpty
                   ){
                     refreshPage();
                     return showSnackbar();
                   }else{
                     charityDetails.add(
                        {
                          'cause': causeId,
                          'orgName': orgnamecontroller.text,
                          'charityDetailes': charitynamecontroller.text,
                          'emailId': emailcontroller.text,
                          'phoneNumber': phonecontroller.text,
                          'reason':dropdownValue,

                        }
                     );
                     print(charityDetails.toString());
                     print(dropdownValue);
                     print(causeId);
                   }
                   Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CauseDetails(),
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
                ),
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
