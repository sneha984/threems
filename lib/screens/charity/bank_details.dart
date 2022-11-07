import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/charity/verification_details.dart';
import '../../customPackage/date_picker.dart';
import '../../model/charitymodel.dart';
import '../../utils/themes.dart';
import '../../widgets/percentage_widget.dart';
import '../splash_screen.dart';
import 'basic_details.dart';
import 'cause_details.dart';

class CreateCharity3 extends StatefulWidget {
  const CreateCharity3({super.key});

  @override
  State<CreateCharity3> createState() => _CreateCharity3State();
}

class _CreateCharity3State extends State<CreateCharity3> {
  final _formkey = GlobalKey<FormState>();

  final FocusNode accountNumberFocus = FocusNode();
  final FocusNode confirmAccountNumberFocus = FocusNode();
  final FocusNode accountHolderNameFocus = FocusNode();
  final FocusNode bankNameFocus = FocusNode();
  final FocusNode ifscCodeFocus = FocusNode();

  final  TextEditingController accountnumcontroller =TextEditingController();
  final  TextEditingController confirmaccountcontroller =TextEditingController();
  final  TextEditingController accountholdernamecontroller =TextEditingController();
  final  TextEditingController banknamecontroller =TextEditingController();
  final  TextEditingController ifsccodecontroller =TextEditingController();
  final  TextEditingController youtubelinkcontroller=TextEditingController();

  @override
  void initState() {
    accountNumberFocus.addListener(() {
      setState(() {});
    });
    confirmAccountNumberFocus.addListener(() {
      setState(() {});
    });
    accountHolderNameFocus.addListener(() {
      setState(() {});
    });
    bankNameFocus.addListener(() {
      setState(() {});
    });
    ifscCodeFocus.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    accountNumberFocus.dispose();
    confirmAccountNumberFocus.dispose();
    accountHolderNameFocus.dispose();
    bankNameFocus.dispose();
    ifscCodeFocus.dispose();
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
                    "BANK DETAILS",
                    style: TextStyle(
                        fontSize: FontSize16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  PercentageWidget(percent: 50),
                ],
              ),
              SizedBox(
                height: scrWidth * 0.08,
              ),
              Form(
                key:_formkey ,
                child: Column(
                  children: [
                    Container(
                      width: scrWidth,
                      height: textFormFieldHeight45,
                      padding: EdgeInsets.symmetric(
                        horizontal: scrWidth * 0.015,
                        vertical:scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TextFormField(
                        controller: accountnumcontroller,
                        focusNode: accountNumberFocus,
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
                            color: accountNumberFocus.hasFocus
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
                        vertical: scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TextFormField(
                          validator:  (value){
                          if (value!.length == 0) {
                          return 'Please enter confirm account number';
                          }
                          else if (value!=accountnumcontroller.text) {
                          return 'sucessfully completed';
                          }
                          return null;
                          },
                        controller: confirmaccountcontroller,
                        focusNode: confirmAccountNumberFocus,
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
                            color: confirmAccountNumberFocus.hasFocus
                                ? primarycolor
                                : textFormUnFocusColor,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                          ),

                          fillColor: textFormFieldFillColor,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              left: scrWidth*0.03, top: scrHeight*0.006,),
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
                        vertical: scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TextFormField(
                        controller: accountholdernamecontroller,
                        focusNode: accountHolderNameFocus,
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
                            color: accountHolderNameFocus.hasFocus
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
                        vertical: scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TextFormField(
                        controller: banknamecontroller,
                        focusNode: bankNameFocus,
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
                            color: bankNameFocus.hasFocus
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
                        vertical: scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: TextFormField(
                        controller: ifsccodecontroller,
                        focusNode: ifscCodeFocus,
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
                            color: ifscCodeFocus.hasFocus
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
                    SizedBox(
                      height: scrHeight*0.3,
                    ),


                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  if (accountnumcontroller.text.isEmpty &&
                      confirmaccountcontroller.text.isEmpty &&
                      accountholdernamecontroller.text.isEmpty &&
                      banknamecontroller.text.isEmpty &&
                      ifsccodecontroller.text.isEmpty
                  ) {
                    refreshPage();
                    return showSnackbar("enter all details");
                  } else {
                    charityDetails.add(
                        {
                          "accountNumber": accountnumcontroller.text,
                          "confirmAccountNumber": confirmaccountcontroller.text,
                          "accountHolderName": accountholdernamecontroller.text,
                          "bankName": banknamecontroller.text,
                          "ifscCode": ifsccodecontroller.text
                        }

                    );
                    if (_formkey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('succesfully completed '),
                        ),
                      );
                    }

                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => VerificationDetails(),
                        ));
                  }

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
  showSnackbar(String msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(msg,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
