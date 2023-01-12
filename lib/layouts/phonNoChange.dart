import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:threems/Authentication/auth.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/layouts/phoneNumberChangeOtpPage.dart';
import 'package:threems/screens/charity/verification_details.dart';
import 'package:threems/screens/splash_screen.dart';

import '../kuri/createkuri.dart';
import '../model/usermodel.dart';
import '../pagess/otppage.dart';
import '../utils/themes.dart';

class PhoneNoChangePage extends StatefulWidget {
  final String phoneNo;
  const PhoneNoChangePage({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<PhoneNoChangePage> createState() => _PhoneNoChangePageState();
}

class _PhoneNoChangePageState extends State<PhoneNoChangePage> {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;


  String? verificationId;
  String? otp, authStatus = "";

  Future<void> verifyPhoneNumber(BuildContext context) async {
    print(phoneController.text);
    await phoneAuth.verifyPhoneNumber(
      phoneNumber: '+91${phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // showSnackbar(context, 'OTP sent successfully.');
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String? verficationID, int? resendToken) {
        setState(() {
          verificationId = verficationID;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PhoneChangeOtpPage(
                  number: phoneController.text,
                  verId: verificationId!,
                )));
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          verificationId = verificationID;
        });
      },
      timeout: const Duration(seconds: 120),
    );
  }
  final FirebaseAuth phoneAuth = FirebaseAuth.instance;
  @override
  void initState() {
    phoneController.text=widget.phoneNo!;
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return loading==true?Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(child: CircularProgressIndicator())):
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: scrWidth*0.04,top: scrHeight*0.034),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Update Phone Number",style: TextStyle(
              fontSize: 22,fontFamily: 'Urbanist',fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 50,),
            Form(
              key:_formkey ,
              child: Padding(
                padding:  EdgeInsets.only(right: 15),
                child: Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight * 0.002,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDADADA),
                    ),
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      String patttern =
                          r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value!.length == 0) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value!)) {
                        return 'Please enter valid mobile  number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: phoneController,
                    focusNode: phoneFocus,
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
                      labelText: 'Enter Phone Number',
                      labelStyle: TextStyle(
                        color: phoneFocus.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
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
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
           InkWell(
              onTap: () async {
                if(phoneController.text!=''){


                QuerySnapshot usrs = await FirebaseFirestore.instance
                    .collection('users').where('phone',
                    whereIn:[phoneController.text,
                  "+91${phoneController.text}",
                  "+91 ${phoneController.text}"])
                    .get();
                if(usrs.docs.length==0){
                  if (_formkey.currentState!.validate()) {
                    // FirebaseFirestore.instance
                    //     .collection('users').doc(currentuserid).update({
                    //   'phone':phoneController.text
                    //
                    // });
                    // // await getcurrentuser() ;
                    // showUploadMessage(context, 'Phone number updated successfully');
                    // Navigator.pop(context);
                    verifyPhoneNumber(context);
                  }
                }else{
                  showUploadMessage(context, 'Phone number already exist');
                }


                }else{
                  showUploadMessage(context, 'Enter your new phone number');
                }
              },
              child: Center(
                child: Container(
                  height: 45,
                  width: 230,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Urbanist'),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
