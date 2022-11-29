import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';

import '../kuri/createkuri.dart';
import '../pagess/otppage.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'auth.dart';

class AddPhone extends StatefulWidget {
  final String id;
  const AddPhone({Key? key, required this.id}) : super(key: key);

  @override
  State<AddPhone> createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  final TextEditingController phoneNumber = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  String? verificationId;
  String? otp, authStatus = "";

  Future<void> verifyPhoneNumber(BuildContext context) async {
    print(phoneNumber.text);
    await phoneAuth.verifyPhoneNumber(
      phoneNumber: '+91${phoneNumber.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        showSnackbar(context, 'OTP sent successfully.');
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String? verficationID, int? resendToken) {
        setState(() {
          verificationId = verficationID;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPage(
                      number: phoneNumber.text,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.03,
                left: scrWidth * 0.07,
                bottom: scrHeight * 0.02,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          behavior:
          HitTestBehavior.opaque;

          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.only(left: scrWidth * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: scrHeight * 0.008,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your mobile number",
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        fontSize: scrWidth * 0.05),
                  ),
                  SizedBox(
                    height: scrHeight * 0.008,
                  ),
                  Text(
                    "We'll send you a 6 digit OTP on your \n mobile number for verification",
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        fontSize: scrWidth * 0.035,
                        color: Color(0xff000000).withOpacity(0.5)),
                  ),
                ],
              ),
              SizedBox(
                height: scrHeight * 0.048,
              ),
              Container(
                height: scrHeight * 0.055,
                width: scrWidth * 0.87,
                decoration: BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    SizedBox(
                      width: scrWidth * 0.029,
                    ),
                    Container(
                      height: 20,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/icons/Flag_of_India 1.png"),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: scrWidth * 0.011,
                    ),
                    Text(
                      "+91",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: scrWidth * 0.011,
                    ),
                    Container(
                      width: scrWidth * 0.005,
                      height: scrHeight * 0.055,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: scrWidth * 0.011,
                    ),
                    Form(
                      key: _formkey,
                      child: Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          validator: (value) {
                            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          autofocus: false,
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 11, right: 3, bottom: 5),
                            errorStyle: TextStyle(fontSize: 9, height: 0.3),
                            border: InputBorder.none,
                            hintText: "XXXXXXXXXX",
                            hintStyle: TextStyle(
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          cursorWidth: 0.5,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: scrHeight * 0.009,
              ),
              Padding(
                padding: EdgeInsets.only(left: scrWidth * 0.03),
                child:
                    Text("don't worry your number will not share to anyone! ",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xff000000).withOpacity(0.4),
                        )),
              ),
              SizedBox(
                height: scrHeight * 0.047,
              ),
              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.id)
                        .update({'phone': phoneNumber.text}).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Rootingpage()));
                    });
                  }
                },
                child: Container(
                  height: scrHeight * 0.055,
                  width: scrWidth * 0.87,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Update Phone Number",
                      style: style,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
