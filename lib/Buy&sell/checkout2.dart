import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';

import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'checkout.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key, }) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController nameController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController pinCodeController=TextEditingController();
  final TextEditingController flatNoController=TextEditingController();
  final TextEditingController localityController=TextEditingController();


  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();
  FocusNode flatNoFocusNode = FocusNode();
  FocusNode localityFocusNode = FocusNode();
  String purpose = 'Home';
  int selectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: scrWidth*0.06,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: scrHeight * 0.09,
                         left: scrWidth * 0.03,
                      ),
                      child: Container(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          "assets/icons/arrow.svg",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:scrHeight*0.09,left: scrWidth*0.04),
                    child: Text(
                      "Address",
                      style: TextStyle(
                          fontSize: scrWidth * 0.046,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height:scrHeight*0.037,),
              Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: EdgeInsets.only(left: scrWidth*0.075,right: scrWidth*0.075),
                  child: Column(
                    children: [
                      Container(
                        width: scrWidth,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrHeight*0.002,
                        ),
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        ),
                        child: TextFormField(
                          controller: nameController,
                          focusNode: nameFocusNode,
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
                              color: nameFocusNode.hasFocus
                                  ? primarycolor
                                  : textFormUnFocusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: scrHeight*0.01,
                                bottom: scrWidth * 0.033,
                                left: scrWidth * 0.033),
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
                      SizedBox(height: scrHeight*0.025,),

                      Container(
                        width: scrWidth,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrHeight*0.002,
                        ),
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        ),
                        child: TextFormField(
                       validator: (value){
                         String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                         RegExp regExp = new RegExp(pattern);
                         if (value!.length == 0) {
                           return 'Please enter mobile number';
                         }
                         else if (!regExp.hasMatch(value)) {
                           return 'Please enter valid mobile number';
                         }
                         return null;
                       },

                        controller: phoneController,
                          keyboardType: TextInputType.number,
                          focusNode: phoneFocusNode,
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
                              color: phoneFocusNode.hasFocus
                                  ? primarycolor
                                  : textFormUnFocusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: scrHeight*0.01,
                                bottom: scrWidth * 0.033,
                                left: scrWidth * 0.033),
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
                      SizedBox(height: scrHeight*0.025,),

                      Container(
                        width: scrWidth,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrHeight*0.002,
                        ),
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        ),
                        child: TextFormField(
                          controller: pinCodeController,
                          keyboardType: TextInputType.number,
                          focusNode: pinCodeFocusNode,
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
                            labelText: 'pinCode',
                            labelStyle: TextStyle(
                              color: pinCodeFocusNode.hasFocus
                                  ? primarycolor
                                  : textFormUnFocusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: scrHeight*0.01,
                                bottom: scrWidth * 0.033,
                                left: scrWidth * 0.033),
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
                      SizedBox(height: scrHeight*0.025,),

                      Container(
                        width: scrWidth,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrHeight*0.002,
                        ),
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        ),
                        child: TextFormField(
                          controller: localityController,
                          focusNode: localityFocusNode,
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
                            labelText: 'Locality',
                            labelStyle: TextStyle(
                              color: localityFocusNode.hasFocus
                                  ? primarycolor
                                  : textFormUnFocusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: scrHeight*0.01,
                                bottom: scrWidth * 0.033,
                                left: scrWidth * 0.033),
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
                      SizedBox(height: scrHeight*0.025,),

                      Container(
                        width: scrWidth,
                        height: textFormFieldHeight45,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrHeight*0.002,
                        ),
                        decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        ),
                        child: TextFormField(
                          controller: flatNoController,
                          keyboardType: TextInputType.number,
                          focusNode: flatNoFocusNode,
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
                            labelText: 'Flat No',
                            labelStyle: TextStyle(
                              color: flatNoFocusNode.hasFocus
                                  ? primarycolor
                                  : textFormUnFocusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            fillColor: textFormFieldFillColor,
                            filled: true,
                            contentPadding: EdgeInsets.only(
                                top: scrHeight*0.01,
                                bottom: scrWidth * 0.033,
                                left: scrWidth * 0.033),
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
                ),
              ),
              SizedBox(height: scrHeight*0.02,),
              Row(
                children: [
                  SizedBox(width: scrWidth*0.075,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = 1;
                        purpose = 'Home';
                      });
                    },
                    child: Container(
                      width: scrWidth*0.24,
                      height: textFormFieldHeight45,
                      decoration: BoxDecoration(
                        color:selectedIndex == 1? primarycolor:textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: Center(
                        child: Text("Home",style:  TextStyle(
                          color:selectedIndex==1?Colors.white: textFormUnFocusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(width: scrWidth*0.056,),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = 0;
                        purpose = 'Work';
                      });
                    },
                    child: Container(
                      width:  scrWidth*0.24,
                      height: textFormFieldHeight45,
                      decoration: BoxDecoration(
                        color:selectedIndex==0?primarycolor: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: Center(
                        child: Text("Work",style:  TextStyle(
                          color:selectedIndex==0?Colors.white: textFormUnFocusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(width: scrWidth*0.056,),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = 2;
                        purpose = 'Other';
                      });
                    },
                    child: Container(
                      width: scrWidth*0.24,
                      height: textFormFieldHeight45,
                      decoration: BoxDecoration(
                        color: selectedIndex==2?primarycolor:textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child: Center(
                        child: Text("Other",style:  TextStyle(
                          color:selectedIndex==2?Colors.white: textFormUnFocusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                          fontFamily: 'Urbanist',
                        ),),
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: 20,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 22,right: 22),
              //   child: Container(
              //     height: textFormFieldHeight45,
              //     width: scrWidth,
              //     decoration: BoxDecoration(
              //         color: primarycolor,
              //         borderRadius: BorderRadius.circular(8)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset("assets/icons/crtlocation.svg"),
              //         SizedBox(width: scrWidth*0.03,),
              //         Text(
              //           "Use My Current Location",
              //           style: TextStyle(color: Colors.white,fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w600),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: scrHeight*0.25,),
              GestureDetector(
                onTap: (){
                  if (_formkey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
                      'address':FieldValue.arrayUnion(
                          [
                            {
                              'phoneNumber':phoneController.text,
                              'locality':localityController.text,
                              'pinCode':pinCodeController.text,
                              'name':nameController.text,
                              'select':purpose,
                              'flatNo':flatNoController.text,
                              'date':DateFormat.yMMMd().format(DateTime.now()),
                            }
                          ]
                      ),
                      // 'totalReceived':
                      // FieldValue.increment(double.tryParse(valueAmountController.text)!)
                    }

                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage()));

                  }

                },
                child: Container(
                  height: scrHeight*0.05,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius
                        .circular(8),),
                  child:Center(
                    child: Text("Add Address",style: TextStyle(
                        fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 13,color: Colors.white
                    ),),
                  ) ,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
